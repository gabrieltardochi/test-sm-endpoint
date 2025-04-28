module "sagemaker-endpoint" {
  source = "./sagemaker-endpoint"

  account          = var.account
  model_bucket_arn = aws_s3_bucket.sg_bucket.arn
  endpoint_name    = "test-sm-endpoint"
  containers = [{
    image_uri = "${var.account}.dkr.ecr.${var.region}.amazonaws.com/test-sm-endpoint:latest"
  }]
  production_variant = {
    variant_name           = "AllTraffic"
    instance_type          = "ml.t2.medium"
    initial_instance_count = 1
  }
  enable_network_isolation = true
}