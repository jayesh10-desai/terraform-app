resource "azurerm_resource_group" "first-rg" {
  name     = "${var.resource-group-name}"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "test-vnet" {
  name = "${var.vnet-name}"
  location = "${azurerm_resource_group.first-rg.location}"
  resource_group_name = "${azurerm_resource_group.first-rg.name}"
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet-001" {
  name  =   "first-subnet"
  address_prefixes = ["10.0.0.0/24"]
  resource_group_name = "${azurerm_resource_group.first-rg.name}"
  virtual_network_name = "${azurerm_virtual_network.test-vnet.name}"
}

output "resource-group" {
  value = azurerm_resource_group.first-rg.name
}

output "location" {
  value = azurerm_resource_group.first-rg.location
}

output "subnets" {
  value = azurerm_subnet.subnet-001
}