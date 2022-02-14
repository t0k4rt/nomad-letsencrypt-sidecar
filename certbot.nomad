job "certbot_gandi" {
  region      = "europe"
  datacenters = ["ovh"]
  type        = "batch"

  group "certbot_gandi" {
    count = 1

    task "certbot_gandi" {

      driver = "docker"
      template {
        data = <<EOH
        dns_gandi_api_key={{ key "GANDI_API_KEY" }}
        EOH
        destination = "secrets/gandi.ini"
      }

      template {
        data = <<EOH
        email = #email_here
        authenticator = dns-gandi
        dns-gandi-credentials = {{ env "NOMAD_SECRETS_DIR" }}/secrets/gandi.ini
        agree-tos = true
        deploy-hook = /config/haproxy_hook.sh
        EOH
        destination = "local/certbot.ini"
      }

      config {
        image   = "ghcr.io/t0k4rt/nomad-letsencrypt-sidecar:main"
        args = ["-d your domain", "--staging"]
      }
    }
  }
}
