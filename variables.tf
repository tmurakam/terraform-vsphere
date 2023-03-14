variable "vcenter_server" {
  description = "FQDN of vCenter server"
  default = ""
}

variable "user" {
  description = "username of vCenter server"
  default = ""
}

variable "password" {
  description = "password of vCenter server"
  default = ""
}

variable "datacenter" {
  description = "Datacenter name"
  default = ""
}

variable "cluster" {
  description = "Compute cluster name"
  default = ""
}

variable "network" {
  description = "Network name"
  default = "VM Network"
}

variable "domain_name" {
  description = "domain name of each VM"
  default = "example.com"
}

variable "dhcp" {
  description = "Use DHCP to allocate IP to VM"
  default = true
}

variable "dns_servers" {
  description = "Array of DNS server. Ignored if dhcp is true"
  default = []
}

variable "vm_template_name" {
  description = "VM template name"
  default = ""
}

variable "vm_folder" {
  description = "Path of VM folder"
  default = null
}

variable "vm_num_cpus" {
  description = "Number of cpus of VM"
  default = 4
}

variable "vm_memory" {
  description = "Memory size of VM (MB)"
  default = 4096
}

variable "vm_disk_size" {
  description = "VM disk size (GB)"
  default = 64
}

variable "vms" {
  description = "VM parameters"
  default = {}
}

