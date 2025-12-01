# Create Confluent Topics
resource "confluent_kafka_topic" "kafka_orders" {
  kafka_cluster {
    id = confluent_kafka_cluster.confluent_cluster.id
  }
  topic_name    = "${var.env}-orders"
  rest_endpoint = confluent_kafka_cluster.confluent_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka_service_account_api_key.id
    secret = confluent_api_key.kafka_service_account_api_key.secret
  }
}

# Create Confluent Topics
resource "confluent_kafka_topic" "kafka_payments" {
  kafka_cluster {
    id = confluent_kafka_cluster.confluent_cluster.id
  }
  topic_name    = "${var.env}-payments"
  rest_endpoint = confluent_kafka_cluster.confluent_cluster.rest_endpoint
  credentials {
    key    = confluent_api_key.kafka_service_account_api_key.id
    secret = confluent_api_key.kafka_service_account_api_key.secret
  }
}