defmodule PickupParty.Party do
  defstruct tasks: nil, start_time: nil

  alias PickupParty.{Party, Challenge, TaskCache}

  def new() do
    challenges = TaskCache.get_tasks()
    Party.new(challenges)
  end

  def new(challenges) do
    tasks =
      challenges
      |> Enum.shuffle()
      |> Enum.map(&Challenge.from_task(&1))

    %Party{tasks: tasks, start_time: Time.utc_now()}
  end

end
