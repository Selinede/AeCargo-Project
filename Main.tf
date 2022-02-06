

# Main Project_VPC


resource "aws_vpc" "AeCargo_vpc" {
  cidr_block       = var.vpc-cidr
  instance_tenancy = "default"

  tags = {
    Name = var.tag-post
  }
}


# Public Subnet_1

resource "aws_subnet" "Public_Subnet1" {

  vpc_id     = aws_vpc.AeCargo_vpc.id
  cidr_block = var.Public_Subnet1-cidr
  
  
     
    availability_zone = "us-east-1a"
    tags = {
       Name = "Public_Subnet1"
  }
}


# Public Subnet_2

resource "aws_subnet" "Public_Subnet2" {
  vpc_id     = aws_vpc.AeCargo_vpc.id
    cidr_block = var.Public_Subnet2-cidr
  
 availability_zone = "us-east-1b"
 
    
       tags = {
         Name = "Public_Subnet2"
  }
}



# Private Subnet_1

resource "aws_subnet" "Private_Subnet1" {
  vpc_id     = aws_vpc.AeCargo_vpc.id
  cidr_block = var.Private_Subnet1-cidr

     
    availability_zone = "us-east-1c"
    tags = {
       Name = "Private_Subnet1"
  }
}

# Private Subnet_2

resource "aws_subnet" "Private_Subnet2" {
  vpc_id     = aws_vpc.AeCargo_vpc.id
  cidr_block = var.Private_Subnet2-cidr

  
     
    availability_zone = "us-east-1d"
    tags = {
       Name = "Private_Subnet2"
  }
}




# The Private Route Table


resource "aws_route_table" "PriRoute_Table" {
  vpc_id = aws_vpc.AeCargo_vpc.id

  
  tags = {
    Name = "PriRoute_Table"
  }
}


# The Public Route Table

resource "aws_route_table" "PubRoute_Table" {
  vpc_id = aws_vpc.AeCargo_vpc.id

  
  tags = {

    Name = "PubRoute_Table"
  }
}

# The association of Public Subnet1 With Public Route Table

resource "aws_route_table_association" "Pub_RTA1" {
  subnet_id      = aws_subnet.Public_Subnet1.id
  route_table_id = aws_route_table.PubRoute_Table.id
}


# The Second association of Public Subnets With Public Route Table_Public Subnet_2

resource "aws_route_table_association" "Pub_RTA2" {
  subnet_id      = aws_subnet.Public_Subnet2.id
  route_table_id = aws_route_table.PubRoute_Table.id
  }


# The first association of Private Subnets With Public Route Table_Public Subnet_2

resource "aws_route_table_association" "Pri_RTA1" {
  subnet_id      = aws_subnet.Private_Subnet1.id
  route_table_id = aws_route_table.PriRoute_Table.id
}

resource "aws_route_table_association" "PriRoute_RTA2" {
  subnet_id      = aws_subnet.Private_Subnet2.id
  route_table_id = aws_route_table.PriRoute_Table.id
}


# The_Internet Gateway 


resource "aws_internet_gateway" "AeCargo-IGW10" {
  vpc_id       = aws_vpc.AeCargo_vpc.id

  tags = {
    Name       = "AeCargo-IGW10"
  }
}


# Connection of Routable and Internet Gate-Way

# Conection of Route to Internet GW And Public-Routetable


resource "aws_route" "Pub-route-IGW" {
  route_table_id            = aws_route_table.PubRoute_Table.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.AeCargo-IGW10.id   
              
} 
