# Load Balancer Security Group
resource "aws_security_group" "alb_sg" {
  name        = "bookinfo-alb-sg"
  description = "Allow HTTP access from the internet"
  vpc_id      = aws_vpc.bookinfo_vpc.id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "bookinfo-alb-sg"
  }
}

# ECS Service Security Group (for all services)
resource "aws_security_group" "ecs_service_sg" {
  name        = "bookinfo-ecs-sg"
  description = "Allow inbound traffic from ALB and inter-service communication"
  vpc_id      = aws_vpc.bookinfo_vpc.id

  # Allow from ALB
  ingress {
    from_port       = 9080
    to_port         = 9080
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow internal communication between ECS services
  ingress {
    from_port = 9080
    to_port   = 9080
    protocol  = "tcp"
    self      = true
  }

    # Outbound: HTTPS (e.g. for ECR, SSM, etc.)
  egress {
    description = "Allow HTTPS to external services"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound: Allow ECS tasks to talk to each other (if needed)
  egress {
    description     = "ECS service communication"
    from_port       = 9080
    to_port         = 9080
    protocol        = "tcp"
     cidr_blocks = [var.vpc_cidr] # reference itself
  }
  

  tags = {
    Name = "bookinfo-ecs-sg"
  }
}