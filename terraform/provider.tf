terraform {
  required_version = ""
  backend "azurerm" {
    subscription_id      = ""
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
  }
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = ""
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ""
    }
  }
}

provider "azurerm" {
  subscription_id = ""
}

# Key and Secret can be pulled from data blocks or from gitlab variables
provider "confluent" {
  cloud_api_key    = ""
  cloud_api_secret = ""
}