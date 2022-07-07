defmodule GithubDeploy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      GithubDeploy.Repo,
      # Start the Telemetry supervisor
      GithubDeployWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: GithubDeploy.PubSub},
      # Start the Endpoint (http/https)
      GithubDeployWeb.Endpoint
      # Start a worker by calling: GithubDeploy.Worker.start_link(arg)
      # {GithubDeploy.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GithubDeploy.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GithubDeployWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
