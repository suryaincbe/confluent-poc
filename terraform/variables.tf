# Confluent Cloud Variables

variable "connection_types" {
  type        = list(string)
  description = "Network connection types"
  default = ["PRIVATELINK"]
}

variable "dns_config_resolution" {
  type = string
  description = "Region of Confluent Cluster"
  default = "PRIVATE"
}

variable "env" {
  type = string
  description = "Confluent Environment"
}

variable "cloud" {
  type = string
  description = "Cloud provider"
}

variable "subscription_id" {
  type = string
  description = "Subscription ID in Azure"
}

variable "region" {
  type = string
  description = "Region of Confluent Cluster"
}
##

# Cloud VPC/Subnet Variables

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "vnet_location" {
  description = "Location of the Vnet"
  type        = string
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["0.0.0.0/0"]
}

variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  type        = list(string)
  default     = []
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

##