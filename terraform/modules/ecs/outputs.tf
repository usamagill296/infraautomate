output "service_name" {
  value = aws_ecs_service.service.name
}

output "task_definition_arn" {
  value = aws_ecs_task_definition.service.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.service.name
}