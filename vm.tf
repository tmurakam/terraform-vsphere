data "vsphere_datastore" "ds" {
  for_each = toset(flatten([for vm in var.vms : vm.datastore_name]))

  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_virtual_machine" "template" {
  name          = var.vm_template_name
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


resource "vsphere_virtual_machine" "vm" {
  for_each = var.vms

  name             = each.value.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds[each.value.datastore_name].id

  num_cpus         = var.vm_num_cpus
  memory           = var.vm_memory
  guest_id         = data.vsphere_virtual_machine.template.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label = "disk0"
    size  = var.vm_disk_size
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
    customize {
      linux_options {
        host_name = each.value.name
        domain    = var.domain_name
      }
      network_interface {
        ipv4_address = var.dhcp ? null : each.value.ipv4_address
        ipv4_netmask = var.dhcp ? null : each.value.ipv4_netmask
      }
      ipv4_gateway = var.dhcp ? null : each.value.ipv4_gateway
      dns_server_list = var.dhcp ? null : var.dns_servers
    }
  }
}
