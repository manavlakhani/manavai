output "app_name" {
  value = azurerm_windows_web_app.webapp-pmp.name
}

output "app_url" {
  value = "https://${azurerm_windows_web_app.webapp-pmp.default_hostname}"
}