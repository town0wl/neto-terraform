resource "yandex_iam_service_account" "sa-k8s-image-puller" {
  name        = "k8s-image-puller"
  description = "Account for Kubernetes to pull images from local Registry"
}

resource "yandex_resourcemanager_folder_iam_member" "grant-registry-pull" {
  folder_id   = var.yc_folder_id
  role      = "container-registry.images.puller"
  member    = "serviceAccount:${yandex_iam_service_account.sa-k8s-image-puller.id}"
}

resource "yandex_iam_service_account_key" "k8s-image-puller-key" {
  service_account_id = "${yandex_iam_service_account.sa-k8s-image-puller.id}"
  description        = "Key for Kubernetes to pull images from local Registry"
  key_algorithm      = "RSA_4096"
}

output "k8s-image-puller-key-id" {
  description = "Id for k8s-image-puller-key"
  value = yandex_iam_service_account_key.k8s-image-puller-key.id
}
output "k8s-image-puller-id" {
  description = "Service account id for k8s-image-puller"
  value = yandex_iam_service_account.sa-k8s-image-puller.id
}
output "k8s-image-puller-key-createdat" {
  description = "Created at for k8s-image-puller-key"
  value = yandex_iam_service_account_key.k8s-image-puller-key.created_at
}
output "k8s-image-puller-key-algorithm" {
  description = "Key algorithm for k8s-image-puller-key"
  value = yandex_iam_service_account_key.k8s-image-puller-key.key_algorithm
}
output "k8s-image-puller-key-public" {
  description = "Public key for k8s-image-puller-key"
  value = yandex_iam_service_account_key.k8s-image-puller-key.public_key
}
output "k8s-image-puller-key-private" {
  description = "Private key for k8s-image-puller-key"
  value = yandex_iam_service_account_key.k8s-image-puller-key.private_key
}