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
    key            = "env:/terraform.tfstate"
    region         = "us-east-2"
    use_lock_table = true  # ✅ replaces `dynamodb_table`
  }
}
