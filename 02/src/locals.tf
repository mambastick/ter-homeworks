locals {
  vm_names = {
    web = "netology-${var.vpc_name}-platform-web"
    db  = "netology-${var.vpc_name}-platform-db"
  }
}
