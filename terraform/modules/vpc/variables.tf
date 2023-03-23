variable "vpc_cidr" {
  type        = string
  description = "The IP range to use for the VPC"
  default     = "10.0.0.0/16"
}
variable "infra_env" {
  type        = string
  description = "Infrastructure environment"
  default     = "dev"
}

variable "tags" {
  type        = map(any)
  description = "resource tags"
  default     = null
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "The IP range to use for the public subnets"
  default     = []
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "The IP range to use for the private subnet"
  default     = []
}

variable "avail_zones" {
  type        = list(string)
  description = "List of availability zones"
  default     = []
}
