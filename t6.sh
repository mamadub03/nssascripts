#!/bin/bash
# Lab 2 – Step 6: Second website + VirtualHost

RIT_ID="mbb1324"              # <-- change if your RIT ID is different
DOMAIN="${RIT_ID}.com"

echo "=== Step 6 – Creating second website for site2.${DOMAIN} ==="

# Create second site's directory and content
mkdir -p /secondsite
echo "<h1>Second Website (site2.${DOMAIN})</h1>" > /secondsite/index.html

# Create the VirtualHost config for site2
VHOST_CONF="/etc/httpd/conf.d/site2.conf"

cat <<EOF > "${VHOST_CONF}"
<VirtualHost *:80>
    ServerName site2.${DOMAIN}
    DocumentRoot /secondsite
    <Directory /secondsite>
        Require all granted
    </Directory>
</VirtualHost>
EOF

echo "=== Restarting Apache ==="
systemctl restart httpd

echo "=== Done. VirtualHost config created at ${VHOST_CONF} ==="
echo "Show this file to your professor for Step 6:"
echo "  cat ${VHOST_CONF}"
