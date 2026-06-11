variable "name_prefix" {
  description = "Prefix used for resource naming"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where the instance will be launched"
  type        = string
}

variable "security_group_ids" {
  description = "Security group IDs to attach to the instance"
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID (defaults to latest Amazon Linux 2023 when null)"
  type        = string
  default     = null
}

variable "ami_name_filter" {
  description = "AMI name filter used when ami_id is not provided"
  type        = string
  default     = "al2023-ami-*-kernel-*-x86_64"
}

variable "user_data" {
  description = "User data script to run on instance launch"
  type        = string
  default     = null
}

variable "user_data_replace_on_change" {
  description = "Recreate the instance when user_data changes"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
