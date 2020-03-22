# Add Fail2ban repo
yum -y install gamin-python python-inotify whois fail2ban git htop atop iftop iotop nmap vim
# Add docker repo
yum-config-manager --add-repo     https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-edge
# Add some packages directly
yum install -y docker-ce docker-ce-client gparted yum-utils device-mapper-persistent-data lvm2
# Prepare Fail2ban configuration (add local IP for avoiding ban)
sed -e 's/^\(ignoreip .*\)$/\1 192.168.0.0\/16, 172.16.0.0\/16/g' /etc/fail2ban/jail.conf > /etc/fail2ban/jail.local
systemctl restart fail2ban.service
systemctl enable fail2ban.service
# Start docker
systemctl start docker
systemctl enable docker
# Finally Update whole system
yum upgrade -y

