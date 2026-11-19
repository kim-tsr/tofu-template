resource "proxmox_virtual_environment_network_linux_bridge" "link" {
  for_each  = toset(local.links)
  node_name = var.node_name
  name      = each.key
}