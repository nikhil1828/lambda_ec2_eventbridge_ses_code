//INSTANCE LAUNCHING//

resource "aws_instance" "web" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = var.key_name
  security_groups = var.sg
  tags = {
    Layer = "three"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
    host = self.public_ip
    private_key = file("/home/admin1/Downloads/mumbai_iron.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sleep 30",
      "sudo init 0"
    ]
  }
}
