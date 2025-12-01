# Create Confluent SA
resource "confluent_service_account" "kafka_service_account" {
  display_name = "${var.env}-kafka-sa"
}

# Assign Role to Create Topics on the Cluster
resource "confluent_role_binding" "kafka_service_account_role_binding" {
  principal   = "User:${confluent_service_account.kafka_service_account.id}"
  role_name   = "DeveloperManage"
  crn_pattern = confluent_kafka_cluster.confluent_cluster.rbac_crn
}

# Create Confluent SA Key
resource "confluent_api_key" "kafka_service_account_api_key" {
  display_name = "${var.env}-kafka-api-key"
  owner {
    id          = confluent_service_account.kafka_service_account.id
    api_version = confluent_service_account.kafka_service_account.api_version
    kind        = confluent_service_account.kafka_service_account.kind
  }

  managed_resource {
    id          = confluent_kafka_cluster.confluent_cluster.id
    api_version = confluent_kafka_cluster.confluent_cluster.api_version
    kind        = confluent_kafka_cluster.confluent_cluster.kind

    environment {
      id = confluent_environment.confluent_env.id
    }
  }
}

# Bind Confluent SA to Role
resource "confluent_kafka_acl" "kafka_produce_acl" {
  kafka_cluster {
    id = confluent_kafka_cluster.confluent_cluster.id
  }
  resource_type = "TOPIC"
  resource_name = confluent_kafka_topic.kafka_orders.topic_name
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.kafka_service_account.id}"
  host          = "*"
  operation     = "WRITE"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.confluent_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka_service_account_api_key.id
    secret = confluent_api_key.kafka_service_account_api_key.secret
  }
}

# Bind Confluent SA to Role
resource "confluent_kafka_acl" "kafka_consume_acl" {
  kafka_cluster {
    id = confluent_kafka_cluster.confluent_cluster.id
  }
  resource_type = "TOPIC"
  resource_name = confluent_kafka_topic.kafka_payments.topic_name
  pattern_type  = "LITERAL"
  principal     = "User:${confluent_service_account.kafka_service_account.id}"
  host          = "*"
  operation     = "READ"
  permission    = "ALLOW"
  rest_endpoint = confluent_kafka_cluster.confluent_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka_service_account_api_key.id
    secret = confluent_api_key.kafka_service_account_api_key.secret
  }
}