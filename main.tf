resource "azurerm_resource_group" "test_grp" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "app_vnet" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = azurerm_resource_group.test_grp.name
}

resource "azurerm_subnet" "app_subnet" {
  for_each = var.subnets_details
  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.test_grp.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = each.value.address_prefixes
}

resource "azurerm_network_interface" "nics" {
  for_each = var.win_vms
  name                = "${each.value.name}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.test_grp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_subnet[each.value.subnet_key].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "win_vm" {
  for_each = var.win_vms
  name                = each.value.name
  resource_group_name = azurerm_resource_group.test_grp.name
  location            = var.location
  size                = each.value.size
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.nics[each.key].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
