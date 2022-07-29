terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"

      # v4.23.0 actual version, migrate when needed
      version = "~> 4.23.0"
    }
  }

  # 1.2.4 actual verion migrate to 1.3 eventually
  required_version = "~> 1.2.4"
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}


resource "aws_s3_bucket" "terraform_state" {
  bucket = local.s3-name

  # In production remember to lock the files, we don't want an accident here
  # force_destroy = true
  lifecycle {
    prevent_destroy = true # should be true to prevent accidentally deleting state file
  }

  tags = {
    "Name"        = local.s3-name
    "CreatedBy"   = "terraform"
    "Purpose"     = "terraform backend generator"
    "Purpose"     = "terraform backend generator/tracker"
    "ProjectName" = var.name-of-the-project
  }
}

resource "aws_s3_bucket_versioning" "terraform_state" {

  bucket = aws_s3_bucket.terraform_state.id

  versioning_configuration {
    # recommended by terraform documentation
    # https://www.terraform.io/language/settings/backends/s3#s3
    status = "Enabled"
  }

}

resource "aws_s3_bucket_public_access_block" "terraform_state" {
  bucket = aws_s3_bucket.terraform_state.id

  # blocking any kind of public access
  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "terraform_state" {
  # name = local.dynamodb_table_name
  name = local.dynamodb-name

  # up to 25 free tier
  read_capacity  = 5
  write_capacity = 5

  # https://www.terraform.io/language/settings/backends/s3#dynamodb-state-locking
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    "Name"        = local.dynamodb-name
    "CreatedBy"   = "terraform"
    "Purpose"     = "terraform backend generator/tracker"
    "ProjectName" = var.name-of-the-project
  }
}
