resource "aws_key_pair" "dbKey"{
	key_name="dbKey"
	public_key="${file("${var.PUBLIC_WEB_KEY}")}"
}

resource "aws_security_group" "dbSG"{
	vpc_id="${aws_vpc.mainVPC.id}"
	#subnet_id="${aws_subnet.privateSubnets["10.0.2.0/24"]}"
	ingress{
		from_port=3306
		to_port=3306
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
		Name="dbSG"
	}
}

resource "aws_instance" "dbInstance"{
	subnet_id="${aws_subnet.privateSubnets["10.0.1.0/24"].id}"
	security_groups=["${aws_security_group.webSG.id}"]
	instance_type="t2.micro"
	user_data="${file("../user_data.sh")}"
	key_name="${aws_key_pair.dbkey.key_name}"
	ami="ami-04b9e92b5572fa0d1"
	tags={
		Name="dbInstance"
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
  provisioner "local-exec"{
			command="sed '/\"[dbservers]"\]/i${aws_instance.dbInstance.private_ip}' ../ansible/ansible-go/inventory"	
	}
  

  connection{
                user="ansible"
                type="ssh"
                private_key="${file("/home/ubuntu/keys/dbKey")}"
                host=self.public_ip
        }
}
