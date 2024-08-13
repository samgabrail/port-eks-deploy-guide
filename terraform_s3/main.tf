terraform {
  backend "s3" {
    bucket = "tekanaid-terraform-state-workshop"
    # key            = "workshop1-tekanaidtest/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    kms_key_id     = "alias/terraform-bucket-key"
    dynamodb_table = "terraform-state"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.7.0"
    }
    port = {
      source  = "port-labs/port-labs"
      version = "2.0.0"
    }
  }

  required_version = "~> 1.3"
}

provider "aws" {
  region = var.region
}

provider "port" {
}

# S3 Bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = var.bucket_name
}

# Port resources
resource "port_entity" "s3_bucket" {
  identifier = aws_s3_bucket.mybucket.arn
  title      = var.bucket_name
  blueprint  = var.blueprint_name
  properties = {
    string_props = {
      "name" = var.bucket_name,
    }
  }
  relations = {
    single_relations = {
      "region" = var.region
    }
  }

  depends_on = [aws_s3_bucket.mybucket]
}
