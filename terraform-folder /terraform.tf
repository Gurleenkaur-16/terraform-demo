terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

backend "s3"{
    bucket = "gurleen-terraform-bucket"
    key = "terraform.tfstate"
    region = "eu-west-1"
    dynamodb_table = "gurleen-terraform-dynamodb-table"
}
}
