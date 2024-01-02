#!/bin/bash


echo "---Step 1: Update and Upgrade Ubuntu (all nodes)"

sudo apt update
sudo apt upgrade -y

echo "----Step 2: Disable Swap (all nodes)"
#To enhance Kubernetes performance, disable swap and set essential kernel parameters.

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

echo "---Step 3: Add Kernel Parameters (all nodes)"
#Load the required kernel modules on all nodes:
sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

echo "---Configure the critical kernel parameters for Kubernetes using the following:"
sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

echo "---Then, reload the changes:"
sudo sysctl --system

echo "---Step 4: Install Containerd Runtime (all nodes)"
#We are using the containerd runtime. Install containerd and its dependencies with the following commands---ok -ok:
sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

echo "---enable the Docker repository:"
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

echo "---Update the package list and install containerd:"
sudo apt update
sudo apt install -y containerd.io

echo "---Configure containerd to start using systemd as cgroup:"
containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1
sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

echo "---Restart and enable the containerd service:"
sudo systemctl restart containerd
sudo systemctl enable containerd

echo "---Step 5: Add Apt Repository for Kubernetes (all nodes)"
#Kubernetes packages are not available in the default Ubuntu 22.04 repositories. Add the Kubernetes repositories with the following commands:

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-xenial.gpg
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

echo "---Step 6: Install Kubectl, Kubeadm, and Kubelet (all nodes)"
#After adding the repositories, install essential Kubernetes components, including kubectl, kubelet, and kubeadm, on all nodes with the following commands:

sudo apt update
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl


if [[ "$1" == 'master' ]]; then
echo "---Step 7: Initialize Kubernetes Cluster with Kubeadm (master node)"
#With all the prerequisites in place, initialize the Kubernetes cluster on the master node using the following Kubeadm command:

sudo kubeadm init

echo "---After the initialization is complete make a note of the kubeadm join command for future reference."

#Run the following commands on the master node:

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "---Next, use kubectl commands to check the cluster and node status:"

#kubectl get nodes

echo "---Step 8: Add Worker Nodes to the Cluster (worker nodes)"
echo "---On each worker node, use the kubeadm join command you noted down earlier:"
sleep 5

echo "---Step :9 Install Kubernetes Network Plugin (master node)"
#To enable communication between pods in the cluster, you need a network plugin. Install the Calico network plugin with the following command from the master node:

kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

echo "---Step 10: Verify the cluster and test (master node)"
echo "---Finally, we want to verify whether our cluster is successfully created."
sleep 10
kubectl get pods -n kube-system

sleep 10
kubectl get nodes

else
	echo "enter worker as argument for worker node"
fi

if [[ "$1" == 'worker' ]]; then
echo "------------------------------------------------------------------------------------"
echo "    1. switch to root user: sudo su -"
echo "    2. Allow incoming traffic to port 6443 in control-plane (master node)"
echo "    3. Run the kubeadm join <TOKEN> command which we get from master"
echo "    4. Run 'kubectl get nodes' on the control-plane to see this node joined the cluster."
echo "------------------------------------------------------------------------------------"
fi
