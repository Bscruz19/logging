defmodule Logging.EventsManager do
  @moduledoc false

  alias Logging.Events

  def send_messages(event), do: Enum.each(nodes(), &spawn_events(&1, event))

  defp nodes, do: Node.list([:this, :visible])

  defp spawn_events(node, event), do: Node.spawn(node, fn -> Events.log(event) end)
end
