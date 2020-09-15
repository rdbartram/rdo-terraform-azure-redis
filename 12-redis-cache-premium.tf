#--------------------------------------------------------------
# Redis Cache Premium
#--------------------------------------------------------------

resource "azurerm_storage_account" "redis_cache_storage_account" {
  count = "${var.redis_cache_premium_required == "true" ? 1 : 0}"

  name = "${replace(format("%s_%s_%s_premium",
                var.service_name_prefix,
                lookup(data.null_data_source.tag_defaults.inputs, "Environment"),
                var.service_shortname
            ),
        "_",
        "-"
    )}"

  location                 = "${var.location}"
  resource_group_name      = "${var.resource_group_name}"
  account_tier             = "${element(split("_", var.redis_cache_premium_storage_account_type),0)}"
  account_replication_type = "${element(split("_", var.redis_cache_premium_storage_account_type),1)}"
}

resource "azurerm_redis_cache" "redis_cache_premium" {
  count = "${var.redis_cache_premium_required == "true" ? 1 : 0}"

  name = "${replace(format("%s_%s_%s_premium",
                var.service_name_prefix,
                lookup(data.null_data_source.tag_defaults.inputs, "Environment"),
                var.service_shortname
            ),
        "_",
        "-"
    )}"

  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  capacity = "${coalesce(
            lookup(var.redis_cache_premium_sku,
                "capacity", ""
            ),
            lookup(var.default_redis_cache_premium_sku,
                "capacity"
            )
        )}"

  family = "${coalesce(
            lookup(var.redis_cache_premium_sku,
                "family", ""
            ),
            lookup(var.default_redis_cache_premium_sku,
                "family"
            )
        )}"

  sku_name = "${coalesce(
            lookup(var.redis_cache_premium_sku,
                "sku_name", ""
            ),
            lookup(var.default_redis_cache_premium_sku,
                "sku_name"
            )
        )}"

  enable_non_ssl_port = "${var.redis_cache_enable_non_ssl_port}"
  subnet_id           = "${data.azurerm_subnet.public.id}"

  shard_count = "${var.redis_cache_premium_shard_count}"

  redis_configuration {
    maxmemory_reserved            = "${var.redis_cache_premium_maxmemory_reserved}"
    maxmemory_delta               = "${var.redis_cache_premium_maxmemory_delta}"
    maxmemory_policy              = "${var.redis_cache_premium_maxmemory_policy}"
    rdb_backup_enabled            = "${var.redis_cache_premium_rdb_backup_enabled}"
    rdb_backup_frequency          = "${var.redis_cache_premium_rdb_backup_frequency}"
    rdb_backup_max_snapshot_count = "${var.redis_cache_premium_rdb_backup_max_snapshot_count}"
    rdb_storage_connection_string = "DefaultEndpointsProtocol=https;BlobEndpoint=${azurerm_storage_account.redis_cache_storage_account[0].primary_blob_endpoint};AccountName=${azurerm_storage_account.redis_cache_storage_account[0].name};AccountKey=${azurerm_storage_account.redis_cache_storage_account[0].primary_access_key}"
  }

  patch_schedule {
    day_of_week    = "${var.redis_cache_patch_schedule_day}"
    start_hour_utc = "${var.redis_cache_patch_schedule_hour}"
  }
}
