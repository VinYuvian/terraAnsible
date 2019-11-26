resource "aws_internet_gateway" "mainGW"{
	vpc_id="${aws_vpc.mainVPC.id}"
	tags={
		Name="mainGateway"
	}
}
