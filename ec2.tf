resource "aws_instance" "nginx" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              set -euo pipefail

              dnf update -y
              dnf install -y nginx

              cat > /usr/share/nginx/html/index.html <<'HTML'
              <!DOCTYPE html>
              <html>
                <head><title>Nginx on EC2</title></head>
                <body>
                  <h1>Nginx is running!</h1>
                  <p>Deployed with Terraform on Amazon Linux 2023.</p>
                </body>
              </html>
              HTML

              systemctl enable nginx
              systemctl start nginx
              EOF

  user_data_replace_on_change = true

  tags = {
    Name = "${var.project_name}-nginx"
  }
}
