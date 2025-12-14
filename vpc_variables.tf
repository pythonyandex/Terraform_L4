variable "env_name" {
  type        = string
  description = "Имя окружения (используется для именования сети)"
}

variable "subnets" {
  type = list(object({
    zone = string
    cidr = string
  }))
  description = "Список подсетей для создания. Каждая подсеть задаётся зоной и CIDR-блоком."
  
  validation {
    condition = alltrue([
      for s in var.subnets : can(regex("^ru-central1-[a-c]$", s.zone))
    ])
    error_message = "Зона должна быть одной из: ru-central1-a, ru-central1-b, ru-central1-c."
  }
  
  validation {
    condition = alltrue([
      for s in var.subnets : can(cidrnetmask(s.cidr))
    ])
    error_message = "CIDR должен быть в правильном формате (например, 10.0.1.0/24)."
  }
}

variable "description" {
  type        = string
  description = "Описание сети и подсетей"
  default     = null
}

variable "dhcp_options" {
  type = object({
    domain_name         = optional(string)
    domain_name_servers = optional(list(string))
    ntp_servers         = optional(list(string))
  })
  description = "Настройки DHCP для всех подсетей"
  default     = null
}

variable "labels" {
  type        = map(string)
  description = "Дополнительные метки для всех ресурсов"
  default     = {}
}