<h1> CentOS 7.0 installation for Virtualisation (docker, QEMU, XEN, ...) with fail2ban</h1>

<h2> Installation from DVD</h2>

* Launch <B>I</B>nstall
* Choose installation language
* Configure "NETWORK & HOSTNAME"
* Configure "DATE & TIME"
* Configure "SOFTWARE SELECTION"
  Check "Virtualization Host" with Add-Ons "Virtualization Platform"
* Verify "INSTALLATION DESTINATION"
* Then "Begin Installation"
* Choose a password 

<h2>. Installation normally done</h2>

* Connect as root on system
<pre>
  # yum install -y git-core
  # git clone https://github.com/phcalas/project1.git
  # cd project1/CentOS_7.0
  # sh ./install_update.sh
</pre>
  

