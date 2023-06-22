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
