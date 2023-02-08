output "vm_default_ips" {
  value = [ for value in vsphere_virtual_machine.vm : value.default_ip_address ]
}
