resource "azurerm_managed_disk" "data_disk1" {
  for_each = var.windows_name
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.rg1
  storage_account_type = "Standard_LRS"
  create_option        = "empty"
  disk_size_gb         = "10"
  depends_on = [azurerm_windows_virtual_machine.vmwindows]
  tags = var.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach1" {
  for_each = var.windows_name
  managed_disk_id    = azurerm_managed_disk.vmwindows[each.key].id
  virtual_machine_id = azurerm_windows_virtual_machine.vmwindows[each.key].id
  lun                = 0
  caching            = "ReadWrite"
#   caching            = var.data_disk_attr["data_disk_caching"]
  depends_on = [azurerm_managed_disk.data_disk1]
}

resource "azurerm_managed_disk" "data_disk2" {
  for_each = var.linux_name
  name                 = "${each.key}-data-disk"
  location             = var.location
  resource_group_name  = var.rg1
  storage_account_type = "Standard_LRS"
  create_option        = "empty"
  disk_size_gb         = "10"
  depends_on = [azurerm_linux_virtual_machine.linux_name]
  tags = var.common_tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach2" {
  for_each = var.linux_name
  // might be defined as variable an called from main module. Siblings cannot refer each other
  // linux name can be defined in linux output and main output then we can use here as variable.
  managed_disk_id    = azurerm_managed_disk.linux_name[each.key].id 
  virtual_machine_id = azurerm_linux_virtual_machine.vmlinux[each.key].id
  lun                = 0
  caching            = "ReadWrite"
  depends_on = [azurerm_managed_disk.data_disk2]
}

# resource "azurerm_managed_disk" "data_disk3" {
#   for_each = var.linux_name2
#   name                 = "${each.key}-data-disk"
#   location             = var.location
#   resource_group_name  = var.rg1
#   storage_account_type = var.data_disk_attr["data_disk_type"]
#   create_option        = var.data_disk_attr["data_disk_create_option"]
#   disk_size_gb         = var.data_disk_attr["10"]
#   depends_on = [azurerm_linux_virtual_machine.vmlinux2]
#   tags = var.common_tags
# }

# resource "azurerm_virtual_machine_data_disk_attachment" "data_disk_attach2" {
#   for_each = var.linux_name2
#   managed_disk_id    = azurerm_managed_disk.vmlinux2[each.key].id
#   virtual_machine_id = azurerm_linux_virtual_machine.vmlinux2[each.key].id
#   lun                = 0
#   caching            = var.data_disk_attr["data_disk_caching"]
#   depends_on = [azurerm_managed_disk.data_disk3]
# }


