provider "aws" {
  region = "ap-south-1"
}

module "sg" {
  source         = "./module/sg"
  sg_name        = var.sg_name
  sg_description = var.sg_description
  ingress_rules  = var.ingress_rules
}

module "ec2" {
  source        = "./module/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  sg            = [module.sg.sg_id.name]
  ssh_pvt_key = file("/home/admin1/Downloads/mumbai_iron.pem")
}

module "ses" {
  source = "./module/ses"
  ses_email = var.ses_email
}

module "iam" {
  source = "./module/iam"
}

data "archive_file" "start-vm-lambda" {
  type        = "zip"
  source_file = "./lambda_functions/start-vm.py"
  output_path = "./lambda_functions/start-vm.zip"
}

data "archive_file" "stop-vm-lambda" {
  type        = "zip"
  source_file = "./lambda_functions/stop-vm.py"
  output_path = "./lambda_functions/stop-vm.zip"
}

module "lambda" {
  source = "./module/lambda"
  lambda_function = {
    file1 = {
      lambda_function_filename         = data.archive_file.start-vm-lambda.output_path,
      lambda_function_function_name    = "start-vm-rule",
      lambda_function_handler          = "start-vm.lambda_handler",
      lambda_function_source_code_hash = data.archive_file.start-vm-lambda.output_base64sha256
    },
    file2 = {
      lambda_function_filename         = data.archive_file.stop-vm-lambda.output_path,
      lambda_function_function_name    = "stop-vm-rule",
      lambda_function_handler          = "stop-vm.lambda_handler",
      lambda_function_source_code_hash = data.archive_file.stop-vm-lambda.output_base64sha256
    }
  }
  lambda_function_role    = module.iam.lambda_details.arn
  lambda_function_runtime = var.lambda_function_runtime

  lambda_function_name = {
    funtion1 ={
      statement_id = "allow_from_cloudwatch_1"
      function_name = "start-vm-rule"
      source_arn = lookup(module.event.event_rule_details, "rule1", null).arn
    },
    funtion2 ={
      statement_id = "allow_from_cloudwatch_2"
      function_name = "stop-vm-rule"
      source_arn = lookup(module.event.event_rule_details, "rule2", null).arn
    },
    funtion3 ={
      statement_id = "allow_from_cloudwatch_3"
      function_name = "start-vm-rule"
      source_arn = lookup(module.event.event_rule_details, "rule3", null).arn
    },
    funtion4 ={
      statement_id = "allow_from_cloudwatch_4"
      function_name = "stop-vm-rule"
      source_arn = lookup(module.event.event_rule_details, "rule4", null).arn
    }
  }
}

module "event" {
  source = "./module/eventbridge"
  event_rules = var.event_rules
  event_target = {
    target1 = {
      target_rule      = lookup(module.event.event_rule_details, "rule1", null).name
      event_target_arn = lookup(module.lambda.lambda_details, "file1", null).arn
    },
    target2 = {
      target_rule      = lookup(module.event.event_rule_details, "rule2", null).name
      event_target_arn = lookup(module.lambda.lambda_details, "file2", null).arn
    },
    target3 = {
      target_rule      = lookup(module.event.event_rule_details, "rule3", null).name
      event_target_arn = lookup(module.lambda.lambda_details, "file1", null).arn
    },
    target4 = {
      target_rule      = lookup(module.event.event_rule_details, "rule4", null).name
      event_target_arn = lookup(module.lambda.lambda_details, "file2", null).arn
    }
  }
}
