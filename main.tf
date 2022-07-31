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
