# Create Confluent Network
resource "confluent_network" "confluent_private_link" {
  display_name     = "${var.env}-private-link"
  cloud            = var.cloud
  region           = var.region
  connection_types = var.connection_types
  environment {
    id = confluent_environment.confluent_env.id
  }
  dns_config {
    resolution = var.dns_config_resolution
  }
}

# Create Confluent Private Link for Azure
resource "confluent_private_link_access" "cloud_link" {
  display_name = "${var.cloud}-private-link"
  azure {
    subscription = var.subscription_id
  }
  environment {
    id = confluent_environment.confluent_env.id
  }
  network {
    id = confluent_network.confluent_private_link.id
  }
}