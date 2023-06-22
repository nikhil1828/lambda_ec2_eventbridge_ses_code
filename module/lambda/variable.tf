variable "lambda_function_role" {}
variable "lambda_function_runtime" {}

variable "lambda_function" {
  type = map(object({
    lambda_function_filename         = string,
    lambda_function_function_name    = string,
    lambda_function_handler = string,
    lambda_function_source_code_hash = string
  }))
}

variable "lambda_function_name" {
  type = map(object({
    statement_id = string,
    function_name = string,
    source_arn = string
  }))
}