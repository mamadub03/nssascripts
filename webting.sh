#!/bin/bash
# Lab 2 – Activity A – Part 1 (Tasks 1–5)
# This script does:
# 1) Install Apache
# 2) Create index.html in a non-default directory (/customsite)
# 3) Point httpd.conf DocumentRoot to /customsite
# You will then manually:
# 4) Show the site locally (http://localhost)
# 5) Show the site remotely from Windows 10 using Rocky's IP

echo "=== Lab 2 Activity A – Part 1 (Tasks 1–3) ==="

# Task 1 – Install Apache
echo "=== [1] Installing Apache (httpd) ==="
dnf install -y httpd

echo "=== Enabling and starting httpd ==="
systemctl enable --now httpd

# Task 2 – index.html in non-default directory
echo "=== [2] Creating /customsite and index.html ==="
mkdir -p /customsite
echo "<h1>Main NSSA Rocky Site</h1>" > /customsite/index.html

# Task 3 – Update httpd.conf to use /customsite as DocumentRoot
HTTPD_CONF="/etc/httpd/conf/httpd.conf"

echo "=== [3] Updating ${HTTPD_CONF} to use /customsite as DocumentRoot ==="
sed -i 's|DocumentRoot "/var/www/html"|DocumentRoot "/customsite"|' "$HTTPD_CONF"
sed -i 's|<Directory \"/var/www\">|<Directory \"/customsite\">|' "$HTTPD_CONF"

# Make sure /customsite has an access block (in case the default was different)
if ! grep -q 'Directory "/customsite"' "$HTTPD_CONF"; then
  cat <<EOF >> "$HTTPD_CONF"

<Directory "/customsite">
    AllowOverride None
    Require all granted
</Directory>
EOF
fi

echo "=== Restarting Apache ==="
systemctl restart httpd

echo
echo "=== Script finished – Tasks 1–3 are done. ==="
echo "Now do:"
echo "  Task 4: On Rocky, open http://localhost and show the page."
echo "  Task 5: From Windows 10, open http://<Rocky_IP> and show the page."

#use this to unblock fire walls
#sudo firewall-cmd --add-service=http --permanent
#sudo firewall-cmd --reload
