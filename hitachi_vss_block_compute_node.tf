resource "hitachi_vss_block_compute_node" "mycompute" {
  vss_block_address = "10.77.33.79"
  compute_node_name = "ComputeNode-RESTAPI123"
  os_type = "Linux"

}


curl -u admin:Hitachi2! -k -X POST -H "Content-Type: application/json" -H "Expect:" -d '{ "targetChapUserName": "refadmin", "targetChapSecret": "123456789012"}' https://10.77.33.79/ConfigurationManager/simple/v1/objects/chap-users

curl -k -u admin:Hitachi2! -X GET https://10.77.33.79/ConfigurationManager/simple/v1/objects/chap-users

data.json
{
  "targetChapUserName": "refadmin",
  "targetChapSecret": "123456789012"
}

