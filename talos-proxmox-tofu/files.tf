resource "proxmox_virtual_environment_download_file" "talos_nocloud_image" {
  content_type = "iso"
  datastore_id = var.proxmox_datastore_id
  node_name    = var.proxmox_node_name

  file_name               = "talos-${local.talos_version}-nocloud-amd64.img"
  url                     = "https://factory.talos.dev/image/ce4c980550dd2ab1b17bbf2b08801c7eb59418eafe8f279833297925d67c7515/${local.talos_version}/nocloud-amd64.raw.gz"
  decompression_algorithm = "gz"
  overwrite               = false
}
