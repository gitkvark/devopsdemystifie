locals {
  endpoint = "10.0.1.100"
  gateway  = "10.0.0.1"
  nodes = {
    "ctrl-00" = {
      machine_type  = "controlplane"
      vm_id         = 1100
      ip            = "10.0.1.100"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "ctrl-01" = {
      machine_type  = "controlplane"
      vm_id         = 1101
      ip            = "10.0.1.101"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "ctrl-02" = {
      machine_type  = "controlplane"
      vm_id         = 1102
      ip            = "10.0.1.102"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "work-00" = {
      machine_type  = "worker"
      vm_id         = 1200
      ip            = "10.0.1.200"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "work-01" = {
      machine_type  = "worker"
      vm_id         = 1201
      ip            = "10.0.1.201"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "work-02" = {
      machine_type  = "worker"
      vm_id         = 1202
      ip            = "10.0.1.202"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "work-03" = {
      machine_type  = "worker"
      vm_id         = 1203
      ip            = "10.0.1.203"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
    "work-04" = {
      machine_type  = "worker"
      vm_id         = 1204
      ip            = "10.0.1.204"
      cpu_cores     = 2
      ram_dedicated = 3072
    }
  }
}
