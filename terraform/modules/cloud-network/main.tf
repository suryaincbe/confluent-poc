# Create VPC in Azure
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
  location            = var.vnet_location
  address_space       = var.address_space
}

# Create Subnet in Azure
resource "azurerm_subnet" "subnet" {
  name                                          = var.subnet_name
  resource_group_name                           = var.resource_group_name
  virtual_network_name                          = var.vnet_name
  address_prefixes                              = var.subnet_prefixes
  private_endpoint_network_policies             = "Disabled"
}
