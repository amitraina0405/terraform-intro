
# Deploy a Single EC2 INSTANCE


# configure AWS Connection

 provider "aws" {
    region = "ap-south-1"
 }

 resource "aws_instance" "example" {
   ami = "ami-007d5db58754fa284"
   instance_type = "t2.micro"
   vpc_security_group_ids = ["$aws_security.instance.id"]

   user_data = <<-EOF
             #!/bin/bash
             echo "Hello, World" > index.html
             nohup busybox httpd -f -p "$var.server_port" &
             EOF

   tags {
     Name = "terraform-exammle"
   }
 }


# Create a security group

 resource "aws_security_group" "instance" {
   name = "terraform-example-instance"

   ingress {
     from_port = "${var.server_port}"
     to_port   = "${var.server_port}"
     protocol  = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
   }
 }
