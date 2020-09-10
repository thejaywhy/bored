defmodule PickupParty.TaskCache do
  @moduledoc """
  Load pickup party tasks into memory.

  Reload every hour.
  """

  use GenServer

  @refresh_interval :timer.minutes(60)

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def get_tasks() do
    GenServer.call(__MODULE__, :get_tasks)
  end

  def init(:ok) do
    cache = reload_tasks()
    schedule_reload()
    {:ok, cache}
  end

  def handle_call(:get_tasks, _from, cache) do
    {:reply, cache, cache}
  end

  def handle_info(:refresh, _cache) do
    cache = reload_tasks()
    schedule_reload()
    {:noreply, cache}
  end

  defp reload_tasks() do
    # read file
    "../../data/tasks.csv"
    |> Path.expand(__DIR__)
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [name, object_count] ->
      %{name: name, object_count: String.to_integer(object_count)}
    end)
  end

  defp schedule_reload() do
    Process.send_after(self(), :refresh, @refresh_interval)
  end
end
