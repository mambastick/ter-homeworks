### Cloud / provider vars

variable "cloud_id" {
  type        = string
  description = "Yandex Cloud ID (yc resource-manager cloud list)"
}

variable "folder_id" {
  type        = string
  description = "Yandex Folder ID (yc resource-manager folder list)"
}

# В ДЗ используется именно 'zone', а не 'default_zone'
variable "zone" {
  type        = string
  description = "Deployment zone (e.g. ru-central1-a)"
}

# Путь к JSON-ключу сервисного аккаунта для провайдера
variable "service_account_key_file" {
  type        = string
  description = "Path to service account key JSON (e.g. key.json)"
}

### Network defaults

variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "Subnet CIDR(s)"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

### SSH key for default user (ubuntu)

variable "vms_ssh_public_root_key" {
  type        = string
  description = "Public SSH key string in YC metadata format, e.g. 'ubuntu:ssh-ed25519 AAAA... comment'"
}


### Task 2
/*
# -------- VM (web) image --------
variable "vm_web_image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image family for web VM"
}

variable "vm_web_image_folder_id" {
  type        = string
  default     = "standard-images"
  description = "Folder ID where public images live"
}

# -------- VM (web) instance props --------
variable "vm_web_name" {
  type        = string
  default     = "netology-develop-platform-web"
  description = "Instance name"
}

variable "vm_web_platform_id" {
  type        = string
  default     = "standard-v3"
  description = "Platform ID (e.g. standard-v1|v2|v3). null to omit"
}

variable "vm_web_cores" {
  type        = number
  default     = 2
  description = "vCPU count"
}

variable "vm_web_memory" {
  type        = number
  default     = 1
  description = "RAM in GB"
}

variable "vm_web_core_fraction" {
  type        = number
  default     = 20
  description = "Burstable CPU share: 5|20|50|100"
}

variable "vm_web_preemptible" {
  type        = bool
  default     = true
  description = "Use preemptible VM"
}

variable "vm_web_disk_type" {
  type        = string
  default     = "network-hdd"
  description = "Boot disk type"
}

variable "vm_web_nat" {
  type        = bool
  default     = true
  description = "Attach external IP (NAT)"
}

variable "vm_web_network_acceleration_type" {
  type        = string
  default     = "standard"
  description = "Network acceleration type"
}
*/
