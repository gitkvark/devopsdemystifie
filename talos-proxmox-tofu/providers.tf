terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.74.0"
    }
    talos = {
      source  = "siderolabs/talos"
      version = "0.7.1"
    }
  }
}

provider "proxmox" {
  endpoint  = var.proxmox_endpoint
  api_token = var.proxmox_api_token
  insecure  = var.proxmox_insecure

  ssh {
    agent       = true
    private_key = var.proxmox_ssh_private_key_path
    username    = var.proxmox_ssh_username
  }
}

provider "talos" {
}
