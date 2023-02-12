defmodule Flightex.Bookings.Report do
  alias Flightex.Bookings.Booking
  alias Flightex.Bookings.Agent, as: BookingAgent

  def generate(filename \\ "report.csv") do
    bookings =
      BookingAgent.all()
      |> Enum.map(&to_csv_row/1)

    File.write!(filename, bookings)
  end

  def generate_report(filename \\ "report.csv", from_date, to_date) do
    bookings =
      BookingAgent.all()
      |> Enum.filter(&filter_by_date(&1, from_date, to_date))
      |> Enum.map(&to_csv_row/1)

    File.write!(filename, bookings)
  end

  defp to_csv_row(%Booking{
         complete_date: complete_date,
         id: id,
         local_destination: local_destination,
         local_origin: local_origin,
         user_id: user_id
       }) do
    "#{id},#{user_id},#{local_origin},#{local_destination},#{complete_date}\n"
  end

  defp filter_by_date(booking, from_date, to_date) do
    booking.complete_date >= from_date and booking.complete_date <= to_date
  end
end
