resource "null_resource" "linux_provisioner" {
  for_each = var.linux_name
  depends_on = [
    azurerm_linux_virtual_machine.linux_vm,
    azurerm_network_interface.linux_nic,
  ]

  provisioner "local-exec" {
    command = "sleep 5 ; hostname"
  }
}
