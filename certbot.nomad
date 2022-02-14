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
        email = infra@kairosagency.com
        authenticator = dns-gandi
        dns-gandi-credentials = {{ env "NOMAD_SECRETS_DIR" }}/secrets/gandi.ini
        agree-tos = true
        deploy-hook = /config/haproxy_hook.sh
        EOH
        destination = "local/certbot.ini"
      }

      config {
        image   = "git.kairosagency.com:4567/devops/certbot-gandi:[[ env "DOCKER_TAG" ]]"
        args = ["-d admin-dev.oh.kairosfire.fr", "-d api-dev.ovh.kairosfire.fr", "-d grafana-dev.ovh.kairosfire.fr", "--staging"]
        auth {
          username  = "gitlab-ci-token"
          password  = "[[ env "CI_JOB_TOKEN" ]]"
        }
        ports = ["db"]
      }
    }
  }
}
