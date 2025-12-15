<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~>1.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_yandex"></a> [yandex](#provider\_yandex) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [yandex_vpc_network.network](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_network) | resource |
| [yandex_vpc_subnet.subnets](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/vpc_subnet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Описание сети и подсетей | `string` | `null` | no |
| <a name="input_dhcp_options"></a> [dhcp\_options](#input\_dhcp\_options) | Настройки DHCP для всех подсетей | <pre>object({<br/>    domain_name         = optional(string)<br/>    domain_name_servers = optional(list(string))<br/>    ntp_servers         = optional(list(string))<br/>  })</pre> | `null` | no |
| <a name="input_env_name"></a> [env\_name](#input\_env\_name) | Имя окружения (используется для именования сети) | `string` | n/a | yes |
| <a name="input_labels"></a> [labels](#input\_labels) | Дополнительные метки для всех ресурсов | `map(string)` | `{}` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | Список подсетей для создания. Каждая подсеть задаётся зоной и CIDR-блоком. | <pre>list(object({<br/>    zone = string<br/>    cidr = string<br/>  }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | ID созданной сети |
| <a name="output_network_name"></a> [network\_name](#output\_network\_name) | Имя созданной сети |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | Список ID подсетей |
| <a name="output_subnet_ids_by_zone"></a> [subnet\_ids\_by\_zone](#output\_subnet\_ids\_by\_zone) | ID подсетей, сгруппированные по зонам |
| <a name="output_subnets"></a> [subnets](#output\_subnets) | Созданные подсети в формате map |
| <a name="output_subnets_by_zone"></a> [subnets\_by\_zone](#output\_subnets\_by\_zone) | Созданные подсети, сгруппированные по зонам |
<!-- END_TF_DOCS -->