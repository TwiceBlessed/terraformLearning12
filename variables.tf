variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
  default = "West Europe"
}

variable "vnet_name" {
    type = string
}

variable "vnet_address_space"{
  type = list(string)
}

variable "subnets_details" {
  type = map(object({
    name = string
    address_prefixes = list(string)
  }))
}

variable "win_vms" {
  type = map(object({
    name = string
    size = string
    subnet_key = string
  }))
}