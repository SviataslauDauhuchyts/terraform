# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "${var.rg_name}"
  location = "${var.location}"
}

# Create a network
resource "azurerm_virtual_network" "network" {
  name                = "${var.network}"
  address_space       = "${var.address_space}"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
}

# Create a subnet inside a network
resource "azurerm_subnet" "subnet" {
  name                 = "${var.subnet}"
  resource_group_name  = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.network.name}"
  address_prefix       = "${var.address_prefix}"
}
