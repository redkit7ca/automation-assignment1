variable "rg_name" {default = "group4-assignment1-rg"}
variable "location" { default = "canadacentral"}

variable "windows_avs" {default = "windows-avs"}
variable "windows_name" {
  type = map(string)
  default = {
    lab-appl-w-vm1 = "Standard_B1s"
  }
}
variable "username" {  default = "auto"}
variable "password" {  default = "automation@1234"}
# variable "public_key" {  default = "/home/auto/.ssh/id_rsa.pub"}
variable "wos_disk_attributes" {
  type = map(string)
  default = {
    wos_storage_account_type = "StandardSSD_LRS"
    wos_disk_size            = "127"
    wos_disk_caching         = "ReadWrite"
  }
}
variable "win_publisher" {default = "MicrosoftWindowsServer"}
variable "win_offer" {default = "WindowsServer"}
variable "win_sku" {default = "2016-Datacenter"}
variable "win_version" {default = "latest"}
variable "subnet_id" {}
# Define in main module



