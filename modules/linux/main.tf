resource "azurerm_availability_set" "avset" {
  name                = var.linux_avset
  location            = var.location
  resource_group_name = var.rg1
  # depends_on          = [azurerm_resource_group.rg1]
}

resource "azurerm_network_interface" "linux_nic" {
  for_each            = var.linux_name
  name                = "${each.key}-nic"
  location            = var.location
  resource_group_name = var.rg1

  # depends_on = [azurerm_resource_group.rg1, azurerm_virtual_network.vnet1]

  ip_configuration {
    # name                          = each.key // previous version
    name                          = "${each.key}-nic-ip"
    subnet_id                     = var.subnet_id // it was subnet1_name
    public_ip_address_id          = azurerm_public_ip.linux_pub_ip[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
# load balancer use "public ip" resource in main module.
resource "azurerm_public_ip" "linux_pub_ip" {
  for_each            = var.linux_name
  name                = "${each.key}-linux_pip"
  # name                = "${each.key}-win_pip"
  resource_group_name = var.rg1
  location            = var.location
  allocation_method   = "Dynamic"
  depends_on          = [var.rg1]
  tags = {
    environment = "Test"
  }
}

resource "azurerm_linux_virtual_machine" "linux_vm" {
  name                  = each.key
  for_each              = var.linux_name
  network_interface_ids = [azurerm_network_interface.linux_nic[each.key].id]
  computer_name         = each.key

  depends_on          = [azurerm_availability_set.avset]
  resource_group_name = var.rg1
  location            = var.location
  size                = "Standard_B1s"
  admin_username      = "auto"
  admin_ssh_key {
    username   = var.linux_username
    public_key = file("/home/auto/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "${each.key}-os-disk"
    caching              = var.linux_os_disk["los_disk_caching"]
    storage_account_type = var.linux_os_disk["los_storage_account_type"]
    disk_size_gb         = var.linux_os_disk["los_disk_size"]
  }
  source_image_reference {
    publisher = var.linux_publisher
    offer     = var.linux_offer
    sku       = var.linux_sku
    version   = var.linux_version
  }
}