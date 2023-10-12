 terraform {
  backend "s3" {
     bucket = "project-group-1"
     key    = "project/terraform.tfstate"
     region = "us-east-1"
     dynamodb_table = "lock-state"
  }
 }