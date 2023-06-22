resource "aws_cloudwatch_event_rule" "auto_start_stop_rule" {
  for_each            = var.event_rules
  name                = each.value["event_rule_name"]
  schedule_expression = each.value["event_rule_schedule"]
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  for_each = var.event_target
  rule = each.value["target_rule"] 
  arn  = each.value["event_target_arn"]
}
