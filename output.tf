# Linux outputs
output "vm_hostname_main" {
  value = module.linux.linux_vm_hostname
}
output "private_ips_linux" {
  value = module.linux.linux_private_ip
}
output "public_ips_linux" {
  value = module.linux.linux_public_ip
}
# Windows output
output "vm_hostname_main_windows" {
  value = module.vmwindows.windows_hostname
}
output "private_ips_windows" {
  value = module.vmwindows.windows_private_ip
}
output "public_ips_windows" {
  value = module.vmwindows.windows_public_ip
}
