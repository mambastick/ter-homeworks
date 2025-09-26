locals {
  web = [
    for w in yandex_compute_instance.web : {
      name = w.name
      ip   = w.network_interface[0].nat_ip_address
      fqdn = w.fqdn
    }
  ]

  db = [
    for _, d in yandex_compute_instance.db : {
      name = d.name
      ip   = d.network_interface[0].nat_ip_address
      fqdn = d.fqdn
    }
  ]

  storage = [
    {
      name = yandex_compute_instance.storage.name
      ip   = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn = yandex_compute_instance.storage.fqdn
    }
  ]
}

resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = local.web
    databases  = local.db
    storage    = local.storage
  })
  filename = "${path.module}/inventory/hosts.ini"
}
