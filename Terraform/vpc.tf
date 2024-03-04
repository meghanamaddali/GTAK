resource "aws_vpc" "gtak-vpc" {
  cidr_block = "10.1.0.0/16"
  tags = {
    Name = "gtak-vpc"
  }  
}

resource "aws_subnet" "gtak-public-subnet-01" {
  vpc_id = aws_vpc.gtak-vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1a"
  tags = {
    Name = "gtak-public-subent-01"
  }
}

resource "aws_subnet" "gtak-public-subnet-02" {
  vpc_id = aws_vpc.gtak-vpc.id
  cidr_block = "10.1.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-1b"
  tags = {
    Name = "gtak-public-subent-02"
  }
}

resource "aws_internet_gateway" "gtak-igw" {
  vpc_id = aws_vpc.gtak-vpc.id 
  tags = {
    Name = "gtak-igw"
  } 
}

resource "aws_route_table" "gtak-public-rt" {
  vpc_id = aws_vpc.gtak-vpc.id 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gtak-igw.id 
  }
}

resource "aws_route_table_association" "gtak-rta-public-subnet-01" {
  subnet_id = aws_subnet.gtak-public-subnet-01.id
  route_table_id = aws_route_table.gtak-public-rt.id   
}

resource "aws_route_table_association" "gtak-rta-public-subnet-02" {
  subnet_id = aws_subnet.gtak-public-subnet-02.id 
  route_table_id = aws_route_table.gtak-public-rt.id   
}