defmodule PickupParty.Challenge do

  defstruct name: nil, objects: 0, completed: false

  alias PickupParty.Challenge

  def new(name, count) do
    %Challenge{name: name, objects: count}
  end

  def from_task(%{name: name, object_count: count}) do
    Challenge.new(name, count)
  end


end
