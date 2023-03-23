variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Key to access the EC2 instance"
  default     = "jenkins-server"
}

variable "avail_zone" {
  type        = string
  description = "Availability zone"
  default     = "eu-central-1a"
}

variable "infra_env" {
  type        = string
  description = "Environment type"
  default     = "dev"
}

variable "instance_root_device_size" {
  type        = number
  description = "Root bock device size in GB"
  default     = 8
}

variable "public_subnet" {
  type        = string
  description = "Valid subnets to assign to server"
}

variable "security_group" {
  type        = list(string)
  description = "Security group to assign to server"
  default     = []
}
