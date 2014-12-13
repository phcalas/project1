# Add repo for Google Chrome
zypper addrepo  http://dl.google.com/linux/rpm/stable/x86_64/ google
# Add repo for Jenkins
zypper addrepo  http://pkg.jenkins-ci.org/opensuse-stable/ jenkins
# Refresh all repos 
zypper -n refresh
# Add some packages directly
zypper -n in docker thunderbird go java-1_8_0-openjdk-devel java-1_7_0-openjdk-devel gparted virtualbox
# Finally Update whole system
zypper -n up -l
# Install other packages by hand
echo "Lanch: zypper  in google-chrome jenkins" 

