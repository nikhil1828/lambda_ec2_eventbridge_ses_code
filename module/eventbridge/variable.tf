# variable "event_rules" {
#     type = map(object({
# event_rule_name = string
#   event_rule_schedule = string
#     }))
# }

variable "event_rules" {
  type = map
}


variable "event_target" {}
