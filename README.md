# project-
```hcl
module "project"{
    source = ""
    version = "0.0.1"
    region = "us-east-2"
    ec2_type = "t2.micro"
    vpc_cidr = "10.0.0.0/16"
    common_tags = "Group-1"
    subnet_cidr1 = "10.0.1.0/24"
    subnet_cidr2 = "10.0.2.0/24"
    subnet_cidr3 = "10.0.3.0/24"
    private_subnet_cidr = "10.0.101.0/24"
    private_subnet_cidr2 = "10.0.102.0/24"
    private_subnet_cidr3 = "10.0.103.0/24"
    az1 = "us-east-2a"
    az2 = "us-east-2b"
    az3 = "us-east-2c"
    ip_on_launch = true
    sg_group ="security_group"
    default_cidr_block = "0.0.0.0/0"
}```