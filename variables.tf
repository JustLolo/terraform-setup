variable "aws_region" {
  type        = string
  description = "Provide the region"
  default     = "us-west-2"
}

variable "name-of-the-project" {
  type        = string
  description = "type the name, it'll be used to set another resources names, like s3 and dynamodb names"
  default     = "terraform-basic"
}



locals {
  force_destroy                = false
  resources_string_format_name = "${var.name-of-the-project}.%s.backend.terraform"
  dynamodb-name                = format(local.resources_string_format_name, "state-trace-lock")

  # s3 related
  s3-name                   = format(local.resources_string_format_name, "state-keeper")
  ec2-keys-folder-name      = "ec2-keys.backend.terraform"
  status-keeper-folder-name = "status-keeper.backend.terraform"
}
