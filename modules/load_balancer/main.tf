resource "azurerm_lb" "assignment1lb" {
  name = "assignment1-lb"
  location = var.location
  resource_group_name = var.rg1
  frontend_ip_configuration {
      name = "PublicIPAddress"
      public_ip_address_id = var.public_ip_address_id
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = var.rg1
  loadbalancer_id     = azurerm_lb.assignment1lb.id
  name                = "BackEndAddressPool"
}

resource "azurerm_network_interface_backend_address_pool_association" "lb_pool_association" {
  network_interface_id    = azurerm_network_interface.example.id // network_interface_id name needed. unfinished
  ip_configuration_name   = "testconfiguration1"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bpepool.id
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = var.rg1
  loadbalancer_id                = azurerm_lb.assignment1lb.id
  name                           = "LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 3389
  backend_port                   = 3389
  frontend_ip_configuration_name = "PublicIPAddress" // PublicIPAddress name needed. unfinished.
}

resource "azurerm_lb_probe" "lb_prob" {
  resource_group_name = var.rg1
  loadbalancer_id     = azurerm_lb.assignment1lb.id
  name                = "ssh-running-probe"
  port                = 22
}