# Create Cloud Network and Subnets
module vpc {
  source = "modules/cloud-network"

  vnet_name           = "${var.env}-vnet"
  resource_group_name = var.resource_group_name
  vnet_location       = var.vnet_location
  address_space       = var.address_space
  subnet_name         = "${var.env}-subnet"
  subnet_prefixes     = var.subnet_prefixes

}