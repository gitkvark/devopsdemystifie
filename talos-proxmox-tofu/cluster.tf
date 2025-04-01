resource "talos_machine_secrets" "this" {
  talos_version = var.talos_version
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  nodes                = [for k, v in local.nodes : v.ip]
  endpoints            = [for k, v in local.nodes : v.ip if v.machine_type == "controlplane"]
}

data "talos_machine_configuration" "this" {
  for_each = local.nodes

  cluster_name       = var.cluster_name
  cluster_endpoint   = "https://${local.endpoint}:6443"
  machine_type       = each.value.machine_type
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  talos_version      = var.talos_version
  kubernetes_version = var.kubernetes_version
}

resource "talos_machine_configuration_apply" "this" {
  depends_on = [proxmox_virtual_environment_vm.this]

  for_each = local.nodes

  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.this[each.key].machine_configuration
  node                        = each.value.ip
}

resource "talos_machine_bootstrap" "this" {
  depends_on           = [talos_machine_configuration_apply.this]
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoint             = local.endpoint
  node                 = [for k, v in local.nodes : v.ip if v.machine_type == "controlplane"][0]
}

data "talos_cluster_health" "this" {
  depends_on = [
    talos_machine_configuration_apply.this,
    talos_machine_bootstrap.this
  ]
  client_configuration = data.talos_client_configuration.this.client_configuration
  control_plane_nodes  = [for k, v in local.nodes : v.ip if v.machine_type == "controlplane"]
  worker_nodes         = [for k, v in local.nodes : v.ip if v.machine_type == "worker"]
  endpoints            = data.talos_client_configuration.this.endpoints
  timeouts = {
    read = "10m"
  }
}

resource "talos_cluster_kubeconfig" "this" {
  depends_on = [
    talos_machine_bootstrap.this,
    data.talos_cluster_health.this
  ]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = [for k, v in local.nodes : v.ip if v.machine_type == "controlplane"][0]
}

output "talosconfig" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = resource.talos_cluster_kubeconfig.this.kubeconfig_raw
  sensitive = true
}
