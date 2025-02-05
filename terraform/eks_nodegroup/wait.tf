resource "null_resource" "wait_60_seconds" {
  depends_on = [module.vpc]

  provisioner "local-exec" {
    command = "sleep 120"
  }
}