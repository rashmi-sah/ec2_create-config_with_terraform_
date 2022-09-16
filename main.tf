variable "awsprops" {
    type = "map"
    default = {
    region = "us-east-1"
    #vpc = aws_vpc.Main.id
    ami = "ami-052efd3df9dad4825"
    itype = "t2.micro"
    #subnet = aws_subnet.publicsubnets.id
    publicip = true
    keyname = "AWS_EC2_key"
    secgroupname = "terraform-Sec-Group"
  }
}

provider "aws" {
  region = lookup(var.awsprops, "region")
}

resource "aws_security_group" "project-terraform-sg" {
  name = lookup(var.awsprops, "secgroupname")
  description = lookup(var.awsprops, "secgroupname")
  vpc_id = lookup(var.awsprops, "vpc")

  // To Allow SSH Transport
  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  // To Allow Port 80 Transport
  ingress {
    from_port = 80
    protocol = ""
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
