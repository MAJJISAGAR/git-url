resource "aws_vpc" "hello" {
  cidr_block           = "192.168.0.0/24"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "My-Vpc"
  }
}

resource "aws_subnet" "sub-1" {
  vpc_id                  = aws_vpc.hello.id
  cidr_block              = "192.168.0.0/26"
  map_public_ip_on_launch = true

  tags = {
    Name = "Public-Subnet"
  }
}

resource "aws_internet_gateway" "igw-new" {
  vpc_id = aws_vpc.hello.id
  tags = {
    Name = "sagar-igw"
  }
}

resource "aws_route_table" "rtb-new" {
  vpc_id = aws_vpc.hello.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-new.id
  }

  tags = {
    Name = "My-route"
  }
}

resource "aws_route_table_association" "rtb-ass-new" {
  subnet_id      = aws_subnet.sub-1.id
  route_table_id = aws_route_table.rtb-new.id
}

resource "aws_security_group" "sg-new" {
  vpc_id = aws_vpc.hello.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "my-ec2" {
  ami                    = "ami-0af9569868786b23a"
  instance_type          = "t2.micro"
  key_name               = "sagar123"
  vpc_security_group_ids = [aws_internet_gateway.igw-new.id]
  subnet_id              = aws_subnet.sub-1.id
  depends_on             = [aws_internet_gateway.igw-new]

  tags = {
    Name = "Hello-Sagar"
  }
}
