variable "private_subnet_ids" {
  type = list(string)
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}


variable "instance_class" {
  type    = string
  default = "db.t3.micro"
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "vpc_id" {
  type = string
}

variable "name" {
    type = string
}

