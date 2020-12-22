defmodule Logging.Events do
  @moduledoc false

  @data_path Application.get_env(:logging, :data_path)
  @events_file Application.get_env(:logging, :events_file)

  def log(event) do
    timestamp = :os.system_time(:millisecond)

    if !File.exists?(@data_path), do: File.mkdir(@data_path)

    write("#{timestamp} #{event}\n")
  end

  defp write(event), do: File.write("#{@data_path}/#{@events_file}", event, [:append])
end
