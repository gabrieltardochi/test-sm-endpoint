resource "aws_iam_role" "sg_endpoint_role" {
  name_prefix = var.endpoint_name
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "sagemaker.amazonaws.com"
          # AWS     = "arn:aws:sts::${var.account}:assumed-role/${var.dev_role_name}/${var.dev_role_session_name}"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sg_fullaccess_policy_attachment" {
  role       = aws_iam_role.sg_endpoint_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSageMakerFullAccess"
}

data "aws_iam_policy_document" "sg_role_policy_document" {
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "${var.model_bucket_arn}",
      "${var.model_bucket_arn}/*"
    ]
  }
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "cloudwatch:DeleteAlarms",
      "cloudwatch:DescribeAlarms",
      "cloudwatch:GetMetricData",
      "cloudwatch:GetMetricStatistics",
      "cloudwatch:ListMetrics",
      "cloudwatch:PutMetricAlarm",
      "cloudwatch:PutMetricData",
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:CreateVpcEndpoint",
      "ec2:DeleteNetworkInterface",
      "ec2:DeleteNetworkInterfacePermission",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcs",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CreateRepository",
      "ecr:Describe*",
      "ecr:GetAuthorizationToken",
      "ecr:GetDownloadUrlForLayer",
      "ecr:StartImageScan",
      "iam:ListRoles",
      "kms:DescribeKey",
      "kms:ListAliases",
      "logs:CreateLogDelivery",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DeleteLogDelivery",
      "logs:Describe*",
      "logs:GetLogDelivery",
      "logs:GetLogEvents",
      "logs:ListLogDeliveries",
      "logs:PutLogEvents",
      "logs:PutResourcePolicy",
      "logs:UpdateLogDelivery",
      "secretsmanager:ListSecrets",
      "tag:GetResources"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = ""
    effect = "Allow"
    actions = [
      "iam:PassRole"
    ]
    resources = [
      "${aws_iam_role.sg_endpoint_role.arn}"
    ]
  }
}

resource "aws_iam_policy" "sg_role_policy" {
  name   = "${var.endpoint_name}-role-policy"
  policy = data.aws_iam_policy_document.sg_role_policy_document.json
}

resource "aws_iam_role_policy_attachment" "sg_endpoint_role_policy_attachment" {
  role       = aws_iam_role.sg_endpoint_role.name
  policy_arn = aws_iam_policy.sg_role_policy.arn
}