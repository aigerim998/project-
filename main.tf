provider "aws" {
  region = var.region
}

resource "aws_vpc" "group1" {
  cidr_block       = var.vpc_cidr
enable_dns_hostnames = true
  tags = {
    Name = var.common_tags}

}

#Public Subnets

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.group1.id
  cidr_block = var.subnet_cidr1
  availability_zone = var.az1
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Subnet1"
  }
}
resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.group1.id
  cidr_block = var.subnet_cidr2
  availability_zone =var.az2
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Subnet2"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id     = aws_vpc.group1.id
  cidr_block = var.subnet_cidr3
  availability_zone = var.az3
  map_public_ip_on_launch = var.ip_on_launch

  tags = {
    Name = "Subnet3"
  }
}

#Private subnets

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.group1.id
  cidr_block = var.private_subnet_cidr1
  availability_zone = var.az1


  tags = {
    Name = "Private_Subnet"
  }

}

resource "aws_subnet" "private_subnet2" {
  vpc_id     = aws_vpc.group1.id
  cidr_block = var.private_subnet_cidr2
  availability_zone = var.az2


  tags = {
    Name = "Private_Subnet2"
  }

}

resource "aws_subnet" "private_subnet3" {
  vpc_id     = aws_vpc.group1.id
  cidr_block = var.private_subnet_cidr3
  availability_zone = var.az3


  tags = {
    Name = "Private_Subnet3"
  }

}


#Internet Gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.group1.id

  tags = {
    Name = "igw_group1"
  }
}

resource "aws_route_table" "rt_group1" {
  vpc_id = aws_vpc.group1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }


  tags = {
    Name = "route-table"
  }
}

resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.rt_group1.id 
}
resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.rt_group1.id
} 
resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.subnet3.id
  route_table_id = aws_route_table.rt_group1.id
}

#Database Subnet Group

# resource "aws_db_subnet_group" "db_sg" {
# name = "subnet_group"
# subnet_ids =[aws_subnet.private_subnet.id, aws_subnet.private_subnet2.id, aws_subnet.private_subnet3.id]
# }

# awd cdgbgv

# module "asg" {
#   source = "terraform-aws-modules/auto scaling/aws "

# #auto scaling group
# name = "example-asg"

# min-size                    = 2
# max_size                    = 4
# desired_capacity            = 2
# wait_for_capacity_timeout   = 0
# health_check_type           = "EC2"
# availability_zones          = ["us-east-2a","us-east-2b","us-east-2c"]

# #Launch template
# launch_template_name       = "example-asg"
# launch_template_description = " Launch template example"
# update-default_version      = true

# image_id = "ami-080c09858e04800a1"
# instance_type = "t2.micro"
# ebs_optimixed = true
# enable_monitoring = true
#}
