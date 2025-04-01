# Variables pour le provider proxmox

variable "proxmox_endpoint" {
  description = "Proxmox API endpoint"
  type        = string
}

variable "proxmox_ssh_username" {
  description = "Utilisateur SSH pour le serveur Proxmox"
  type        = string
}

variable "proxmox_ssh_private_key_path" {
  description = "Emplacement de la clé SSH privée de l'utilisateur SSH"
  type        = string
}

variable "proxmox_insecure" {
  description = "Nécessaire si on utilise un certificat SSL auto-signé"
  type        = bool
}

variable "proxmox_api_token" {
  description = "Jeton API pour le serveur Proxmox"
  type        = string
}

variable "proxmox_datastore_id" {
  description = "Nom du répertoire sur le serveur Proxmox"
  type        = string
}

variable "proxmox_node_name" {
  description = "Nom du node Proxmox"
  type        = string
}

variable "proxmox_network_device" {
  description = "Nom de la carte de réseau virtuelle utilisée par les VMs du cluster"
  type        = string
}

# Variables pour Talos et Kubernetes

variable "cluster_name" {
  description = "Le nom du cluster"
  type        = string
}

variable "talos_version" {
  description = "La version de Talos choisie"
  type        = string
}

variable "kubernetes_version" {
  description = "La version du Kubernetes choisie"
  type        = string
}
