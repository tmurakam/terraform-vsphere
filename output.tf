output "vm_ips" {
  value = [ for value in vsphere_virtual_machine.vm : value.default_ip_address ]
}

output "vm" {
  value = [ for value in vsphere_virtual_machine.vm : {
    name = value.name
    default_ip = value.default_ip_address
    guest_ips = value.guest_ip_addresses
    host_system_id = value.host_system_id
  }]
}

