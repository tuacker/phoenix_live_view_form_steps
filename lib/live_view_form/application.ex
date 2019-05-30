defmodule LiveViewForm.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the Ecto repository
      LiveViewForm.Repo,
      # Start the endpoint when the application starts
      LiveViewFormWeb.Endpoint
      # Starts a worker by calling: LiveViewForm.Worker.start_link(arg)
      # {LiveViewForm.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: LiveViewForm.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    LiveViewFormWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
