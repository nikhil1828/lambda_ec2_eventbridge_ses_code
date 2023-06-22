resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })

  tags = {
    service = "lambda"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "vm_start_stop_policy" {
  name        = "vm_start_stop_policy"
  path        = "/"
  description = "My vm_start_stop_policy policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode(
  {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ec2:StartInstances",
                "ec2:StopInstances"
            ],
            "Resource": "*"
        }
    ]
    })
}

resource "aws_iam_role_policy_attachment" "lambda_role_policy_custom" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.vm_start_stop_policy.arn
}


resource "aws_iam_role_policy_attachment" "lambda_role_policy_custom2" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
