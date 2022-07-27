#!/usr/bin/env bash

# Install all the Docker Environment
sudo apt-get update

sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

wget -qO- https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

wget https://raw.githubusercontent.com/appliedbinf/pima-docker/main/Interfaces/pima.sh
wget https://raw.githubusercontent.com/appliedbinf/pima-docker/main/Interfaces/pima_interface.py

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

# Install the Nvidia Toolkit and Nvidia Drivers
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

wget -qO- https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
wget -qO- https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update && sudo apt-get install -y nvidia-container-toolkit

# Create docker user group and add current user to it
# user=$SUDO_USER
# echo $user
# sudo groupadd -f docker #Force the creation of the group
# sudo usermod -aG docker $user
# sudo newgrp docker
# sudo service docker restart

# Create Docker Volume
sudo docker volume create pima
mkdir Temp_Data

#create plasmid database
wget http://pima.appliedbinf.com/data/plasmids_and_vectors.fasta
mv plasmids_and_vectors.fasta Temp_Data/plasmids_and_vectors.fasta

#create kraken standard database
wget https://genome-idx.s3.amazonaws.com/kraken/k2_standard_20210517.tar.gz
tar -xvf k2_standard_20210517.tar.gz --directory Temp_Data/kraken2

sudo docker run --rm -v `pwd`:/src -v pima:/data busybox cp -r /Data/Temp_Data /data

rm -r Temp_Data


