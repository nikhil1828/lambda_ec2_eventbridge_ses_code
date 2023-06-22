resource "aws_ses_email_identity" "example" {
  email = var.ses_email#"email@example.com"
}