output "sagemaker_role_arn" {
  description = "The ARN of the IAM role for the SageMaker endpoint"
  value       = aws_iam_role.sg_endpoint_role.arn
}

output "sagemaker_endpoint_name" {
  description = "The name of the SageMaker endpoint"
  value       = aws_sagemaker_endpoint.sagemaker_endpoint.name
}

output "sagemaker_endpoint_config_name" {
  description = "The name of the SageMaker endpoint configuration"
  value       = aws_sagemaker_endpoint_configuration.sagemaker_endpoint_config.name
}