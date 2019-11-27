resource "aws_key_pair" "webKey"{
	key_name="webKey"
	public_key="${var.PUBLIC_WEB_KEY}"
}

resource "aws_security_group" "webSG"{
	vpc_id="${aws_vpc.mainVPC.id}"
	igress{
		from_port=22
		to_port=22
		protocol="tcp"
		cidr_blocks=["0.0.0.0/0"]

	}
}
