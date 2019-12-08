#!/bin/bash
server="$2"
type="$1"
if [ $type == "[webservers]" ];then
	sed -i "/^\[webservers\]/a $server" /home/ubuntu/ansible/ansible-go/inventory
else
	sed -i "/^\[webservers\]/a $server" /home/ubuntu/ansible/ansible-go/inve
ntory
fi
