resource "aws_key_pair" "webKey"{
	key_name="webKey"
	public_key="${file("webKey.pub")}"
}

resource "aws_security_group" "webSG"{
	#vpc_id="${aws_vpc.mainVPC.id}"
	#subnet_id="${aws_subnet.publicSubnets["10.0.1.0/24"]}"
	ingress{
		from_port=22
		to_port=22
		protocol="tcp"
		cidr_blocks=["0.0.0.0/0"]

	}
	egress{
		from_port=0
		to_port=0
		protocol="-1"
		cidr_blocks=["0.0.0.0/0"]
	}
	tags={
		Name="webSG"
	}
}

resource "aws_instance" "webApp"{
	#subnet_id="${aws_subnet.publicSubnets["10.0.1.0/24"]}"
	security_groups=["${aws_security_group.webSG.name}"]
	instance_type="t2.micro"
	ami="ami-04b9e92b5572fa0d1"
	user_data="${file("user_data.sh")}"
	key_name="${aws_key_pair.webKey.key_name}"
	tags={
		Name="webApp"
	}

	provisioner "file"{
		source="/home/ubuntu/keys/ansibleKey.pub"
		destination="/home/ansible/.ssh/ansibleKey.pub"
	}

	provisioner "remote-exec"{
		inline=[
			"cat /home/ansible/.ssh/ansibleKey.pub >> /home/ansible/.ssh/authorized_keys",
			] 
		#command="ssh-copy-id -i ansibleKey -o 'IdentityFile webKey.pub' ansible@${aws_instance.webApp.public_ip}"
	}
	
	connection{
		user="ansible"
		type="ssh"
		private_key="${file("webKey")}"
		host=self.public_ip
	}
}
