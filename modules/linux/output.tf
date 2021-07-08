output "linux_vm_hostname" {
  # value = [azurerm_linux_virtual_machine.linux_vm[*].name]
  value = [values(azurerm_linux_virtual_machine.linux_vm)[*].name]
}
output "linux_private_ip" {
  # value = [azurerm_network_interface.linux_nic[*].private_ip_address]
  value = [values(azurerm_network_interface.linux_nic)[*].private_ip_address]
}

output "linux_public_ip" {
  # value = [azurerm_public_ip.linux_pub_ip[*].ip_address]
  value = [values(azurerm_public_ip.linux_pub_ip)[*].ip_address]
}
