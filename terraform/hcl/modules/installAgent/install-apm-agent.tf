variable "ip-address" {}

variable "user-id" {}

variable "ssh-key" {}

variable "APM_PATH" {
	default = "/opt/ibm/apm/agentIAPM/lx8266/nj/bin/plugin"
}

resource "null_resource" "install-apm-agent" {
  
  connection {
    host     = "${var.ip-address}"
    user     = "${var.user-id}"
	private_key = "${var.ssh-key}"
  }

  provisioner "file" {
    source      = "${path.module}/files/IAPM_Interconnect_silent_install.txt"
    #source      = "./files/IAPM_Interconnect_silent_install.txt"
    destination = "IAPM_Interconnect_silent_install.txt"
  }
 
  provisioner "file" {
    source      = "${path.module}/files/Interconnect_IAPM_installation.sh"
    #source      = "./files/Interconnect_IAPM_installation.sh"
    destination = "Interconnect_IAPM_installation.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo sh -c \"echo ${var.APM_PATH}\" > apm_path.cfg",
      "sudo sh -c 'chmod +x Interconnect_IAPM_installation.sh'"
    ]
  }
}