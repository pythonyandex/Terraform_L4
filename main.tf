module "vpc_stage" {
  source   = "./modules/vpc"
  env_name = "stage"
  
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.10.0/24" },
  ]
  
  description = "Stage environment network"
  
  labels = {
    environment = "stage"
    terraform   = "true"
    project     = "accounting"
  }
}

module "mysql_cluster" {
  source = "./modules/mysql-cluster"

  cluster_name = "my-mysql-cluster"
  network_id   = module.vpc_stage.network_id
  subnets = [
    {
      id   = module.vpc_stage.subnet_ids[0]
      zone = "ru-central1-a"
    }
  ]
  ha_mode      = true
  
  environment  = "PRODUCTION" 
  
  database_name = "app_database"
  username      = "app_user"
  password      = "SecurePass123!"

  disk_size          = 20
  disk_type_id       = "network-ssd"
  resource_preset_id = "s2.small"

  labels = {
    project     = "my-project"
    owner       = "devops-team"
    application = "web-application"
  }
}

module "marketing_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop"
  network_id     = module.vpc_stage.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_stage.subnet_ids[0]]    # ПРАВИЛЬНО
  instance_name  = "webs"
  instance_count = 2
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    owner   = "i.ivanov",
    project = "accounting"
    tag     = "analytics"
  }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

module "analytics_vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = module.vpc_stage.network_id
  subnet_zones   = ["ru-central1-a"]
  subnet_ids     = [module.vpc_stage.subnet_ids[0]]    # ПРАВИЛЬНО
  instance_name  = "web-stage"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = {
    owner   = "i.ivanov",
    project = "accounting"
    tag     = "analytics"
  }
  
  metadata = {
    user-data          = data.template_file.cloudinit.rendered
    serial-port-enable = 1
  }
}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_keys = join("\n", [for key in var.ssh_keys : "      - ${key}"])
  }
}
