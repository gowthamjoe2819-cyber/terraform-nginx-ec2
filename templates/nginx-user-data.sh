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
