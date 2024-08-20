resource "aws_vpc" "vpc1" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "krishna"
  }
}

resource "aws_instance" "ec2" {
  ami = "ami-02b49a24cfb95941c"
  instance_type = var.ec2_type
  tags = {
    Name = "kalki"
  }
}