resource "azurerm_resource_group" "app-grp" {
  name     = var.resource-group
  location = var.location
}

resource "azurerm_virtual_network" "app-vnet" {
  for_each            = var.vnets
  name                = each.value.name
  address_space       = each.value.address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.app-grp.name
}

resource "azurerm_subnet" "app-subnet" {
  for_each             = var.subnets
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.app-grp.name
  virtual_network_name = azurerm_virtual_network.app-vnet
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_interface" "app-nic" {
  for_each            = var.nic
  name                = each.value.name
  location            = var.location
  resource_group_name = azurerm_resource_group.app-grp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app-subnet[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "app-vm" {
  for_each            = var.vm-name
  name                = each.value.name
  resource_group_name = azurerm_resource_group.app-grp.name
  location            = var.location
  size                = each.value.size
  admin_username      = "admin20"
  network_interface_ids = [
    azurerm_network_interface.app-nic[each.value.nic_key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}