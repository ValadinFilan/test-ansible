packer {
  required_plugins {
    yandex = {
      version = "~> 1"
      source  = "github.com/hashicorp/yandex"
    }

    ansible = {
      version = ">= 1.1.0"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "yandex" "ubuntu-nginx" {
  folder_id           = "b1g2pa80mvmie7jv856e"
  source_image_family = "ubuntu-2204-lts"
  ssh_username        = "ubuntu"
  use_ipv4_nat        = "true"
  image_description   = "my custom ubuntu with nginx"
  image_family        = "ubuntu-2204-lts"
  image_name          = "my-ubuntu-nginx"
  subnet_id           = "e9b55qcp3krocvlj0cnf"
  disk_type           = "network-ssd"
  zone                = "ru-central1-a"
}

build {
  sources = ["source.yandex.ubuntu-nginx"]

  provisioner "shell" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y python3 python3-pip",
      "sudo apt-get install -y ansible"
    ]
  }

  provisioner "ansible" {
    playbook_file = "./site.yaml"
    sftp_command = "/usr/lib/openssh/sftp-server -e"
  }
}