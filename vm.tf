data "vsphere_datastore" "ds" {
  for_each = toset(flatten([for vm in var.vms : vm.datastore_name]))

  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_datastore" "iso_ds" {
  for_each = toset(flatten([for vm in var.vms : vm.iso_datastore_name]))

  name          = each.value
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

resource "vsphere_virtual_machine" "vm" {
  for_each = var.vms

  name             = each.value.name
  resource_pool_id = data.vsphere_compute_cluster.cluster.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds[each.value.datastore_name].id

  num_cpus         = 4
  memory           = 4096
  guest_id         = each.value.guest_id

  network_interface {
    network_id = data.vsphere_network.network.id
  }
  disk {
    label = "disk0"
    size  = 64
  }
  cdrom {
    datastore_id = data.vsphere_datastore.iso_ds[each.value.iso_datastore_name].id
    path = each.value.iso_path
  }
}
