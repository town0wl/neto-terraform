variable "ssh_pubkey_file" {
  type = string
  description = "Path to file with SSH public key"
}

resource "yandex_compute_instance" "test-instance-a" {
  name        = "node-a"
  platform_id = "standard-v1"
  zone        = "ru-central1-a"
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
#  scheduling_policy {
#    preemptible = true
#  }
  boot_disk {
    initialize_params {
      image_id = "fd8haecqq3rn9ch89eua"     # ubuntu 22.04 lts
      size = 50
      type = "network-ssd"
    }
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.public-a.id}"
    ip_address = "192.168.10.11"
    nat = true
    ipv6 = false
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_pubkey_file)}"
  }
}


resource "yandex_compute_instance" "test-instance-b" {
  name        = "node-b"
  platform_id = "standard-v1"
  zone        = "ru-central1-b"
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
#  scheduling_policy {
#    preemptible = true
#  }
  boot_disk {
    initialize_params {
      image_id = "fd8haecqq3rn9ch89eua"     # ubuntu 22.04 lts
      size = 50
      type = "network-ssd"
    }
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.public-b.id}"
    ip_address = "192.168.20.11"
    nat = true
    ipv6 = false
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_pubkey_file)}"
  }
}


resource "yandex_compute_instance" "test-master-c" {
  name        = "master-c"
  platform_id = "standard-v1"
  zone        = "ru-central1-c"
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
#  scheduling_policy {
#    preemptible = true
#  }
  boot_disk {
    initialize_params {
      image_id = "fd8haecqq3rn9ch89eua"     # ubuntu 22.04 lts
      size = 50
      type = "network-ssd"
    }
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.public-c.id}"
    ip_address = "192.168.30.7"
    nat = true
    ipv6 = false
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_pubkey_file)}"
  }
}


resource "yandex_compute_instance" "service-host" {
  name        = "service-c"
  platform_id = "standard-v1"
  zone        = "ru-central1-c"
  resources {
    cores  = 2
    memory = 4
    core_fraction = 100
  }
  boot_disk {
    initialize_params {
      image_id = "fd8haecqq3rn9ch89eua"     # ubuntu 22.04 lts
      size = 25
      type = "network-ssd"
    }
  }
  network_interface {
    subnet_id = "${yandex_vpc_subnet.public-c.id}"
    ip_address = "192.168.30.100"
    nat = true
    ipv6 = false
  }
  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_pubkey_file)}"
  }
}


output "test-instance-a-internal-ip" {
  description = "Internal IP address of node-a"
  value = yandex_compute_instance.test-instance-a.network_interface.0.ip_address
}
output "test-instance-a-external-ip" {
  description = "Internal IP address of node-a"
  value = yandex_compute_instance.test-instance-a.network_interface.0.nat_ip_address
}

output "test-instance-b-internal-ip" {
  description = "Internal IP address of node-b"
  value = yandex_compute_instance.test-instance-b.network_interface.0.ip_address
}
output "test-instance-b-external-ip" {
  description = "Internal IP address of node-b"
  value = yandex_compute_instance.test-instance-b.network_interface.0.nat_ip_address
}

output "test-master-c-internal-ip" {
  description = "Internal IP address of master-c"
  value = yandex_compute_instance.test-master-c.network_interface.0.ip_address
}
output "test-master-c-external-ip" {
  description = "Internal IP address of master-c"
  value = yandex_compute_instance.test-master-c.network_interface.0.nat_ip_address
}

output "service-host-internal-ip" {
  description = "Internal IP address of service-host"
  value = yandex_compute_instance.service-host.network_interface.0.ip_address
}
output "service-host-external-ip" {
  description = "Internal IP address of service-host"
  value = yandex_compute_instance.service-host.network_interface.0.nat_ip_address
}