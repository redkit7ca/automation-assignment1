output "windows_hostname" {
  value = values(azurerm_windows_virtual_machine.vmwindows)[*].name
}

output "windows_private_ip" {
  value = values(azurerm_windows_virtual_machine.vmwindows)[*].private_ip_address
}

output "windows_public_ip" {
  value = values(azurerm_windows_virtual_machine.vmwindows)[*].public_ip_address
}

