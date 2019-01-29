data "null_data_source" "redis_cache_outputs" {
  count = "${var.redis_cache_standard_required == "true" ? 1 : 0}"

  inputs = {
    redis_cache_resource_group = "${var.resource_group_name}"
    redis_cache_id             = "${join(",", azurerm_redis_cache.redis_cache_standard.*.id, azurerm_redis_cache.redis_cache_premium.*.id)}"
    redis_cache_hostname       = "${join(",", azurerm_redis_cache.redis_cache_standard.*.hostname, azurerm_redis_cache.redis_cache_premium.*.hostname)}"
  }
}

output "redis_cache_result" {
  value = "${data.null_data_source.redis_cache_outputs.inputs}"
}

output "redis_cache_result_json" {
  value = "${jsonencode(data.null_data_source.redis_cache_outputs.inputs)}"
}
