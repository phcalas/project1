# Add Fail2ban repo
rpm -Uvh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
# Add some packages directly
yum install -y docker gparted git fail2ban vim nmap
# Prepare Fail2ban configuration (add local IP for avoiding ban)
sed -e 's/^\(ignoreip .*\)$/\1 192.168.0.0\/24/g' /etc/fail2ban/jail.conf > /etc/fail2ban/jail.local
systemctl restart fail2ban.service
systemctl enable fail2ban.service
# Finally Update whole system
yum upgrade -y

