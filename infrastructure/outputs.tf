output "ecs_tasks_role_id" {
  description = "ecs role Id Output"
  value       = aws_iam_role.ecs_tasks_role.id
}
output "ecs_tasks_role_arn" {
  value = aws_iam_role.ecs_tasks_role.arn
}

output "bookinfo_vpc_id" {
  description = "Vpc Id Output"
  value       = aws_vpc.bookinfo_vpc.id
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "private_sg_id" {
  description = "List of sg subnet IDs"
  value       = [for subnet in aws_subnet.private_subnet : subnet.id]
}

output "alb_sg_id" {
  description = "Security group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}

output "ecs_service_sg_id" {
  description = "Security group ID for ECS services"
  value       = aws_security_group.ecs_service_sg.id
}

output "ecs_cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.bookinfo_cluster.name
}

output "cloud_map_namespace_arn" {
  description = "ARN of the private Cloud Map namespace"
  value       = aws_service_discovery_private_dns_namespace.bookinfo_ns.arn
}

output "cloud_map_namespace_name" {
  description = "Name of the Cloud Map namespace"
  value       = aws_service_discovery_private_dns_namespace.bookinfo_ns.name
}

output "productpage_target_group_arn" {
  value = aws_lb_target_group.productpage_tg.arn
}