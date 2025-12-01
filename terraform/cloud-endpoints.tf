# Create Private DNS for Confluent Cloud Alias
resource "azurerm_private_dns_zone" "private_dns" {
  resource_group_name = var.resource_group_name
  name = confluent_network.confluent_private_link.dns_domain
}

# Create Private Endpoint for Confluent Cloud Alias
resource "azurerm_private_endpoint" "private_endpoint" {
  name                = "${var.env}-confluent-endpoint"
  location            = var.region
  resource_group_name = var.resource_group_name

  subnet_id = module.vpc.subnet_id

  private_service_connection {
    name                              = "${var.env}-confluent-private-service"
    is_manual_connection              = true
    private_connection_resource_alias = values(confluent_network.confluent_private_link.azure[0].private_link_service_aliases)[0]
    request_message                   = "Connection from Azure"
  }
}

# Create Link Between Confluent Cloud Alias and Cloud VPC
resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_network_link" {
  name                  = "${var.env}-private-dns-network-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = module.vpc.vpc_id
}

# Create A Record DNS for Domain Resolution
resource "azurerm_private_dns_a_record" "azure_dns_record" {

  name                = "*"
  zone_name           = azurerm_private_dns_zone.private_dns.name
  resource_group_name = var.resource_group_name
  ttl                 = 60
  records = [
    azurerm_private_endpoint.private_endpoint.private_service_connection[0].private_ip_address
  ]
}

