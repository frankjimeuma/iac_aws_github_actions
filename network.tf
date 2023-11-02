resource "aws_vpc" "vpc_frank" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "iac_aws_github_actions"
  }
}

resource "aws_subnet" "subnet_frank_public" {
  vpc_id     = aws_vpc.vpc_frank.id
  # depends_on = [ aws_vpc.vpc_frank ]
  cidr_block =var.cidr_public_subnet
  map_public_ip_on_launch = true

  tags = {
    Name = "SubnetPublic"
  }
}

resource "aws_subnet" "subnet_frank_private" {
  vpc_id     = aws_vpc.vpc_frank.id
  # depends_on = [ aws_vpc.vpc_frank ]
  cidr_block =var.cidr_private_subnet

  tags = {
    Name = "SubnetPrivate"
  }
}

resource "aws_internet_gateway" "igw_frank" {
  vpc_id = aws_vpc.vpc_frank.id

  tags = {
    Name = "iac_aws_github_actions-igw"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.subnet_frank_public.id

  tags = {
    Name = "iac_aws_github_actions-nat"
  }
}

resource "aws_eip" "nat" {

}






resource "aws_route_table" "rt_frank_private" {
  vpc_id = aws_vpc.vpc_frank.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "PrivateRouteTableNAT"
  }
}



resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.subnet_frank_private.id
  route_table_id = aws_route_table.rt_frank_private.id
  

}





resource "aws_route_table" "rt_frank" {
  vpc_id = aws_vpc.vpc_frank.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_frank.id
  }


  tags = {
    Name = "PublicRouteTable"
  }
}

resource "aws_route_table_association" "association_public" {
  subnet_id      = aws_subnet.subnet_frank_public.id
  route_table_id = aws_route_table.rt_frank.id
}


