locals {
  ssh_pubkey = trimspace(file("~/.ssh/id_ed25519.pub"))
}
