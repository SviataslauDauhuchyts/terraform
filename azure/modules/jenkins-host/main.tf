# Create a public IP
resource "azurerm_public_ip" "pub_ip" {
  name                         = "${var.pub_ip}"
  location                     = "${var.location}"
  resource_group_name          = "${var.rg_name}"
  public_ip_address_allocation = "static"
}

data "azurerm_subnet" "available" {
  name = "${var.subnet}"
  resource_group_name = "${var.rg_name}"
  virtual_network_name = "${var.network}"
}

# Create an interface for a VM
resource "azurerm_network_interface" "interface" {
  name                = "${var.interface}"
  location            = "${var.location}"
  resource_group_name = "${var.rg_name}"

  ip_configuration {
    name                          = "${var.ip_config}"
    subnet_id                     = "${data.azurerm_subnet.available.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.pub_ip.id}"
  }
}

# Create a disk for a VM
resource "azurerm_managed_disk" "disk" {
  name                 = "${var.disk}"
  location             = "${var.location}"
  resource_group_name  = "${var.rg_name}"
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "${var.disk_size_gb}"
}

# Create a VM
resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.vm}"
  location              = "${var.location}"
  resource_group_name   = "${var.rg_name}"
  network_interface_ids = ["${azurerm_network_interface.interface.id}"]
  vm_size               = "${var.vm_size}"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "${var.image_publisher}"
    offer     = "${var.image_offer}"
    sku       = "${var.image_sku}"
    version   = "${var.image_version}"
  }

  storage_os_disk {
    name              = "${var.os_disk}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  # Optional data disks
  storage_data_disk {
    name            = "${azurerm_managed_disk.disk.name}"
    managed_disk_id = "${azurerm_managed_disk.disk.id}"
    create_option   = "Attach"
    lun             = 0
    disk_size_gb    = "${azurerm_managed_disk.disk.disk_size_gb}"
  }

  os_profile {
    computer_name  = "${var.hostname}"
    admin_username = "${var.admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      path = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${var.ssh}"
    }
  }
}
