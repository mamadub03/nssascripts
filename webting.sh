#!/bin/bash

echo "=== Installing Apache ==="
dnf install httpd -y
systemctl enable --now httpd

echo "=== Creating first site directory ==="
mkdir -p /customsite
echo "<h1>NSSA Rocky Site (no not the movie!)</h1>" > /customsite/index.html

echo "=== Updating httpd.conf to use /customsite as DocumentRoot ==="
sed -i 's|DocumentRoot "/var/www/html"|DocumentRoot "/customsite"|' /etc/httpd/conf/httpd.conf
sed -i 's|<Directory "/var/www">|<Directory "/customsite">|' /etc/httpd/conf/httpd.conf

# Ensure Directory block is present
grep -q '/customsite' /etc/httpd/conf/httpd.conf || cat <<EOF >> /etc/httpd/conf/httpd.conf

<Directory "/customsite">
    AllowOverride None
    Require all granted
</Directory>
EOF

echo "=== Creating second virtual host (site2) ==="
mkdir -p /secondsite
echo "<h1>Second Website</h1>" > /secondsite/index.html

cat <<EOF > /etc/httpd/conf.d/secondsite.conf
<VirtualHost *:80>
    ServerName site2.yourID.com
    DocumentRoot /secondsite
    <Directory /secondsite>
        Require all granted
    </Directory>
</VirtualHost>
EOF

echo "=== Restarting Apache ==="
systemctl restart httpd

echo "=== Automated setup complete ==="
echo "Now create these DNS CNAMEs on Windows Server:"
echo "site1.yourID.com → rockyclient.yourID.com"
echo "site2.yourID.com → rockyclient.yourID.com"
