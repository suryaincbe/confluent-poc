# Terraform to Create Azure VPC/Subnets, Confluent Kafka Cluster, Topics, ACL and Private Endpoints

## Terraform Files to Create the Required Resources

# 1. cloud-network.tf
   1. Used as module. Module present in modules/cloud-network folder.
   2. VPC created in azure cloud by default.
   3. Customizable variables in this file are vnet_location, resource_group_name, address_space and subnet_prefixes
   4. vnet location should be as your confluent cloud location.
   5. exported output varibles are subnet_id and vpc_id.

# 2. cloud-endpoints.tf
   1. Creates private DNS zone for the newly created Confluent Cloud.
   2. Links the created DNS to the VPC.
   3. Create the endpoints for connectivity between Confluent Cloud and Azure VPC
   4. Create DNS for Confluent Cloud Alias.
   5. Variables are resource_group_name and env.

# 3. confluent-network.tf
   1. Creates a confluent network in the Confluent Cloud and the Private access with the Cloud environment.
   2. Customizable variables in this file are region, cloud, connection_types, dns_config and subscription (in case of azure, account in case of aws, projects in case of gcp).
   3. connection_types, dns_config are default variables present in variables.tf, they can be modifiled in tfvars file if required.
   4. variables cloud, region are present in tfvars, they can be modified as per requirement.

# 4. confluent-cluster.tf
   1. Creates a single zone cluster in the Confluent Cloud.
   2. env variable can be modified in tfvars depending upon the environment.
   3. Cluster name will depend on the env variable.

# 5. confluent-kafka-topics.tf
   1. Creates two topics for order and payments as per requirement.
   2. env variable in this file will be aligned as per the value in tfvars.

# 6. confluent-sa-acl.tf
   1. Creates one service account as per requirement.
   2. Provides the minimum role required (follows POLP) to create the topics in the cluster.
   3. Creates an API key for the service account to connect to the cluster.
   4. Binds a create topic role for the service account in the newly created cluster.
   5. Binds a read topic role for the service account in the newly created cluster.

# 7. provider.tf
   1. Contains the provider required to use the API's required for Confluent Cloud/Azure.
   2. Backend block has been configured to store the terraform state files in a bucket for versioning.
   3. Subscription ID of the Azure project can be passed in this file as var.subscription variable.
   4. Confluent cloud keys can be passed as hardcoded (not safe), environment variable, passed from azure secret manager.

# 8. env-config/test.tfvars
    1. tfvars file which can be modified as per the region, subscription id, vnet location, vpc ip address.
   

## To Create the Resources

```bash
cd terraform
terraform init
terraform plan -var-file="env-config/test.tfvars"
terraform apply -var-file="env-config/test.tfvars"
```

## Verification

1. Create a VM in the same VPC.
2. Assign the application to use the confluent service account.
3. Make sure the application is able to create/read messages in the Confluent cluster.