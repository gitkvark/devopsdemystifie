resource "proxmox_virtual_environment_vm" "this" {
  for_each = local.nodes

  node_name = var.proxmox_node_name

  name        = each.key
  description = each.value.machine_type == "controlplane" ? "Control Plane" : "Worker"
  tags        = each.value.machine_type == "controlplane" ? ["k8s", "controlplane", var.cluster_name] : ["k8s", "worker", var.cluster_name]
  on_boot     = true
  vm_id       = each.value.vm_id

  cpu {
    cores = each.value.cpu_cores
    type  = "x86-64-v2-AES"
  }

  memory {
    dedicated = each.value.ram_dedicated
  }

  agent {
    enabled = true
  }

  network_device {
    bridge = var.proxmox_network_device
  }

  disk {
    datastore_id = var.proxmox_datastore_id
    file_id      = proxmox_virtual_environment_download_file.talos_nocloud_image.id
    file_format  = "raw"
    interface    = "virtio0"
    size         = 20
  }

  operating_system {
    type = "l26" # Linux Kernel 2.6 - 5.X.
  }

  initialization {
    datastore_id = var.proxmox_datastore_id
    ip_config {
      ipv4 {
        address = "${each.value.ip}/16"
        gateway = local.gateway
      }
    }
    dns {
      servers = ["8.8.8.8"]
    }
  }
}
