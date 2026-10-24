variable "service_name" {
  description = "Name of the ECS service"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "container_image" {
  description = "Docker image URL from ECR"
  type        = string
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
}

variable "cpu" {
  description = "CPU units for task"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Memory in MB for task"
  type        = number
  default     = 512
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 1
}

variable "cluster_id" {
  description = "ECS cluster ID"
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group for ECS tasks"
  type        = string
}

variable "execution_role_arn" {
  description = "IAM role for ECS task execution"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}