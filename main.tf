terraform {
  backend "s3" {
    bucket                  = "s3-terraform-frank-state"
    key                     = "my-terraform-project"
    region                  = "us-east-1"

  }
}
#hola



provider "aws" {}

resource "aws_instance" "frank_instance_public" {
  ami           = "ami-053b0d53c279acc90"  # ubuntu AMI
  instance_type = "t2.micro"
  key_name = "frank_keypair" #aws_key_pair.frank_kp.key_name
  subnet_id = aws_subnet.subnet_frank_public.id
  vpc_security_group_ids = [aws_security_group.security_group04.id]
  user_data = <<EOF
#!/bin/bash
sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Install Wordpress:
docker run --name frankwp -v /wordpress_data:/var/www/html -dp 8080:80 wordpress

EOF
  tags = {
    Name = "PublicInstance"
  }
}

resource "aws_instance" "frank_instance_private" {
  ami           = "ami-053b0d53c279acc90"  # ubuntu AMI
  instance_type = "t2.micro"
  key_name = "frank_keypair" #aws_key_pair.frank_kp.key_name
  subnet_id = aws_subnet.subnet_frank_private.id
  vpc_security_group_ids = [aws_security_group.security_group04.id]
  user_data = <<EOF
#!/bin/bash
sudo sed -i "/#\$nrconf{restart} = 'i';/s/.*/\$nrconf{restart} = 'a';/" /etc/needrestart/needrestart.conf
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo groupadd docker
sudo usermod -aG docker $USER
newgrp docker

# Install MySql:
docker run --name frankdb -v /mysql_data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=Password123 -d mysql

EOF
  tags = {
    Name = "PrivateInstance"
  }
}