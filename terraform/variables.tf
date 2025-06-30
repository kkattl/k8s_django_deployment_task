variable "project" {
  type        = string
  default     = "demo-django"
}

variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "vpc_id" {
  type        = string
}

variable "private_subnet_ids" {
  type        = list(string)
}

variable "db_username" {
  type        = string
  default     = "dbadmin"
}

variable "db_name" {
  type        = string
  default     = "appdb"
}

variable "db_engine_version" {
  type        = string
  default     = "14.9"
}
