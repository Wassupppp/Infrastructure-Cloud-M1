variable "vpc_id" {
  description = "ID du VPC"
  type        = string
}

variable "subnets" {
  description = "Liste des IDs de sous-réseaux publics"
  type        = list(string)
}

variable "security_group_id" {
  description = "ID du security group (par défaut dans ce TP)"
  type        = string
}