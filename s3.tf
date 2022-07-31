##############################################################
### Creating S3 container to save the backend information  ###
##############################################################
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

##########################################################
###  Creating a folder to keep the ec2 instance keys  ####
##########################################################
resource "aws_s3_object" "ec2_keys_folder" {
  bucket       = aws_s3_bucket.terraform_state.id
  acl          = "private"
  key          = "${local.s3-ec2-keys-folder-name}/"
  content_type = "application/x-directory"

  # tags = {
  #   "Name"        = local.s3-ec2-keys-folder-name
  #   "CreatedBy"   = "terraform"
  #   "Purpose"     = "terraform backend generator"
  #   "Purpose"     = "terraform backend generator/ec2 key directory"
  #   "ProjectName" = var.name-of-the-project
  # }
}
