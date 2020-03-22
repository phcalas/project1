# Stop minikbe & docker
minikube status && minikube stop
systemctl stop docker
systemctl disable docker
systemctl disable kubernates
# Remove installation & images & sockets
yum remove -y docker-ce docker-ce-client kubectl kubeadm kubelet containerd.io
rm -rf /var/lib/docker* /var/run/docker* /etc/kubernetes
# Remove repos
rm -f /etc/yum.repos.d/kubernetes.repo /etc/yum.repos.d/docker-ce.repo
# Remove minikube
rm /usr/local/bin/minikube
# Remove firewall rules
rm /etc/firewalld/services/minikube.xml
firewall-cmd --reload
# Remove Home context
rm -rf $HOME/.kube $HOME/.minikube
# put the Swap on
#to comment Swap mount at each reboot
sed -i '/swap/s/^#//' /etc/fstab