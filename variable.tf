###EC2 MODULE VARIABLES

variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}


#SG MODULE VARIABLES

variable "sg_name" {}
variable "sg_description" {}
variable "ingress_rules" {
  type = map(object({
    from_port       = number
    to_port         = number
    protocol        = string
    cidr_blocks     = list(string)
    self            = bool
    security_groups = list(string)
  }))
}


#SES MODULE VARIABLES

variable "ses_email" {}


#LAMBDA MOULDE VARIABLES

variable "lambda_function_runtime" {}


#EVENTBRIDGE VARIABLES

variable "event_rules" {}