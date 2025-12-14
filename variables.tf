###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}
variable "ssh_keys" {
  type = list(string)
  default = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPbgDF8jkO1xR4ZEVQhM98wPbAof+7OctByvBmLd/M9b ruslan",
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILtJ0WBY0tIdMLfAsuzBcsfGnh2a7a0Cy58ky65Ft85P ruslan92mv@gmail.com"

  ]
  description = "Список публичных SSH-ключей для cloud-init"
}
