#!/bin/bash
apt-get update && apt-get install -y nginx
cat <<"EOF" > /etc/nginx/sites-available/default
server {
    listen 80;
    location / {
        proxy_pass http://localhost:5000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
    }
}
EOF
systemctl restart nginx
