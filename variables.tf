variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "eu-central-1"
}

variable "student_name" {
  description = "Student first name"
  type        = string
}

variable "student_surname" {
  description = "Student last name"
  type        = string
}

variable "variant_num" {
  description = "Lab variant number"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}

variable "subnet_a_cidr" {
  description = "CIDR for subnet A (eu-central-1a)"
  type        = string
}

variable "subnet_b_cidr" {
  description = "CIDR for subnet B (eu-central-1b)"
  type        = string
}

variable "web_port" {
  description = "Port for Apache web server"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "apache_server_name" {
  description = "Apache ServerName directive"
  type        = string
}

variable "apache_doc_root" {
  description = "Apache DocumentRoot path"
  type        = string
}