resource "proxmox_virtual_environment_vm" "vm" {
  name            = var.name
  node_name       = var.node_name
  vm_id           = var.vm_id
  tags            = sort(var.tags)
  stop_on_destroy = true

  cpu {
    cores = var.cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.datastore_id
    import_from  = var.image_path
    interface    = "scsi0"
    size         = var.storage
    discard      = "on"
  }

   dynamic "network_device" {
    for_each = var.nics
    content {
      bridge   = network_device.value
      model    = var.nic_model
      firewall = false
    }
  }

  operating_system {
    type = "l26"
  }

  serial_device {}
}