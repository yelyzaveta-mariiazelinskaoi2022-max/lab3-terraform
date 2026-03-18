#!/bin/bash
set -e

WEB_PORT="${web_port}"
SERVER_NAME="${server_name}"
DOC_ROOT="${doc_root}"
STUDENT="${student}"
VARIANT="${variant}"

apt-get update -y
apt-get install -y apache2

systemctl stop apache2

sed -i "s/Listen 80/Listen $WEB_PORT/" /etc/apache2/ports.conf

mkdir -p "$DOC_ROOT"

cat > "$DOC_ROOT/index.html" <<HTMLEOF
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="UTF-8">
    <title>Lab 3 - Variant $VARIANT</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; background: #f0f4f8; }
        .box { background: white; padding: 40px; border-radius: 10px; display: inline-block; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #2d6a4f; }
        p { color: #555; }
    </style>
</head>
<body>
    <div class="box">
        <h1>Lab 3 Terraform - AWS EC2</h1>
        <p><strong>Student:</strong> $STUDENT</p>
        <p><strong>Variant:</strong> $VARIANT</p>
        <p><strong>Port:</strong> $WEB_PORT</p>
        <p><strong>ServerName:</strong> $SERVER_NAME</p>
        <p><strong>DocumentRoot:</strong> $DOC_ROOT</p>
    </div>
</body>
</html>
HTMLEOF

chown -R www-data:www-data "$DOC_ROOT"
chmod -R 755 "$DOC_ROOT"

cat > /etc/apache2/sites-available/lab3.conf <<APACHEEOF
<VirtualHost *:$WEB_PORT>
    ServerName $SERVER_NAME
    DocumentRoot $DOC_ROOT

    <Directory $DOC_ROOT>
        Options Indexes FollowSymLinks
        AllowOverride None
        Require all granted
    </Directory>

    ErrorLog /var/log/apache2/lab3_error.log
    CustomLog /var/log/apache2/lab3_access.log combined
</VirtualHost>
APACHEEOF

cat >> /etc/apache2/apache2.conf <<CONFEOF

<Directory $DOC_ROOT>
    Options Indexes FollowSymLinks
    AllowOverride None
    Require all granted
</Directory>
CONFEOF

a2dissite 000-default.conf
a2ensite lab3.conf

systemctl enable apache2
systemctl start apache2