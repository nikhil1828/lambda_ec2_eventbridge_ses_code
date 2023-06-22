ami_id        = "ami-0560bf59eeb4705cc"
instance_type = "t2.micro"
key_name      = "mumbai_iron"


sg_name        = "allow rules"
sg_description = "SG 3000, 8080 and 27017 rules"
ingress_rules = {
  "rule1" = {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = null
    security_groups = null
  },
  "rule2" = {
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = null
    security_groups = null
  },
  "rule3" = {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = null
    security_groups = null
  },
  "rule4" = {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
    self            = null
    security_groups = null
  }
}


ses_email = "nikd9917@gmail.com"


lambda_function_runtime = "python3.9"


event_rules = {
  rule1 = {
    event_rule_name     = "morning_start_rule"
    event_rule_schedule = "cron(30 3 * * ? *)"
  },
  rule2 = {
    event_rule_name     = "morning_stop_rule"
    event_rule_schedule = "cron(00 5 * * ? *)"
  },
  rule3 = {
    event_rule_name     = "evening_start_rule"
    event_rule_schedule = "cron(30 11 * * ? *)"
  },
  rule4 = {
    event_rule_name     = "evening_stop_rule"
    event_rule_schedule = "cron(00 1 * * ? *)"
  }
}
