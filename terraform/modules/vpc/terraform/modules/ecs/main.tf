resource "aws_cloudwatch_log_group" "service" {
  name              = "/ecs/${var.environment}/${var.service_name}"
  retention_in_days = 7

  tags = {
    Service     = var.service_name
    Environment = var.environment
  }
}

resource "aws_ecs_task_definition" "service" {
  family                   = "${var.service_name}-${var.environment}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.execution_role_arn

  container_definitions = jsonencode([{
    name  = var.service_name
    image = var.container_image

    portMappings = [{
      containerPort = var.container_port
      protocol      = "tcp"
    }]

    logConfiguration = {
      logDriver = "awslogs"
      options = {
        "awslogs-group"         = aws_cloudwatch_log_group.service.name
        "awslogs-region"        = var.aws_region
        "awslogs-stream-prefix" = "ecs"
      }
    }
  }])

  tags = {
    Service     = var.service_name
    Environment = var.environment
  }
}

resource "aws_ecs_service" "service" {
  name            = "${var.service_name}-${var.environment}"
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.service.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.subnet_ids
    security_groups  = [var.security_group_id]
    assign_public_ip = false
  }

  tags = {
    Service     = var.service_name
    Environment = var.environment
  }
}