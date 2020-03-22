# Minikube installation on CentOS

# prerequisite
cd $HOME

# Add repo: Docker, Kubernetes
yum install -y yum-utils device-mapper-persistent-data lvm2 overlay2
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum-config-manager --enable docker-ce-stable

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

# Remove SWAP on CentOS (mandatory for kubernetes)
swapoff -a
#to comment Swap mount at each reboot
sed -i '/swap/s/^/#/' /etc/fstab

yum install -y qemu-kvm qemu-guest-agent
modprobe kvm # Verif with #lsmod | grep kvm
modprobe virtio # Verifi with #lsmod | grep virtio
yum install -y docker-ce docker-ce-cli containerd.io # kubectl kubeadm kubelet
yum versionlock docker-ce docker-ce-cli # kubectl kubeadm kubelet
systemctl start docker
systemctl enable docker.service
docker run hello-world # Little test for docker

#Open port for Minikube
# preferable to define a service
# firewall-cmd --zone=public --permanent --add-port=8080/tcp
# firewall-cmd --zone=public --permanent --add-port=8443/tcp
# firewall-cmd --zone=public --permanent --add-port=10250/tcp
cat << EOF > /etc/firewalld/services/minikube.xml
<?xml version="1.0" encoding="utf-8"?>
<service>
  <short>Minikube minimun</short>
  <description>Three ports for Kubernetes API server (8443) and 	Kubelet API (10250)</description>
  <port protocol="tcp" port="8080"/>
  <port protocol="tcp" port="8443"/>
  <port protocol="tcp" port="10250"/>
</service>
EOF
firewall-cmd --reload #Take into account this new configuration for Kubernetes/minikube
firewall-cmd --get-services | grep minikube

# Launch install of the minikube instance
if [[ ! -x "/usr/local/bin/minikube" ]]; then
  curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64   && chmod +x minikube;
fi
mkdir -p /usr/local/bin
install minikube /usr/local/bin && rm minikube
systemctl enable kubelet.service

cat << EOF > /etc/kubernetes/bootstrap-kubelet.conf
apiVersion: kubelet.config.k8s.io/v1beta1
kind: KubeletConfiguration
clusterDNS:
- 10.96.0.10
EOF
mkdir -p .kube .minikube && minikube start --driver=none

# Verification
diff /etc/kubernetes/kubelet.conf $HOME/.kube/config
kubectl get nodes
kubectl get namespace
kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
kubectl get deployments
kubectl expose deployment hello-node --type=LoadBalancer --port=8080
kubectl get services
minikube service hello-node # get the conf of exposed loadbalancer
