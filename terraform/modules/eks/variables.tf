variable "ec2_instance_type" {
  type        = list(string)
  description = "Ec2 instance type for worker node in eks cluster"
}

variable "vpc_id" {
    type = string
    description = "VPC id"

}

variable "subnet_ids" {

}
