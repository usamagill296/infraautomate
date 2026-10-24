project_name = "infraautomate"
environment  = "dev"
aws_region   = "eu-central-1"

# VPC Settings
vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]

# ECS Settings - small for dev (save money!)
ecs_cpu           = 256
ecs_memory        = 512
ecs_desired_count = 1