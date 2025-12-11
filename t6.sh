#!/bin/bash
# Lab 2 – Activity A – Part 2 (Task 6 only)
# Assumes Tasks 1–5 are already done (httpd installed, /customsite configured)

RIT_ID="mbb1324"              # <-- change to YOUR RIT username if needed
DOMAIN="${RIT_ID}.com"

echo "=== Lab 2 Activity A – Part 2 (Task 6) for ${DOMAIN} ==="

# Create second site directory and index
echo "=== Creating /secondsite and index.html for second website ==="
mkdir -p /secondsite
echo "<h1>Second Website (site2.${DOMAIN})</h1>" > /secondsite/index.html

# Create VirtualHost config for second site
VHOST_CONF="/etc/httpd/conf.d/site2.conf"

echo "=== Creating VirtualHost config at ${VHOST_CONF} ==="
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

echo
echo "=== Task 6 setup complete. ==="
echo "Show your professor this file for the config:"
echo "  ${VHOST_CONF}"
echo "Then, after DNS CNAMEs are created, test remote access to:"
echo "  http://site2.${DOMAIN}"
