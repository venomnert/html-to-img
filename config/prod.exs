import Mix.Config

config :html_img_api, HtmlImgApiWeb.Endpoint,
  load_from_system_env: true,
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  code_reloader: false

# Do not print debug messages in production
config :logger, level: :info
