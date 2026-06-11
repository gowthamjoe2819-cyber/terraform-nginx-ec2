output "vpc_id" {
  description = "ID of the custom VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "security_group_id" {
  description = "ID of the web security group"
  value       = module.web_security_group.security_group_id
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = module.nginx_server.instance_id
}

output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = module.nginx_server.public_ip
}

output "nginx_url" {
  description = "URL to access the Nginx welcome page"
  value       = "http://${module.nginx_server.public_ip}"
}
