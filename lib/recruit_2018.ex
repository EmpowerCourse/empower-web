defmodule Recruit2018 do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Recruit2018.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Recruit2018.Endpoint, []),
      # Start your own worker by calling: Recruit2018.Worker.start_link(arg1, arg2, arg3)
      # 17-May-18, ART: no more applications, no more need for notifications
      # worker(Recruit2018.SendNotifications, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Recruit2018.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Recruit2018.Endpoint.config_change(changed, removed)
    :ok
  end
end
