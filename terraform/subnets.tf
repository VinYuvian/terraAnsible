resource "aws_subnet" "publicSubnets"{
	vpc_id="${aws_vpc.mainVPC.id}"
	#count=3
	for_each=var.subnetPublic
	cidr_block=each.key
	map_public_ip_on_launch="true"
	availability_zone="${var.region}${each.value}"
	tags={
		Name="publicSubnet-${each.value}"
	}
}

resource "aws_subnet" "privateSubnets"{
	vpc_id="${aws_vpc.mainVPC.id}"
	for_each=var.subnetPrivate
	cidr_block=each.key
	availability_zone="${var.region}${each.value}"
	tags={
		Name="PrivateSubnet-${each.value}"
	}
}


