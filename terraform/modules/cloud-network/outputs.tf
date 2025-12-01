output "subnet_id" {
  description = "The id of the newly created subnet"
  value       = azurerm_subnet.subnet.id
}

output "vpc_id" {
  description = "The id of the newly created vpc"
  value = azurerm_virtual_network.vnet.id
}