resource "aws_route_table" "publicRoute"{
	vpc_id="${aws_vpc.mainVPC.id}"
	tags={
		Name="publicRouteTable"
	}
}

resource "aws_route_table" "privateRoute"{
	vpc_id="${aws_vpc.mainVPC.id}"
	tags={
		Name="privateRouteTable"
	}
}

resource "aws_route" "publicRoute"{
	route_table_id="${aws_route_table.publicRoute.id}"
	destination_cidr_block="0.0.0.0/0"
	gateway_id="${aws_internet_gateway.mainGW.id}"
}

resource "aws_route" "privateRoute"{
	route_table_id="${aws_route_table.privateRoute.id}"
	destination_cidr_block="0.0.0.0/0"
	gateway_id="${aws_nat_gateway.natGW.id}"
}

resource "aws_route_table_association" "publicAssociation"{
	route_table_id="${aws_route_table.publicRoute.id}"
	for_each="${aws_subnet.publicSubnets}"
	subnet_id="${aws_subnet.publicSubnets["${each.key}"].id}"
}

resource "aws_route_table_association" "privateAssociation"{
	route_table_id="${aws_route_table.privateRoute.id}"
	for_each="${aws_subnet.privateSubnets}"
        subnet_id="${aws_subnet.privateSubnets["${each.key}"].id}"	
}
