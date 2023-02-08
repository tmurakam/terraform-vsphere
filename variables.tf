variable "user" {
  default = ""
}

variable "password" {
  default = ""
}

variable "vcenter_server" {
  default = ""
}

variable "datacenter" {
  default = ""
}

variable "cluster" {
  default = ""
}

variable "network" {
  default = "VM Network"
}

variable "domain_name" {
  description = "domain name of each VM"
  default = "example.com"
}

variable "vm_template_name" {
  description = "VM template name"
  default = ""
}

variable "vm_num_cpus" {
  default = 4
}

variable "vm_memory" {
  default = 4096
}

variable "vm_disk_size" {
  description = "VM disk size"
  default = 64
}

variable "vms" {
  default = {}
}

