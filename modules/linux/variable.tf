# rg1 defined in modules/main.tf
variable "rg1" {}
variable "location" {}
variable "subnet_id" {}

variable "linux_avset" {
  default = "linux_avs"
}
variable "linux_username" {
  default = "auto"
}
variable "linux_name" {
  type    = map(string)
  default = {}
}
variable "linux_os_disk" {
  type = map(string)
  default = {
    los_disk_caching         = "ReadWrite"
    los_storage_account_type = "Standard_LRS"
    los_disk_size            = "32"
  }
}
variable "linux_publisher" { default = "OpenLogic" }
variable "linux_offer" { default = "CentOS" }
variable "linux_sku" { default = "7.5" }
variable "linux_version" { default = "latest" }
