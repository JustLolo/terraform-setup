#  s3 bucket name
output "s3-backend-id" {
  description = "s3 folder for tracking state purposes"
  value       = aws_s3_bucket.terraform_state.id
}

#  dynamodb table for tracking/locking state purposes
output "dynamodb-backend-id" {
  description = "dynamodb table used for tracking/locking state purposes"
  value       = aws_dynamodb_table.terraform_state.id
}

#  folder name of ec2 keys
output "s3-folder-ec2-keys" {
  description = "folder name of ec2 keys"
  value       = aws_s3_object.ec2_keys_folder.key
}

#  s3 folder for tracking state purposes
output "s3-folder-status-keeper" {
  description = "folder name of ec2 keys"
  value       = aws_s3_object.terraform-backend-folder.key
}