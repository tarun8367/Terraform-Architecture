packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2.8"
    }

    ansible = {
      version = "~> 1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}


source "amazon-ebs" "ubuntu_20" {
  ami_name      = "${var.ami_prefix}-ubuntu-20-${local.timestamp}"
  instance_type = var.instance_type
  region        = var.region
  ami_regions   = var.ami_regions
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = var.ssh_username
  tags         = var.tags
}

build {
  sources = [
    "source.amazon-ebs.ubuntu_20"
  ]
  /*provisioner "file" {
    source      = "assets"
    destination = "/tmp/"
  }*/
  provisioner "ansible" {
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_NOCOWS=1"]
    extra_arguments  = ["--extra-vars", "desktop=false", "-vv"]
    playbook_file    = "${path.root}/ansible/playbook.yml"
    user             = var.ssh_username
  }

}
