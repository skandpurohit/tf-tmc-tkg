// Tanzu Mission Control Cluster Type: Tanzu Kubernetes Grid vSphere workload.
// Operations supported : Read, Create, Update & Delete (except nodepools)

// Read Tanzu Mission Control Tanzu Kubernetes Grid vSphere workload cluster : fetch cluster details for already present TKG vSphere cluster
data "tanzu-mission-control_cluster" "ready_only_cluster_view" {
  management_cluster_name = "sp-tkg-mgmt" // Required
  provisioner_name        = "workload-clusters"          // Required
  name                    = "workload-cls-1"       // Required
}

// Create Tanzu Mission Control Tanzu Kubernetes Grid vSphere workload cluster entry
# resource "tanzu-mission-control_cluster" "create_tkg_vsphere_cluster" {
#   management_cluster_name = "sp-tkg-mgmt" // Default: attached
#   provisioner_name        = "workload-clusters"          // Default: attached
#   name                    = "workload-cls-3"       // Required

#   meta {
#     description = "description of the cluster"
#     labels      = { "automation" : "terraform" }
#   }

#   spec {
#     cluster_group = "sp-cluster-grp" // Default: default
#     tkg_vsphere {
#       advanced_configs {
#         key   = "test"
#         value = "test"
#       }
#       settings {
#         network {
#           pods {
#             cidr_blocks = [
#               "172.20.0.0/16", // Required
#             ]
#           }

#           services {
#             cidr_blocks = [
#               "10.96.0.0/16", // Required
#             ]
#           }

#           api_server_port         = 6443
#           control_plane_end_point = "" // Optional
#         }

#         security {
#           ssh_key = "default" // Required
#         }
#       }

#       distribution {
#         os_arch    = ""
#         os_name    = ""
#         os_version = ""
#         version    = "v1.23.8+vmware.3-tkg.1.ubuntu" // Required

#         workspace {
#           datacenter        = "/vc01"        // Required
#           datastore         = "/vc01/datastore/vsanDatastore"         // Required
#           workspace_network = "/vc01/vc01-dvs/user-workload" // Required
#           folder            = "/vc01/Namespaces"            // Required
#           resource_pool     = "/vc01/vc01cl01/Namespaces"     // Required
#         }
#       }

#       topology {
#         control_plane {
#           vm_config {
#             cpu       = "8"       // Required
#             disk_size = "100" // Required
#             memory    = "65760"    // Required
#           }

#           high_availability = false // Default: false
#         }

#         node_pools {
#           spec {
#             worker_node_count = "2" // Required

#             tkg_vsphere {
#               vm_config {
#                 cpu       = "8"       // Required
#                 disk_size = "100" // Required
#                 memory    = "65760"    // Required
#               }
#             }
#           }

#           info {
#             name        = "sp-node-pool" // Required
#             description = "default node pool for the cluster"
#           }
#         }
#       }
#     }
#   }
# }