resource "yandex_container_registry" "default" {
  name      = "demo-registry"
}

output "registry-id" {
  description = "ID for personal docker registry"
  value = yandex_container_registry.default.id
}