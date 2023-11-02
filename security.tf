resource "aws_security_group" "security_group04" {
  name        = var.securitygroup_name
  description = "Demo Security Group"
   vpc_id      = aws_vpc.vpc_frank.id

  ingress {
    description      = "SSH Access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["152.231.0.0/16"]
    # ipv6_cidr_blocks = ["::/0"]
  }


ingress {
    description      = "Wordpress Access"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["152.231.0.0/16"]
    # ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "MySQl Access"
    from_port        = 3306
    to_port          = 3306
    protocol         = "tcp"
    cidr_blocks      = ["152.231.0.0/16"]
    # ipv6_cidr_blocks = ["::/0"]
  }

   egress {
     from_port        = 0
     to_port          = 0
     protocol         = "-1"
     cidr_blocks      = ["0.0.0.0/0"]
     ipv6_cidr_blocks = ["::/0"]
  }

   tags = {
     Name = var.securitygroup_name
   }
}

 resource "aws_key_pair" "frank_kp" {
   key_name   = "frank_keypair"
   public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDApSPO88rXtgXbAclPrwdIgejtmD69mc6oVc0zridBXnJYHyZJWMI0Bq/avYC5C0PcAjmOsCHwC7T83sHzrIxgozBaQKNf88wgHgKVHXP+ACA14Ew1F/sQD+fHCY3CTtHPd0IDyweFH7yB8sR6aVHDzBI/RDAAs+EPOG7lIpl9x1zX+771sV6JofWdvkroyXO8H5RwnijsfNpRjJLzMBYasi4tU/j2M8LHfsuf3QxuXkU53boEyBrhSpJ1n6cCeFHvPXSIDhoLoHADZdB7XhF6IHG7/VwEz2Jk30rfhr9A6abnwXiDK6cL57nuEcW1knIuE4EQOFs77iNw2H2paBnIm3G3rcDgrJHH2IJAesE7H3M+PFN2Zh+UImp6juvw0HQ023Su7XAPV6RP4tmnrlk2pGa2uV5OIOXPNGrwDVmvSlRrzS6b2y5Ovw3vpIRX26HeDz4bIMGjPN3ke3Qt3wWSJ/BDEDR+s19/VCPjpQ4cEPZkpGqrpxP0Gr1fsVSwvuc= Administrator@WIN-NUO83NOC74O"
}
