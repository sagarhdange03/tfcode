provider "aws" {
  region              = "ap-south-1"
  allowed_account_ids = [434605749312]
  default_tags {
    tags = {
      environment = var.env
      managedby   = "terraform"
    }
  }
}
terraform {
 required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.83.0"
    }
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
  }
  required_version = ">=1.0.0"
   

}

