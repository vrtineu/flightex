defmodule Flightex.Bookings.Booking do
  @keys [:complete_date, :local_origin, :local_destination, :user_id, :id]
  @enforce_keys @keys
  defstruct @keys

  def build(complete_date, local_origin, local_destination, user_id) do
    {:ok,
     %__MODULE__{
       id: UUID.uuid4(),
       user_id: user_id,
       complete_date: complete_date,
       local_origin: local_origin,
       local_destination: local_destination
     }}
  end

  def validate_complete_date(complete_date) do
    if is_naive_datetime(complete_date) do
      {:ok, complete_date}
    else
      {:error, "complete_date must be a NaiveDateTime"}
    end
  end

  defp is_naive_datetime(complete_date) do
    case complete_date do
      %NaiveDateTime{} -> true
      _ -> false
    end
  end
end
