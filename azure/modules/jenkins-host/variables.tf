variable "rg_name" {}
variable "location" {}
variable "network" {}
variable "subnet" {}
variable "interface" {}
variable "ip_config" {}
variable "disk" {}
variable "disk_size_gb" {}
variable "vm" {}
variable "vm_size" {}
variable "image_publisher" {
  default = "Canonical"
}
variable "image_offer" {
  default = "UbuntuServer"
}
variable "image_sku" {
  default = "16.04-LTS"
}
variable "image_version" {
  default = "latest"
}
variable "os_disk" {
  default = "jenkins_os_disk"
}
variable "hostname" {}
variable "admin_username" {}
variable "ssh" {}
variable "pub_ip" {}
