resource "aws_vpc" "VmVpc" {
  cidr_block       = "10.170.0.0/16"
  instance_tenancy = "default"

}

resource "aws_subnet" "VMSubnet" {
  vpc_id     = aws_vpc.VmVpc.id
  cidr_block = "10.170.1.0/24"
  map_public_ip_on_launch = true
  depends_on = [ aws_vpc.VmVpc ]
}



resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow SSH and HTTP traffic"

  # Define the inbound rules
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

  # Define the outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}




