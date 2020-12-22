defmodule Logging.EventsManagerTest do
  use ExUnit.Case

  alias Logging.EventsManager

  describe "send_messages" do
    test "logs an event when the events file exists" do
      event = "Community - Paintball Assassin"

      assert :ok = EventsManager.send_messages(event)
    end
  end
end
