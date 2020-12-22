defmodule Logging.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  alias Logging.EventsManager

  post "/event" do
    case read_body(conn) do
      {:ok, text, _} ->
        EventsManager.send_messages(text)

        send_resp(conn, 200, "")

      _ ->
        send_resp(conn, 400, "")
    end
  end

  match _ do
    send_resp(conn, 404, "")
  end
end
