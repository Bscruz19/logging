defmodule Logging.EventsTest do
  use ExUnit.Case

  alias Logging.Events

  @data_path Application.get_env(:logging, :data_path)
  @events_file Application.get_env(:logging, :events_file)
  @events_path "#{@data_path}/#{@events_file}"

  describe "log" do
    test "logs an event when the events file exists" do
      event = "Rocky Balboa x Apollo Creed"

      assert :ok = Events.log(event)

      assert @events_path
             |> File.read!()
             |> String.contains?(event)
    end

    test "logs an event when the events file does not exist" do
      event = "big bang"

      File.rm(@events_path)

      assert :ok = Events.log(event)

      assert @events_path
             |> File.read!()
             |> String.contains?(event)
    end
  end
end
