#!/bin/bash
sudo groupadd ansible
sudo mkdir /home/ansible
sudo useradd -g ansible -d /home/ansible -s /bin/bash ansible
sudo mkdir /home/ansible/.ssh
sudo cp /home/ubuntu/.ssh/authorized_keys /home/ansible/.ssh/authorized_keys
sudo chmod 700 /home/ansible/.ssh
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown ansible:ansible -R /home/ansible
