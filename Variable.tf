

# REFERENCE FILE
# REGION

variable "region" {
    type         = string
    description  = "US"
    default      ="us-east-1"
}

# VPC CIDR cidr_block

variable "vpc-cidr" {
  type         = string
  default      = "10.0.0.0/16"
  description  = "myvpc-cidr"
    
}


variable "tag-post" {
  type         = string
  default      = "AeCargo_vpc"
  description  = "tag name"
    
}

# PUBLIC SUBNET1 variable

variable "Public_Subnet1-cidr"{
    type          = string
    description   = "Public_Subnet1"
    default       = "10.0.1.0/24"
}

# PUBLIC SUBNET2 variable

variable "Public_Subnet2-cidr"{
    type          = string
    description   = "Public_Subnet2"
    default       = "10.0.2.0/24"
}

# PRIVATE SUBNET1 variable

variable "Private_Subnet1-cidr"{
    type          = string
    description   = "Private_Subnet1"
    default       = "10.0.3.0/24"
}

# PRIVATE SUBNET2 variable

variable "Private_Subnet2-cidr"{
    type          = string
    description   = "Private_Subnet2"
    default       = "10.0.4.0/24"
    
}




