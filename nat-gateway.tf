# allocate elastic ip addresses(EIP 1)
#terraform aws allocate elastic ip
resource "aws_eip" "eip-for-nat-gateway-1" {
  vpc    = true
  tags    ={ 
    Name  = "Eip 1"
  }
      
}

# allocate elastic ip addresses(EIP 2)
#terraform aws allocate elastic ip
resource "aws_eip" "eip-for-nat-gateway-2" {
  vpc    = true
  tags    ={ 
    Name  = "Eip 2"
  }
      
}

#Create Nat Gateway 1 in Public subnet 1
# Terraform create aws nat gateway
resource "aws_nat_gateway" "nat-gateway-1"{

	allocation_id = aws_eip.eip-for-nat-gateway-1.id 
	subnet_id    = aws_subnet.private-subnet-1.id
	tags            ={
	Name          = "nat gateway public subnet 2"
}
}

#Create Nat Gateway 2 in Public subnet 2
# Terraform create aws nat gateway
resource "aws_nat_gateway" "nat-gateway-2"{

	allocation_id = aws_eip.eip-for-nat-gateway-2.id 
	subnet_id    = aws_subnet.private-subnet-2.id
	tags            ={
	Name          = "nat gateway public subnet 2"
}
}

# Create private Route Table   and add 	Route Through Nat Gateway 1
# terrraform aws create route table 
resource "aws_route_table" "private-route-table-1"{
	vpc_id          = aws_vpc.vpc.id
	route  {         
	cidr_block     = "0.0.0.0/0"
	nat_gateway_id   = aws_nat_gateway.nat-gateway-1.id
}
	tags        ={
	Name        = "private route table 1"
}
}

# associate Private subnet 1 with "Privat Route Table 1"
#terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-1-route-table-association"{
	subnet_id  = aws_subnet.private-subnet-1.id
	route_table_id  = aws_route_table.private-route-table-1.id
}

# associate Private subnet 3 with "Privat Route Table 1"
#terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-3-route-table-association"{
	subnet_id  = aws_subnet.private-subnet-3.id
	route_table_id  = aws_route_table.private-route-table-1.id
}

# Create private Route Table   and add 	Route Through Nat Gateway 2
# terrraform aws create route table 
resource "aws_route_table" "private-route-table-2"{
	vpc_id          = aws_vpc.vpc.id
	route  {         
	cidr_block     = "0.0.0.0/0"
	nat_gateway_id = aws_nat_gateway.nat-gateway-2.id
}
	tags        ={
	Name        = "private route table 2"
}
}

# associate Private subnet 2 with "Privat Route Table 2"
#terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-2-route-table-association"{
	subnet_id  = aws_subnet.private-subnet-2.id
	route_table_id  = aws_route_table.private-route-table-2.id
}

# associate Private subnet 4 with "Privat Route Table 2"
#terraform aws associate subnet with route table
resource "aws_route_table_association" "private-subnet-4-route-table-association"{
	subnet_id  = aws_subnet.private-subnet-4.id
	route_table_id  = aws_route_table.private-route-table-2.id
}