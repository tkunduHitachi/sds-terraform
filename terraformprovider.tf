terraform {
  required_providers {
    hitachi = {
      source = "hitachi-vantara/hitachi"
      version = "2.0.6"
    }
  }
}

provider "hitachi" {
  # Configuration options
  hitachi_vss_block_provider {
    vss_block_address = "10.77.33.79"
    username          = "admin"
    password          = "Hitachi2!"
  }
}

# Display: Compute port information.
data "hitachi_vss_block_iscsi_port_auth" "mycomputeport" {
  vss_block_address = "10.77.33.79"
  name = "001-iSCSI-001"
}

output "mycomputeport" {
  value = data.hitachi_vss_block_iscsi_port_auth.mycomputeport
}

# Display: Storage pool
data "hitachi_vss_block_storage_pools" "pool" {
  vssb_address = "10.77.33.79"
  storage_pool_names = ["StoragePool01"]
}

output "pool" {
  value = data.hitachi_vss_block_storage_pools.pool
}
#--------------------------------------------------------------------------
# Dashboard information
data "hitachi_vss_block_dashboard" "dashboard" {
  vss_block_address = "10.10.12.13"
  dashboard_info{
    health_status=[
      compute_node_count
    ]
  }
}

output "dashboardoutput" {
  value = data.hitachi_vss_block_dashboard.dashboard
}


# dash board information: compute node count, drive count, storage node count.

# Dashboard information
data "hitachi_vss_block_dashboard" "dashboard" {
  vss_block_address = "10.77.33.79"
}

output "dashboardoutput_compute_node_count" {
  value = {
        compute_node_count = data.hitachi_vss_block_dashboard.dashboard.dashboard_info[0].compute_node_count
        drive_count = data.hitachi_vss_block_dashboard.dashboard.dashboard_info[0].drive_count
        storage_node_count = data.hitachi_vss_block_dashboard.dashboard.dashboard_info[0].storage_node_count
        }
}



#------------------------------------------------------

# Create : Volume
resource "hitachi_vss_block_volume" "volumecreate" {
  vss_block_address = "10.77.33.79"
  name              = "10.77.33.87_vol"
  capacity_gb       = 1024
  storage_pool      = "StoragePool01"
  compute_nodes     = [
    "10.77.33.87"
    ]
  nick_name         = "10.77.33.87"
}

output "volumecreateData" {
  value = resource.hitachi_vss_block_volume.volumecreate
}

# Display of compute node
data "hitachi_vss_block_compute_nodes" "computenodes" {
  vss_block_address = "10.77.33.79"
  compute_node_name = "10.77.33.87"
}

output "nodeoutput" {
  value = data.hitachi_vss_block_compute_nodes.computenodes
}
#--------------------------------------------------

# Create: compute Node.
resource "hitachi_vss_block_compute_node" "mycompute" {
  vss_block_address = "10.77.33.79"
  compute_node_name = "10.77.33.87"
  os_type = "Linux"  

  iscsi_connection{
    iscsi_initiator = "iqn.1994-05.com.redhat:fd69608b5eee"
    port_names = [
      "001-iSCSI-001",
      "000-iSCSI-000",
      "002-iSCSI-002"
      ]
  } 
}

output "computenodecreate" {
  value = resource.hitachi_vss_block_compute_node.mycompute
}
#---------------------------------------------------------------------





data "hitachi_vss_block_volume" "vssbvolumes" {
  vss_block_address = "10.77.33.79"
  volume_name       = "SDS_Test1"
}

output "volumeoutput" {
  value = data.hitachi_vss_block_volume.vssbvolumes
}