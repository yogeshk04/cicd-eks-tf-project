terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.57.1"
    }
  }
}

provider "aws" {
  region                   = "eu-central-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                  = "dev"
}
