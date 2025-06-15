resource "aws_service_discovery_private_dns_namespace" "bookinfo_ns" {
  name        = "bookinfo.local"
  vpc         = aws_vpc.bookinfo_vpc.id
  description = "Private namespace for Bookinfo services"
}

resource "aws_ecs_cluster" "bookinfo_cluster" {
  name = "bookinfo-cluster"

  service_connect_defaults {
    namespace = aws_service_discovery_private_dns_namespace.bookinfo_ns.arn
  }
}
