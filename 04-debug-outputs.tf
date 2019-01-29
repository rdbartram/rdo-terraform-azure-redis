data "null_data_source" "debug_outputs" {
  count = "${var.enable_debug == "true" ? 1 : 0}"

  inputs = {
    # inputs-required
    deploy_environment          = "${var.deploy_environment}"
    location                    = "${var.location}"
    network_name                = "${var.network_name}"
    network_shortname           = "${var.network_shortname}"
    network_resource_group_name = "${var.network_resource_group_name}"
    service_shortname           = "${var.service_shortname}"
    service_name_prefix         = "${var.service_name_prefix}"

    # inputs-default
    enable_debug                  = "${var.enable_debug}"
    redis_cache_standard_required = "${var.redis_cache_standard_required}"
    redis_cache_premium_required  = "${var.redis_cache_premium_required}"
  }
}

output "debug_config" {
  value = "${ data.null_data_source.debug_outputs.*.inputs}"
}
