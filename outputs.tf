output "Server Name" {
  value = "${scaleway_server.scaleway01.name}"
}

output "Public ip" {
  value = "${scaleway_server.scaleway01.public_ip}"
}

