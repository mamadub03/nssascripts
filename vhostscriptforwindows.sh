#!/bin/bash
# Script to create VirtualHost for site1 (main site)

RIT_ID="mbb1324"                      # <-- change if needed
DOMAIN="${RIT_ID}.com"
VHOST_CONF="/etc/httpd/conf.d/site1.conf"

echo "=== Creating VirtualHost for site1.${DOMAIN} ==="

sudo bash -c "cat <<EOF > ${VHOST_CONF}
<VirtualHost *:80>
    ServerName site1.${DOMAIN}
    DocumentRoot /customsite
    <Directory /customsite>
        Require all granted
    </Directory>
</VirtualHost>
EOF"

echo "=== Restarting Apache ==="
sudo systemctl restart httpd

echo
echo "=== DONE ==="
echo "site1 VirtualHost created at ${VHOST_CONF}"
echo "You can view it with:"
echo "  cat ${VHOST_CONF}"
echo
echo "Test after DNS CNAME is set:"
echo "  http://site1.${DOMAIN}"
