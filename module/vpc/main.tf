resource "aws_vpc" "my-vpc" {
  cidr_block = var.cidr-my-vpc
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.project-name}-my-vpc"
  }
}
resource "aws_vpc" "hg-vpc" {
  cidr_block = var.cidr-hg-vpc
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = "${var.project-name}-hg-vpc"
  }
}

data "aws_availability_zones" "data-az" {
  state = "available"
}

resource "aws_subnet" "public-subnet-myvpc-1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public-subnet-myvpc-1
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.data-az.names[0]
    tags = {
        Name = "${var.project-name}-public-myvpc-1"
    }
}

resource "aws_subnet" "public-subnet-myvpc-2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public-subnet-myvpc-2
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.data-az.names[0]
    tags = {
        Name = "${var.project-name}-public-myvpc-2"
    }
}


resource "aws_subnet" "public-subnet-hgvpc-1" {
    vpc_id = aws_vpc.hg-vpc.id
    cidr_block = var.public-subnet-hgvpc-1
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.data-az.names[1]
    tags = {
        Name = "${var.project-name}-public-hg-1"
    }
}

resource "aws_subnet" "public-subnet-hgvpc-2" {
    vpc_id = aws_vpc.hg-vpc.id
    cidr_block = var.public-subnet-hgvpc-2
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.data-az.names[1]
    tags = {
        Name = "${var.project-name}-public-hg-2"
    }
}

resource "aws_internet_gateway" "igw-myvpc" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "${var.project-name}-my-igw"
  }
}

resource "aws_internet_gateway" "igw-hgvpc" {
  vpc_id = aws_vpc.hg-vpc.id
  tags = {
    Name = "${var.project-name}-hg-igw"
  }
}

resource "aws_route_table" "my-rtb-public" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-myvpc.id
  }
  tags = {
    Name = "${var.project-name}-my-igw"
  }
}

resource "aws_route_table" "hg-rtb-public" {
  vpc_id = aws_vpc.hg-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-hgvpc.id
  }
 
  tags = {
    Name = "${var.project-name}-hg-igw"
  }
}

resource "aws_route_table_association" "ass-myvpc-public-subnet-1" {
  route_table_id = aws_route_table.my-rtb-public.id
  subnet_id = aws_subnet.public-subnet-myvpc-1.id
}

resource "aws_route_table_association" "ass-myvpc-public-subnet-2" {
  route_table_id = aws_route_table.my-rtb-public.id
  subnet_id = aws_subnet.public-subnet-myvpc-2.id
}


resource "aws_route_table_association" "ass-hgvpc-public-subnet-1" {
  route_table_id = aws_route_table.hg-rtb-public.id
  subnet_id = aws_subnet.public-subnet-hgvpc-1.id
}
resource "aws_route_table_association" "ass-hgvpc-public-subnet-2" {
  route_table_id = aws_route_table.hg-rtb-public.id
  subnet_id = aws_subnet.public-subnet-hgvpc-2.id
}