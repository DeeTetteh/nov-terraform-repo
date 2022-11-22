resource "aws_vpc" "deenov1-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "deenov1-vpc"
  }
}

resource "aws_subnet" "deenov1subpublic1" {
  vpc_id     = aws_vpc.deenov1-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "deenovsubpulic1"
  }
}

resource "aws_subnet" "deenov1subprivate2" {
  vpc_id     = aws_vpc.deenov1-vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "deenov1subprivate2"
  }
}

resource "aws_route_table" "deenov1publicroutetable" {
  vpc_id = aws_vpc.deenov1-vpc.id

  
  tags = {
    Name = "deenov1publicroutetable"
  }
}

resource "aws_route_table" "deenov1privateroutetable" {
  vpc_id = aws_vpc.deenov1-vpc.id

  
  tags = {
    Name = "deenov1privateroutetable"
  }
}

resource "aws_route_table_association" "deenov1publicroutetableassociation" {
  subnet_id      = aws_subnet.deenov1subpublic1.id
  route_table_id = aws_route_table.deenov1publicroutetable.id
}

resource "aws_route_table_association" "deenov1privateroutetableassociation" {
  subnet_id      = aws_subnet.deenov1subprivate2.id
  route_table_id = aws_route_table.deenov1privateroutetable.id
}

resource "aws_internet_gateway" "novigw" {
  vpc_id = aws_vpc.deenov1-vpc.id

  tags = {
    Name = "novigw"
  }
}

resource "aws_route" "novigw" {
  route_table_id         = aws_route_table.deenov1publicroutetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.novigw.id
}
