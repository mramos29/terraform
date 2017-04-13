provider "scaleway" {
  organization = "${var.scaleway_key}"
  token        = "${var.scaleway_token}"
  region       = "par1"
}

resource "scaleway_ip" "scaleway01" {
  server = "${scaleway_server.scaleway01.id}"
}

resource "scaleway_server" "scaleway01" {
  name  = "scaleway01"
  image = "aecaed73-51a5-4439-a127-6d8229847145"
  type  = "C2S"
}

resource "scaleway_volume" "scaleway01" {
  name       = "scaleway01"
  size_in_gb = 20
  type       = "l_ssd"
}

resource "scaleway_volume_attachment" "scaleway01" {
  server = "${scaleway_server.scaleway01.id}"
  volume = "${scaleway_volume.scaleway01.id}"
}

resource "scaleway_security_group" "http" {
  name        = "http"
  description = "allow HTTP and HTTPS traffic"
}

resource "scaleway_security_group_rule" "http_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 80
}

resource "scaleway_security_group_rule" "https_accept" {
  security_group = "${scaleway_security_group.http.id}"

  action    = "accept"
  direction = "inbound"
  ip_range  = "0.0.0.0/0"
  protocol  = "TCP"
  port      = 443
}
