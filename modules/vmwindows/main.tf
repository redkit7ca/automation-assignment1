resource "azurerm_availability_set" "windows_avs" {
  name                         = var.windows_avs
  location                     = var.location
  resource_group_name          = var.rg_name
  platform_fault_domain_count  = 2
  platform_update_domain_count = 5
  managed                      = true
  # tags                         = local.common_tags
}

resource "azurerm_windows_virtual_machine" "vmwindows" {
  name                  = each.key
  for_each              = var.windows_name
  location              = var.location
  resource_group_name   = var.rg_name
  computer_name         = each.key
  size                  = each.value
  admin_username        = var.username
  admin_password        = var.password
  # tags                  = local.common_tags
  network_interface_ids = [azurerm_network_interface.windows_nic[each.key].id]
  availability_set_id   = azurerm_availability_set.windows_avs.id

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.wos_disk_attributes["wos_disk_caching"]
    storage_account_type = var.wos_disk_attributes["wos_storage_account_type"]
    disk_size_gb         = var.wos_disk_attributes["wos_disk_size"]
  }

  source_image_reference {
    publisher = var.win_publisher
    offer     = var.win_offer
    sku       = var.win_sku
    version   = var.win_version
  }
}
resource "azurerm_network_interface" "windows_nic" {
  for_each            = var.windows_name
  name                = "${each.key}-nic"
  # tags                = local.common_tags
  location            = var.location
  resource_group_name = var.rg_name
  depends_on = [var.rg_name]

  ip_configuration {
    name                          = each.key
    subnet_id                     = var.subnet_id
    public_ip_address_id          = azurerm_public_ip.windows_pip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }

}

resource "azurerm_public_ip" "windows_pip" {
  for_each            = var.windows_name
  tags              =  {environment = "Test"}
  name                = "${each.key}-pip"
  resource_group_name = var.rg_name
  location            = var.location
  allocation_method   = "Dynamic"
}

resource "azurerm_virtual_machine_extension" "windowsextension" {
for_each = var.windows_name
name                 = "IaaSAntimalware"
# location             = var.location
# resource_group_name  = var.rg_name
virtual_machine_id = azurerm_windows_virtual_machine.vmwindows[each.key].id
publisher            = "Microsoft.Azure.Security"
type                 = "IaaSAntimalware"
type_handler_version = "1.5.5.1"
auto_upgrade_minor_version = "true"
depends_on = [azurerm_windows_virtual_machine.vmwindows]

settings = <<SETTINGS
    {
        "AntimalwareEnabled": true,
        "RealtimeProtectionEnabled": "true",
        "ScheduledScanSettings": {
            "isEnabled": "true",
            "day": "1",
            "time": "120",
            "scanType": "Quick"
            },
        "Exclusions": {
            "Extensions": "",
            "Paths": "",
            "Processes": ""
            }
    }
SETTINGS

# tags = local.common_tags 
}
