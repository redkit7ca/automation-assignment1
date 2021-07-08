variable "rg1" {}
variable "location" { default = "CanadaCentral"}

locals {
common_tags = {
    Name         = "Terraform Group Project"
    GroupMembers = "Vishnu, Ridvan, Daniel"
    ExpirationDate = "2021-07-31"
    Environment = "Lab"
  }

}