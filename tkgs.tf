# Create Tanzu Mission Control Tanzu Kubernetes Grid Service workload cluster entry
resource "tanzu-mission-control_cluster" "create_tkgs_workload" {
  management_cluster_name = "sp-tkg-mgmt" // Default: attached
  provisioner_name        = "workload-clusters"          // Default: attached
  name                    = "workload-cls-3"       // Required

  meta {
    labels = { "key" : "test" }
  }

  spec {
    cluster_group = "default"
    tkg_service_vsphere {
      settings {
        network {
          pods {
            cidr_blocks = [
              "172.20.0.0/16", # pods cidr block by default has the value `172.20.0.0/16`
            ]
          }
          services {
            cidr_blocks = [
              "10.96.0.0/16", # services cidr block by default has the value `10.96.0.0/16`
            ]
          }
        }
        storage {
          classes = [
            "vc01cl01-t0compute",
          ]
          default_class = "vc01cl01-t0compute"
        }
      }

      distribution {
        version = "v1.23.8+vmware.3-tkg.1.ubuntu"
      }

      topology {
        control_plane {
          class         = "best-effort-medium"
          storage_class = "vc01cl01-t0compute"
          # storage class is either `wcpglobal-storage-profile` or `gc-storage-profile`
          high_availability = false
        #   volumes {
        #     capacity          = 4
        #     mount_path        = "/var/lib/etcd"
        #     name              = "etcd-0"
        #     pvc_storage_class = "best-effort-2xlarge"
        #   }
        }
        node_pools {
          spec {
            worker_node_count = "2"
            cloud_label = {
              "key1" : "val1"
            }
            node_label = {
              "key2" : "val2"
            }

            tkg_service_vsphere {
              class          = "best-effort-medium"
              storage_class  = "vc01cl01-t0compute"
              failure_domain = ""
              # storage class is either `wcpglobal-storage-profile` or `gc-storage-profile`
            #   volumes {
            #     capacity          = 4
            #     mount_path        = "/var/lib/etcd"
            #     name              = "etcd-0"
            #     pvc_storage_class = "best-effort-2xlarge"
            #   }
            }
          }
          info {
            name        = "default-nodepool" # default node pool name `default-nodepool`
            description = "tkgs workload nodepool"
          }
        }
      }
    }
  }
}