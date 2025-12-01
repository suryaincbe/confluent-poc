# Create Confluent Environment
resource "confluent_environment" "confluent_env" {
  display_name = var.env

  stream_governance {
    package = "ESSENTIALS"
  }
}

# Create Confluent Kafka Cluster
resource "confluent_kafka_cluster" "confluent_cluster" {
  display_name = "${var.env}-cluster"
  availability = "SINGLE_ZONE"
  cloud        = var.cloud
  region       = var.region
  dedicated {
    cku = 1
  }
  environment {
    id = confluent_environment.confluent_env.id
  }
  network {
    id = confluent_network.confluent_private_link.id
  }
}