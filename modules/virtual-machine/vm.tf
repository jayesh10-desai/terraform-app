resource "azurerm_network_interface" "test-nic" {
  name                = "${var.vm-config.name}-nic"
  location            = var.location
  resource_group_name = var.resource-group

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet-id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.example.id
  }
}

resource "azurerm_linux_virtual_machine" "test-vm" {
  name                = "${var.vm-config.name}"
  resource_group_name = "${var.resource-group}"
  location            = "${var.location}"
  size                = "${var.vm-config.size}"
  admin_username      = "${var.vm-config.username}"
  network_interface_ids = [
    azurerm_network_interface.test-nic.id,
  ]

  admin_ssh_key {
    username   = "${var.vm-config.username}"
    public_key = tls_private_key.example.public_key_openssh
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
}

resource "tls_private_key" "example" {
  algorithm   = "RSA"
  ecdsa_curve = "P384"
}
