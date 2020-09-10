defmodule PickupParty do
  @moduledoc """
  Documentation for `PickupParty`.
  """

  use Application

  def start(_type, _arg) do
    children = [
      PickupParty.TaskCache
    ]

    opts = [strategy: :one_for_one, name: PickupParty.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
