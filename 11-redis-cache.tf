#--------------------------------------------------------------
# Redis Cache Standard
#--------------------------------------------------------------

resource "azurerm_redis_cache" "redis_cache_standard" {
  count = "${var.redis_cache_standard_required == "true" ? 1 : 0}"

  name = "${replace(format("%s_%s_%s_standard",
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
            lookup(var.redis_cache_standard_sku,
                "capacity", ""
            ),
            lookup(var.default_redis_cache_standard_sku,
                "capacity"
            )
        )}"

  family = "${coalesce(
            lookup(var.redis_cache_standard_sku,
                "family", ""
            ),
            lookup(var.default_redis_cache_standard_sku,
                "family"
            )
        )}"

  sku_name = "${coalesce(
            lookup(var.redis_cache_standard_sku,
                "sku_name", ""
            ),
            lookup(var.default_redis_cache_standard_sku,
                "sku_name"
            )
        )}"

  enable_non_ssl_port = "${var.redis_cache_enable_non_ssl_port}"

  redis_configuration {
    maxmemory_reserved = "${var.redis_cache_standard_maxmemory_reserved}"
    maxmemory_delta    = "${var.redis_cache_standard_maxmemory_delta}"
    maxmemory_policy   = "${var.redis_cache_standard_maxmemory_policy}"
  }
}
