resource "aws_instance" "project-iac" {
  ami = "ami-052efd3df9dad4825"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.publicsubnets.id
  associate_public_ip_address = true
  key_name = "AWS_EC2_key"


  vpc_security_group_ids = [
    aws_security_group.project-terraform-sg.id
  ]
  root_block_device {
    delete_on_termination = true
    iops = 150
    volume_size = 50
    volume_type = "gp2"
  }
  tags = {
    Name ="Ubuntu_Terraform"
    Environment = "DEV"
    OS = "UBUNTU"
    Managed = "IAC"
  }

  depends_on = [ aws_security_group.project-terraform-sg ]
}



provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "project-terraform-sg" {
  name = "terraform-Sec-Group"
  description = "terraform-Sec-Group"
  vpc_id = aws_vpc.Main.id

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


output "ec2instance" {
  value = aws_instance.project-iac.public_ip
}
