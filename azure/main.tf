# Connect modules here

module "network" {
  source = "modules/network"
  rg_name = "rg1"
  location = "West Europe"
  network = "rg1-net"
  address_space = ["10.0.0.0/16"]
  subnet = "rg1-subnet"
  address_prefix = "10.0.2.0/24"
}

module "jenkins-host" {
  source  = "modules/jenkins-host"
  rg_name = "rg1"
  location = "West Europe"
  network = "rg1-net"
  subnet = "rg1-subnet"
  interface = "jenkins-int"
  ip_config = "jenkins-ip-config"
  pub_ip = "jenkins-pub-ip"
  disk = "jenkins-disk"
  disk_size_gb = 50
  vm = "jenkins-host"
  vm_size = "Standard_DS1_v2"
  hostname = "jenkins-host"
  admin_username = "sviataslau"
  ssh = "${var.ssh}"
}
