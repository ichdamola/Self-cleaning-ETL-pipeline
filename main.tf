# Initialize your Terraform configuration
provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

# Create an S3 bucket
resource "aws_s3_bucket" "data_lake" {
  bucket = "your-data-lake-bucket"
  acl    = "private"
}

# Create a Lambda function
resource "aws_lambda_function" "cleanup_function" {
  function_name = "data-lake-cleanup"
  handler = "index.handler"
  runtime = "nodejs14.x"
  role = aws_iam_role.lambda_execution_role.arn
  timeout = 60
  source_code_hash = filebase64("${path.module}/cleanup_lambda.zip")
}

# IAM Role for Lambda
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach policies to the Lambda role
resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.lambda_execution_role.name]
}

# Schedule Lambda execution with CloudWatch Events (e.g., daily)
resource "aws_cloudwatch_event_rule" "lambda_schedule" {
  name        = "daily_cleanup_schedule"
  description = "Daily Lambda Cleanup Schedule"
  schedule_expression = "rate(1 day)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.lambda_schedule.name
  target_id = "cleanup_lambda_target"
  arn       = aws_lambda_function.cleanup_function.arn
}
