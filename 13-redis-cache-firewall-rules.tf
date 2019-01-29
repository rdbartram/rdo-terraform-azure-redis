#--------------------------------------------------------------
# Redis Cache Firewall Rules
#--------------------------------------------------------------

## create firewall_rules from a map, whose values are colon seperated strings
## this list defaults to {}
## each firewall_rule map key/value pair should have the format:
## <rule_identifier>: "<rule_start_ip>:<rule_end_ip>"
## eg:  variable "redis_cache_firewall_rules" {
##          type = "map"
##          default = {
##              office = "192.0.0.1:192.0.0.5"
##          }
##      }
resource "azurerm_redis_firewall_rule" "redis_cache_standard_firewall_rule" {
  count = "${(var.redis_cache_standard_required == "true" ? 1 : 0) * length(var.redis_cache_firewall_rules)}"

  name = "${format("%s_%s",
                var.service_name_prefix,
                element(
                    keys(var.redis_cache_firewall_rules),
                    count.index
                )
            )}"

  resource_group_name = "${var.resource_group_name}"
  redis_cache_name    = "${azurerm_redis_cache.redis_cache_standard.name}"

  end_ip = "${element(
        split(":",
            element(
                values(var.redis_cache_firewall_rules),
                count.index
            )
        ),
        1
    )}"

  start_ip = "${element(
        split(":",
            element(
                values(var.redis_cache_firewall_rules),
                count.index
            )
        ),
        0
    )}"
}

resource "azurerm_redis_firewall_rule" "redis_cache_premium_firewall_rule" {
  count = "${(var.redis_cache_premium_required == "true" ? 1 : 0) * length(var.redis_cache_firewall_rules)}"

  name = "${format("%s_%s",
                var.service_name_prefix,
                element(
                    keys(var.redis_cache_firewall_rules),
                    count.index
                )
            )}"

  resource_group_name = "${var.resource_group_name}"
  redis_cache_name    = "${azurerm_redis_cache.redis_cache_premium.name}"

  end_ip = "${element(
        split(":",
            element(
                values(var.redis_cache_firewall_rules),
                count.index
            )
        ),
        1
    )}"

  start_ip = "${element(
        split(":",
            element(
                values(var.redis_cache_firewall_rules),
                count.index
            )
        ),
        0
    )}"
}
