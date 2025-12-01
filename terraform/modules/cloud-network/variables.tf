variable "vnet_name" {
  description = "Name of the vnet to create"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_location" {
  description = "Name of the resource group"
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["0.0.0.0/0"]
}

variable "subnet_name" {
  description = "Name of the subnet to create"
  type        = string
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}
