resource "aws_eip" "eipNAT"{
	vpc="true"
}

resource "aws_nat_gateway" "natGW"{
	allocation_id="${aws_eip.eipNAT.id}"
	subnet_id="${aws_subnet.publicSubnets["10.0.1.0/24"].id}"
	tags={
		Name="natGateWay"
	}
}
