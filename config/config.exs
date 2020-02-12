# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :html_img_api, HtmlImgApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bUiYRavQZGPmuow89q3/Ocl2NBl1D+lB/EI7Z0I4EKpGMc0U/49x8ktYwElA0j5w",
  render_errors: [view: HtmlImgApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HtmlImgApi.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
