data "azurerm_client_config" "current" {}

data "null_data_source" "tag_defaults" {
  inputs = {
    Project_Name         = "${var.tag_project_name}"
    Environment          = "${var.tag_environment}"
    Cost_Center          = "${var.tag_cost_center}"
    Service              = "${var.tag_service}"
    App_Operations_Owner = "${var.tag_app_operations_owner}"
    System_Owner         = "${var.tag_system_owner}"
    Budget_Owner         = "${var.tag_budget_owner}"
    Created_By           = "Terraform"
  }
}

locals {
  slug_location = "${lower(replace(var.location, " ", "."))}"
}
