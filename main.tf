locals {
  common_tags = {
    Project = var.project_name
  }

  web_ingress_rules = concat(
    [{
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }],
    length(var.allowed_ssh_cidr) > 0 ? [{
      description = "SSH"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = var.allowed_ssh_cidr
    }] : []
  )
}

module "vpc" {
  source = "./modules/vpc"

  name_prefix          = var.project_name
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidr   = var.public_subnet_cidr
  tags                 = local.common_tags
}

module "web_security_group" {
  source = "./modules/security-group"

  name_prefix   = "${var.project_name}-web"
  vpc_id        = module.vpc.vpc_id
  description   = "Allow HTTP traffic to Nginx"
  ingress_rules = local.web_ingress_rules
  tags          = local.common_tags
}

module "nginx_server" {
  source = "./modules/ec2"

  name_prefix        = "${var.project_name}-nginx"
  subnet_id          = module.vpc.public_subnet_id
  security_group_ids = [module.web_security_group.security_group_id]
  instance_type      = var.instance_type
  user_data          = file("${path.module}/templates/nginx-user-data.sh")
  tags               = local.common_tags
}
