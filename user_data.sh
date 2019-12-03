#/bin/bash
sudo su -
groupadd ansible
mkdir /home/ansible
useradd -g ansible -d /home/ansible ansible
cp /home/ubuntu/.ssh/authorized_keys /home/ansible/.ssh/authorized_key
chmod 700 /home/ansible/.ssh
chmod 600 /home/ansible/.ssh/authorized_keys
chown -R /home/ansible

