# Define Local Values in Terraform
locals {
  environment = var.environment
  name = "${var.environment}"
  common_tags = {
    environment = local.environment
  }
  rds_tags= {
  
    Name       = local.name
    Example    = local.name
    Repository = "https://github.com/terraform-aws-modules/terraform-aws-rds"
  }
  asg_tags = [
    {
      key                 = "Project"
      value               = "secret"
      propagate_at_launch = true
    },
    {
      key                 = "foo"
      value               = "secret2"
      propagate_at_launch = true
    },
  ]

} 