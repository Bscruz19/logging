defmodule Logging.RouterTest do
  use ExUnit.Case
  use Plug.Test

  alias Logging.Router

  @opts Router.init([])

  test "returns 200" do
    conn =
      :post
      |> conn("/event", "")
      |> Router.call(@opts)

    assert conn.status == 200
  end

  test "returns 404" do
    conn =
      :post
      |> conn("/big_events", "")
      |> Router.call(@opts)

    assert conn.status == 404
  end
end
