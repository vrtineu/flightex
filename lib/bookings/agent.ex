defmodule Flightex.Bookings.Agent do
  alias Flightex.Bookings.Booking
  use Agent

  def start_link(state) do
    Agent.start_link(fn -> state end, name: __MODULE__)
  end

  def save(%Booking{} = booking) do
    Agent.update(__MODULE__, &Map.put(&1, booking.id, booking))
    {:ok, booking.id}
  end

  def get(id), do: Agent.get(__MODULE__, &get_booking(&1, id))

  defp get_booking(state, id) do
    case Map.get(state, id) do
      nil -> {:error, "Booking not found"}
      booking -> {:ok, booking}
    end
  end
end
