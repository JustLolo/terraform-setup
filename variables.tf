variable "aws_region" {
  type        = string
  description = "(optional) describe your variable"
  default     = "us-west-2"
}

locals {
  force_destroy = false
}