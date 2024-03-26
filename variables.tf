variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}

variable "vpc_cidr" {
  type = string
}

variable "az_count" {
  type    = number
  default = 2
}

variable "default_tags" {
  type = map(any)
  default = {
    "engineer" : "lingwei"
    "resource" : "devops"
  }
}

variable "replicas" {
  default = "2"
}

variable "container_name" {
  default = "nginx"
}

variable "container_port" {
  default = "80"
}