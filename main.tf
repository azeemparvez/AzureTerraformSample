resource "azurerm_resource_group" "rg1" {
  name     = "hiperdist-app1"
  location = "West Europe"
}

resource "azurerm_network_security_group" "sg1" {
  name                = "app-sg1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_virtual_network" "hiperdist-vnet1" {
  name                = "vnet1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "frontend"
    address_prefix = "10.0.0.0/24"
    security_group = azurerm_network_security_group.sg1.id
  }

  subnet {
    name           = "GatewaySubnet"
    address_prefix = "10.0.1.0/24"

  }

  tags = {
    environment = "Development"
  }
}
