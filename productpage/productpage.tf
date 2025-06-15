
data "terraform_remote_state" "infrastructure" {
  backend = "remote"
  config = {
    organization = "heartwork-jp"
    workspaces = {
      name = "infrastructure"
    }
  }
}
resource "aws_ecs_task_definition" "productpage" {
  family                   = var.task_family
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = data.terraform_remote_state.infrastructure.outputs.ecs_tasks_role_arn

  container_definitions = jsonencode([
    {
      name      = var.container_name
      image     = var.ecr_image
      essential = true
      portMappings = [
        {
          containerPort = 9080
          name          = "productpage"
          appProtocol   = "http"
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "productpage" {
  name            = var.service_name
  cluster         = data.terraform_remote_state.infrastructure.outputs.ecs_cluster_name
  task_definition = aws_ecs_task_definition.productpage.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    subnets          = data.terraform_remote_state.infrastructure.outputs.private_subnet_ids
    security_groups  = [data.terraform_remote_state.infrastructure.outputs.ecs_service_sg_id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = data.terraform_remote_state.infrastructure.outputs.productpage_target_group_arn
    container_name   = var.container_name
    container_port   = 9080
  }

  service_connect_configuration {
    enabled   = true
    namespace = data.terraform_remote_state.infrastructure.outputs.cloud_map_namespace_arn

    service {
      discovery_name = "productpage"
      port_name      = "productpage"

      client_alias {
        port     = 9080
        dns_name = "productpage"
      }
    }
  }
}
