data "null_data_source" "redis_cache_debug_outputs" {
  count = "${var.enable_debug == "true" ? 1 : 0}"

  inputs = {
    redis_cache_enable_non_ssl_port                   = "${var.redis_cache_enable_non_ssl_port}"
    redis_cache_standard_maxmemory_reserved           = "${var.redis_cache_standard_maxmemory_reserved}"
    redis_cache_standard_maxmemory_delta              = "${var.redis_cache_standard_maxmemory_delta}"
    redis_cache_standard_maxmemory_policy             = "${var.redis_cache_standard_maxmemory_policy}"
    redis_cache_patch_schedule_day                    = "${var.redis_cache_patch_schedule_day}"
    redis_cache_patch_schedule_hour                   = "${var.redis_cache_patch_schedule_hour}"
    redis_cache_premium_shard_count                   = "${var.redis_cache_premium_shard_count}"
    redis_cache_premium_maxmemory_reserved            = "${var.redis_cache_premium_maxmemory_reserved}"
    redis_cache_premium_maxmemory_delta               = "${var.redis_cache_premium_maxmemory_delta}"
    redis_cache_premium_maxmemory_policy              = "${var.redis_cache_premium_maxmemory_policy}"
    redis_cache_premium_rdb_backup_enabled            = "${var.redis_cache_premium_rdb_backup_enabled}"
    redis_cache_premium_rdb_backup_frequency          = "${var.redis_cache_premium_rdb_backup_frequency}"
    redis_cache_premium_rdb_backup_max_snapshot_count = "${var.redis_cache_premium_rdb_backup_max_snapshot_count}"
    redis_cache_premium_storage_account_type          = "${var.redis_cache_premium_storage_account_type}"
  }
}

output "redis_cache_debug_config" {
  value = "${ data.null_data_source.debug_outputs.*.inputs}"
}
