resource "aws_key_pair" "webKey"{
	key_name="webKey"
	public_key="${file("${var.PUBLIC_WEB_KEY}")}"
}

resource "aws_security_group" "webSG"{
	vpc_id="${aws_vpc.mainVPC.id}"
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
	subnet_id="${aws_subnet.publicSubnets["10.0.1.0/24"].id}"
	security_groups=["${aws_security_group.webSG.id}"]
	instance_type="t2.micro"
	user_data="${file("../user.sh")}"
	key_name="${aws_key_pair.webKey.key_name}"
	ami="ami-04b9e92b5572fa0d1"
	tags={
		Name="webApp"
	}
}
