# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :recruit_2018,
  ecto_repos: [Recruit2018.Repo],
  app_name: "Recruiting 2018",
  app_name_abbr: "R2018",
  system_email: "ali@sightsource.net",
  notify_check_interval_ms: 28_800_000 # once every 8 hours

# Configures the endpoint
config :recruit_2018, Recruit2018.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5bws5wP0X+4rhgbbSqlAKCNd+vkAtkao8WezfNgSqLPhsPsE0Vxz0qHQgn2X2vSv",
  render_errors: [view: Recruit2018.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Recruit2018.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :recruit_2018, Recruit2018.Notify,
  adapter: Bamboo.SMTPAdapter,
  server: "email-smtp.us-east-1.amazonaws.com",
  port: 587,
  username: "username goes here",
  password: "password goes here",
  tls: :always,
  # auth: :always,
  # ssl: false,
  retries: 1

config :ex_aws,
  access_key_id: "key goes here",
  secret_access_key: "access key here"

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
