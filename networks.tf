resource "yandex_vpc_network" "netology-net" {
  name = "netology-net"
}

resource "yandex_vpc_subnet" "public-a" {
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = "ru-central1-a"
  name           = "public-a"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "public-b" {
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = "ru-central1-b"
  name           = "public-b"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}

resource "yandex_vpc_subnet" "public-c" {
  v4_cidr_blocks = ["192.168.30.0/24"]
  zone           = "ru-central1-c"
  name           = "public-c"
  network_id     = "${yandex_vpc_network.netology-net.id}"
}