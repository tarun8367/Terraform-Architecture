resource "null_resource" "name" {
  depends_on = [module.ec2_public]

  # Connection Block for Provisioners to connect to EC2 Instance
  connection {
    type        = "ssh"
    host        = aws_eip.bastion_eip.public_ip
    user        = "ubuntu"
    password    = ""
    private_key = file("private-key/terraform-key.pem")
    timeout     = "30s"
  }

  # File Provisioner: Copies the terraform-key.pem file to /tmp/terraform-key.pem
  provisioner "file" {
    source      = "private-key/terraform-key.pem"
    destination = "/tmp/terraform-key.pem"
  }

  # Remote Exec Provisioner: Using remote-exec provisioner fix the private key permissions on Bastion Host
  provisioner "remote-exec" {
    inline = [
      "sudo chmod 777 /tmp/terraform-key.pem"
    ]
  }


}
