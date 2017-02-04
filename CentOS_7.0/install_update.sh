# Add Fail2ban repo
yum -y install gamin-python python-inotify whois
rpm -Uvh https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-0.9.5-3.el7.noarch.rpm \
	https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-firewalld-0.9.5-3.el7.noarch.rpm \
	https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-sendmail-0.9.5-3.el7.noarch.rpm \
	https://dl.fedoraproject.org/pub/epel/7/x86_64/f/fail2ban-server-0.9.5-3.el7.noarch.rpm
# Add some packages directly
yum install -y docker gparted vim nmap
# Prepare Fail2ban configuration (add local IP for avoiding ban)
sed -e 's/^\(ignoreip .*\)$/\1 192.168.0.0\/24/g' /etc/fail2ban/jail.conf > /etc/fail2ban/jail.local
systemctl restart fail2ban.service
systemctl enable fail2ban.service
# Finally Update whole system
yum upgrade -y

