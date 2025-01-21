variable "env" {
  type    = string
  default = "dev"
}

##VPC
variable "vpc_conf" {
  type = map(any)
  default = {
    name                 = "my-vpc"
    cidr                 = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support   = true
  }
}

variable "region" {
  description = "The AWS region where resources will be created."
  type        = string
  default     = "us-west-2"
}

variable "public_subnets" {
  description = "A map of public subnet CIDR blocks keyed by their respective availability zones."
  type        = map(string)
  default = {
    "us-west-2a" = "10.0.1.0/24"
    "us-west-2b" = "10.0.2.0/24"
    "us-west-2c" = "10.0.3.0/24"
  }
}

variable "private_subnets" {
  description = "A map of private subnet CIDR blocks keyed by their respective availability zones."
  type        = map(string)
  default = {
    "us-west-2a" = "10.0.4.0/24"
    "us-west-2b" = "10.0.5.0/24"
    "us-west-2c" = "10.0.6.0/24"
  }
}

variable "instance_type" {
  description = "The EC2 instance type for the Auto Scaling Group."
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "The AMI ID to be used for the EC2 instances."
  type        = string
  default     = "ami-0735c191cf914754d"  # Example AMI ID
}

variable "alb_sg_ingress_rules" {
  type = any
  default = {
    http = {
      description = "HTTP from anywhere"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    https = {
      description = "HTTPS from anywhere"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "alb_sg_egress_rules" {
  type = any
  default = {
    all = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ec2_sg_ingress_rules" {
  type = any
  default = {
    http = {
      description = "HTTP from ALB"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]  # VPC CIDR
    }
  }
}

variable "ec2_sg_egress_rules" {
  type = any
  default = {
    all = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "rds_conf" {
  type = any
  default = {
    identifier           = "my-rds-instance"
    allocated_storage    = 20
    storage_type        = "gp2"
    engine              = "mysql"
    engine_version      = "8.0.28"
    instance_class      = "db.t3.micro"
    username            = "admin"
    password            = "dummy_password_123"
    skip_final_snapshot = true
    multi_az           = false
  }
}

variable "rds_sg_ingress_rules" {
  type = any
  default = {
    mysql = {
      description = "MySQL from EC2 instances"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = ["10.0.0.0/16"]  # VPC CIDR
    }
  }
}

variable "rds_sg_egress_rules" {
  type = any
  default = {
    all = {
      description = "Allow all outbound traffic"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
