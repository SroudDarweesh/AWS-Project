terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}
terraform {
  backend "s3" {
    bucket         = "your-terraform-state-bucket"
    key            = "aws-project/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "terraform-locks" # Optional for state locking
  }
}
