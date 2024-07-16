terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.56.1"
    }
  }
}
provider "aws" {
  region = "us-east-2"
}


resource "tls_private_key" "vminstance" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "vminstanceKey" {
  key_name   = "vminstanceKey"
  public_key = tls_private_key.vminstance.public_key_openssh
}

resource "aws_instance" "vminstance" {
  ami             = "ami-08b66c1b6d6a8a30a"   # AMI ID for the first instance
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.vminstanceKey.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]

}

output "vminstanceOut" {
  value     = tls_private_key.vminstance.private_key_pem
  sensitive = true
}
