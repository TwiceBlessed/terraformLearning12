variable "resource-group" {
  type        = string
  description = "RG name"
}

variable "location" {
  type        = string
  description = "location of the resources"
}

variable "vnets" {
  type = map(object({
    name          = string
    address_space = list(string)
  }))
}

variable "subnets" {
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))
}

variable "nic" {
  type = map(object({
    name       = string
    subnet_key = string
  }))
}

variable "vm-name" {
  type = map(object({
    name    = string
    size    = string
    nic_key = string
  }))
}