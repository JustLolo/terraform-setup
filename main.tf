terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      #version = "~> 3.0"
      #in a production environment you have to set a fixed version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}


resource "aws_s3_bucket" "terraform" {
  bucket = "terraform-personal-stuff"

  force_destroy = true
  lifecycle {
    prevent_destroy = true # should be true to prevent accidentally deleting state file
  }
}

resource "aws_s3_bucket_versioning" "terraform" {
  bucket = aws_s3_bucket.terraform.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "terraform-arnoldupdev" {
  bucket = aws_s3_bucket.terraform.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}
