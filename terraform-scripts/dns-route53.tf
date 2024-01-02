# DNS Registration 
# DNS Name Input Variable
variable "dns_name" {
  description = "DNS Name to support multiple environments"
  type = string   
}
## Default DNS
resource "aws_route53_record" "default_dns" {
  zone_id = data.aws_route53_zone.mydomain.zone_id
  name    = var.dns_name
  type    = "A"
  alias {
    name                   = module.alb.dns_name
    zone_id                = module.alb.zone_id
    evaluate_target_health = true
  }
}
