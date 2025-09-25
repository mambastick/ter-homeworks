############################################
# Network
############################################

resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}

# Подсеть в зоне web-ВМ (использует var.zone)
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}

# Подсеть в ru-central1-b для DB-ВМ
resource "yandex_vpc_subnet" "develop_b" {
  name           = "${var.vpc_name}-b"
  zone           = var.vm_db_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = ["10.0.2.0/24"]
}

############################################
# Images
############################################

data "yandex_compute_image" "ubuntu_web" {
  family    = var.vm_web_image_family
  folder_id = var.vm_web_image_folder_id
}

data "yandex_compute_image" "ubuntu_db" {
  family    = var.vm_db_image_family
  folder_id = var.vm_db_image_folder_id
}

############################################
# VM: web
############################################

resource "yandex_compute_instance" "platform" {
  name                      = local.vm_names.web
  zone                      = var.zone
  platform_id               = var.vm_web_platform_id
  network_acceleration_type = var.vm_web_network_acceleration_type

  resources {
    cores         = var.vms_resources["web"].cores
    memory        = var.vms_resources["web"].memory
    core_fraction = var.vms_resources["web"].core_fraction
  }

  scheduling_policy {
    preemptible = var.vm_web_preemptible
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_web.id
      type     = var.vm_web_disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = var.vm_web_nat
    ipv4      = true
  }

  metadata = merge(
    var.metadata,
    { ssh-keys = var.vms_ssh_public_root_key }
  )
}

############################################
# VM: db (ru-central1-b)
############################################

resource "yandex_compute_instance" "db" {
  name                      = local.vm_names.db
  zone                      = var.vm_db_zone
  platform_id               = var.vm_db_platform_id
  network_acceleration_type = var.vm_db_network_acceleration_type

  resources {
    cores         = var.vms_resources["db"].cores
    memory        = var.vms_resources["db"].memory
    core_fraction = var.vms_resources["db"].core_fraction
  }

  scheduling_policy {
    preemptible = var.vm_db_preemptible
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_db.id
      type     = var.vm_db_disk_type
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop_b.id
    nat       = var.vm_db_nat
    ipv4      = true
  }

  metadata = merge(
    var.metadata,
    { ssh-keys = var.vms_ssh_public_root_key }
  )
}
