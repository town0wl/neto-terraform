variable "yc_cloud_id" {
  type = string
  description = "Yandex Cloud ID"
}

variable "yc_folder_id" {
  type = string
  description = "Yandex Cloud folder ID"
}

variable "base_creds_file" {
  type = string
  description = "Path to file with credentials for terraform yandex provider"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
  
  backend "s3" {
    # partial configuration: so that bucket, key, access_key, secret_key - needed additionally
    endpoint   = "storage.yandexcloud.net"
    region     = "ru-central1"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  service_account_key_file = file(var.base_creds_file)
  cloud_id  = var.yc_cloud_id
  folder_id = var.yc_folder_id
  zone      = "ru-central1-a"
}

