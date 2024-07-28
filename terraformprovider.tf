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


data "hitachi_vss_block_volume" "vssbvolumes" {
  vss_block_address = "10.77.33.79"
  volume_name       = "SDS_Test1"
}

output "volumeoutput" {
  value = data.hitachi_vss_block_volume.vssbvolumes
}