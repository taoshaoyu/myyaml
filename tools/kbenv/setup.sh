#!/bin/bash

sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak
sudo sed 's@cn.archive.ubuntu.com@ftp.sjtu.edu.cn@' -i /etc/apt/sources.list

echo Installing k8s tools...
cat << EOF | sudo tee  /etc/apt/sources.list.d/kubernetes.list 
deb https://mirrors.aliyun.com/kubernetes/apt/ kubernetes-xenial main
EOF
curl -s https://mirrors.aliyun.com/kubernetes/apt/doc/apt-key.gpg | sudo apt-key add -

sudo apt update
sudo apt install -y kubeadm kubectl kubeadm

echo Installing docker-ce...
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce
sudo usermod -aG docker $USER

cat << EOF | sudo tee /etc/docker/daemon.json 
{
    "exec-opts": ["native.cgroupdriver=systemd"],
    "log-driver": "json-file",
    "log-opts": {
        "max-size": "100m"
    }
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker

echo   
echo      
echo Please re-login 