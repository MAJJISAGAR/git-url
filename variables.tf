variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "ec2_type" {
  type = string
  default = "t2.micro"
}