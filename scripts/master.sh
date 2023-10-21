#!/bin/bash

MASTER_IP=$1
NODENAME=$(hostname -s)
config_path="/vagrant/configs"

rm /etc/containerd/config.toml
systemctl restart containerd

sudo kubeadm init --apiserver-advertise-address=$MASTER_IP --apiserver-cert-extra-sans=$MASTER_IP --pod-network-cidr=$2 --node-name "$NODENAME" --ignore-preflight-errors Swap
mkdir -p "$HOME"/.kube
sudo cp -i /etc/kubernetes/admin.conf "$HOME"/.kube/config
sudo chown "$(id -u)":"$(id -g)" "$HOME"/.kube/config

if [ -d $config_path ]; then
  rm -f $config_path/*
else
  mkdir -p $config_path
fi


cp -i /etc/kubernetes/admin.conf /vagrant/configs/config
touch /vagrant/configs/join.sh
chmod +x /vagrant/configs/join.sh

kubeadm token create --print-join-command > /vagrant/configs/join.sh
chmod +x /vagrant/configs/join.sh
curl https://docs.projectcalico.org/manifests/calico.yaml -O -k

kubectl apply -f calico.yaml

sudo -i -u vagrant bash << EOF
whoami
mkdir -p /home/vagrant/.kube
sudo cp -i /vagrant/configs/config /home/vagrant/.kube/
sudo chown 1000:1000 /home/vagrant/.kube/config
EOF