locals {
  network_name = "vpc-${var.env_name}"
}

resource "yandex_vpc_network" "network" {
  name = local.network_name
  labels = var.labels
}

# Динамически создаём подсети в каждой зоне
resource "yandex_vpc_subnet" "subnets" {
  for_each = { for idx, subnet in var.subnets : idx => subnet }

  name           = "${local.network_name}-${each.value.zone}"
  zone           = each.value.zone
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = [each.value.cidr]
  description    = var.description

  labels = merge(var.labels, {
    subnet_index = each.key
    zone         = each.value.zone
  })
}

