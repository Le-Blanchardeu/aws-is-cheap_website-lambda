data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda_contactform" {
  name               = "iam_for_lambda_contactform"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "process_contact_form.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "process_contact_form" {
  filename      = "lambda_function_payload.zip"
  function_name = "process_contact_form"
  role          = aws_iam_role.iam_for_lambda_contactform.arn
  handler      = "process_contact_form.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.9"

}

resource "aws_lambda_function_url" "test_latest" {
  function_name      = aws_lambda_function.process_contact_form.function_name
  authorization_type = "NONE"
  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["*"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}