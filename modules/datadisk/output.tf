# FOR DATA DISK NO VALUE REQUIRED.
output "resource_group_name" {
  value = azurerm_resource_group.disk_rg.name
}
output "disk_name1" {
  value = azurerm_managed_disk.data_disk1
}
output "disk_name2" {
  value = azurerm_managed_disk.data_disk2
}
output "disk_name3" {
  value = azurerm_managed_disk.data_disk3
}
output "disk_type" {
    default = "Standard_LRS"
  //value = azurerm_managed_disk.disk.storage_account_type
}
