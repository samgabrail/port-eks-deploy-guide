variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
  default     = "tekanaid-test"
}

variable "blueprint_name" {
  description = "Name of the blueprint in Port"
  type        = string
  default     = "s_3_bucket"
}

