data "aws_availability_zones" "available" {}
resource "aws_subnet" "private_subnet" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.bookinfo_vpc.id
  cidr_block        = element(split(",", join(",", var.private_subnet_cidrs)), count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "bookinfo-${lower(var.environment)}-private-subnet-${count.index + 1}",
    Description = "${lower(var.environment)} private subnet - ${count.index + 1}"
  }
}

resource "aws_subnet" "public_subnet" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.bookinfo_vpc.id
  cidr_block        = element(split(",", join(",", var.public_subnet_cidrs)), count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name        = "bookinfo-${lower(var.environment)}-public_subnet-${count.index + 1}",
    Description = "${lower(var.environment)} public_subnet - ${count.index + 1}"
  }

}