resource "aws_lambda_function" "vm_state_lambda" {
  for_each         = var.lambda_function
  filename         = each.value["lambda_function_filename"]
  function_name    = each.value["lambda_function_function_name"]
  role             = var.lambda_function_role
  handler          = each.value["lambda_function_handler"]
  source_code_hash = each.value["lambda_function_source_code_hash"]
  runtime          = var.lambda_function_runtime
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  for_each = var.lambda_function_name
  statement_id  = each.value["statement_id"]
  action        = "lambda:InvokeFunction"
  function_name = each.value["function_name"]
  principal     = "events.amazonaws.com"
  source_arn    = each.value["source_arn"]
}
