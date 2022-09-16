variable "awsprops" {
    type = "map"
    default = {
    region = "us-east-1"
    vpc = aws_vpc.Main.id
    ami = "ami-052efd3df9dad4825"
    itype = "t2.micro"
    subnet = aws_subnet.publicsubnets.id
    publicip = true
    keyname = "AWS_EC2_key"
    secgroupname = "terraform-Sec-Group"
  }
}

output "my_ouptut" {
  value= lookup(var.awsprops, "vpc")
}
