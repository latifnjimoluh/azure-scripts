#!/bin/bash
# Mettre à jour et installer Flask
apt-get update && apt-get install -y python3-pip

# Créer le code Flask
cat <<EOF > /home/azureuser/app.py
from flask import Flask
app = Flask(__name__)
@app.route('/')
def hello():
    return 'Hello from Flask!'
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

# Créer un service systemd pour que Flask tourne toujours
cat <<EOF > /etc/systemd/system/flaskapp.service
[Unit]
Description=Flask Web App
After=network.target

[Service]
User=azureuser
WorkingDirectory=/home/azureuser
ExecStart=/usr/bin/python3 /home/azureuser/app.py
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Activer et démarrer le service
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
