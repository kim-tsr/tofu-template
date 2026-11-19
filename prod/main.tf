locals {
  links = ["vmbr11","vmbr12","vmbr21","vmbr22","vmbr30","vmbr31","vmbr32",]

  mgmt = "vmbr1"

  sonic  = "local:import/sonic-vs-202511.qcow2"
  debian = "local:import/debian-13-nocloud-amd64.qcow2"
  vios = "local:import/vios-adventerprisek9-m.spa.159-3.m9.qcow2"

  nodes = {
    "router-isp"  = { vm_id = 1000, links = ["vmbr11", "vmbr12"], role = "routeur", image = local.sonic }
    "gw-1"        = { vm_id = 1011, links = ["vmbr11", "vmbr21"], role = "routeur", image = local.vios }
    "gw-2"        = { vm_id = 1012, links = ["vmbr12", "vmbr22"], role = "routeur", image = local.vios }
    "access-1"    = { vm_id = 1021, links = ["vmbr21", "vmbr30", "vmbr31"], role = "switch", image = local.sonic }
    "access-2"    = { vm_id = 1022, links = ["vmbr22", "vmbr30", "vmbr32"], role = "switch", image = local.sonic }
    "client-1"    = { vm_id = 1031, links = ["vmbr31"], role = "computer", image = local.debian }
    "client-2"    = { vm_id = 1032, links = ["vmbr32"], role = "computer", image = local.debian }
  }
}

module "node" {
  source         = "../module/vm"

  depends_on = [proxmox_virtual_environment_network_linux_bridge.link]

  for_each       = local.nodes
  name           = each.key
  tags           = ["topologie_1", each.value.role]
  vm_id          = each.value.vm_id
  image_path     = each.value.image
  datastore_id   = "vmdata"

  nics = concat([local.mgmt], each.value.links)
}