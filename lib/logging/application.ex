defmodule Logging.Application do
  @moduledoc false

  use Application

  require Logger

  def start(_type, _args) do
    children = [
      {Cluster.Supervisor, [topologies(), [name: Logging.ClusterSupervisor]]},
      {Plug.Cowboy, scheme: :http, plug: Logging.Router, options: [port: web_port()]}
    ]

    opts = [strategy: :one_for_one, name: Logging.Supervisor]

    Logger.info("Starting Logging application")

    Supervisor.start_link(children, opts)
  end

  defp topologies, do: config(:libcluster, :topologies)

  defp web_port do
    config(:logging, :web_port)
    |> String.to_integer()
  end

  defp config(context, key), do: Application.get_env(context, key)
end
