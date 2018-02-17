# Connect modules here

module "jenkins" {
  source  = "modules/jenkins"
  rg_name = "rg1"
  location = "West Europe"
  network = "rg1-net"
  address_space = ["10.0.0.0/16"]
  subnet = "rg1-subnet"
  address_prefix = "10.0.2.0/24"
  interface = "rg1-int"
  ip_config = "rg1-ip-config"
  pub_ip = "rg1-pub-ip"
  disk = "rg1-disk"
  disk_size_gb = 50
  vm = "rg1-vm"
  vm_size = "Standard_DS1_v2"
  hostname = "jenkins-host"
  admin_username = "sviataslau"
  ssh = "${var.ssh}"
}
