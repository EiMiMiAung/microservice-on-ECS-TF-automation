######## IGW ###############
resource "aws_internet_gateway" "main-igw" {
  vpc_id = aws_vpc.bookinfo_vpc.id
  tags = {
    Name        = "bookinfo-IGW",
    Description = "Internet Gateway"
  }
}
########  NAT Gateway Setup ######## 
resource "aws_eip" "nat" {
  tags = {
    Name = "bookinfo-nat-eip"
  }
}

resource "aws_nat_gateway" "bookinfo_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet[0].id # Assuming NAT is in the first public subnet

  tags = {
    Name = "bookinfo-nat-gateway"
  }
  depends_on = [aws_internet_gateway.main-igw]
}

############# Route Tables ##########

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.bookinfo_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main-igw.id
  }
  tags = {
    Name        = "bookinfo-Public-Routetable",
    Description = "Public-Routetable"
  }
}

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.bookinfo_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.bookinfo_nat.id
  }

  tags = {
    Name = "bookinfo-private-route-table"
  }
}

resource "aws_route_table_association" "private_subnet_association" {
  count          = length(aws_subnet.private_subnet)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "public_subnet_association" {
  count          = length(aws_subnet.public_subnet)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.PublicRouteTable.id
}


