variable "redis_cache_standard_sku" {
  type = "map"

  default = {}
}

variable "default_redis_cache_standard_sku" {
  type = "map"

  default = {
    sku_name = "Standard"
    capacity = "1"
    family   = "C"
  }
}

variable "redis_cache_enable_non_ssl_port" {
  default = true
}

variable "redis_cache_standard_maxmemory_reserved" {
  default = "50"
}

variable "redis_cache_standard_maxmemory_delta" {
  default = "50"
}

variable "redis_cache_standard_maxmemory_policy" {
  default = "volatile-lru"
}

variable "redis_cache_patch_schedule_day" {
  default = "Monday"
}

variable "redis_cache_patch_schedule_hour" {
  default = "0"
}

variable "redis_cache_premium_sku" {
  type = "map"

  default = {}
}

variable "default_redis_cache_premium_sku" {
  type = "map"

  default = {
    sku_name = "Premium"
    capacity = "1"
    family   = "P"
  }
}

variable "redis_cache_premium_shard_count" {
  default = "3"
}

variable "redis_cache_premium_maxmemory_reserved" {
  default = "200"
}

variable "redis_cache_premium_maxmemory_delta" {
  default = "200"
}

variable "redis_cache_premium_maxmemory_policy" {
  default = "volatile-lru"
}

variable "redis_cache_premium_rdb_backup_enabled" {
  default = "true"
}

variable "redis_cache_premium_rdb_backup_frequency" {
  default = "60"
}

variable "redis_cache_premium_rdb_backup_max_snapshot_count" {
  default = "1"
}

variable "redis_cache_premium_storage_account_type" {
  default = "Standard_LRS"
}

variable "redis_cache_firewall_rules" {
  type = "map"

  default = {}
}
