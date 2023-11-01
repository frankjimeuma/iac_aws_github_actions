terraform {
  backend "s3" {
    bucket                  = "s3-terraform-frank-state"
    key                     = "my-terraform-project"
    region                  = "us-east-1"

  }
}
#hola



provider "aws" {}

resource "aws_instance" "frank_instance" {
  ami           = "ami-053b0d53c279acc90"  # ubuntu AMI
  instance_type = "t3.micro"
  key_name = aws_key_pair.frank_kp.key_name
  subnet_id = aws_subnet.subnet_frank_public.id
  vpc_security_group_ids = [aws_security_group.security_group04.id]
  user_data = <<EOF
#!/bin/bash
sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install nginx -y
cd /var/www/
sudo chgrp ubuntu html
sudo chown ubuntu html
cd html
wget https://iac-frank.s3.amazonaws.com/binaries.zip
sudo apt-get install unzip
unzip binaries.zip
EOF
  tags = {
    Name = "PublicInstance"
  }
}
