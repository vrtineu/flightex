defmodule Flightex.Bookings.ReportTest do
  use ExUnit.Case, async: true

  import Flightex.Factory

  alias Flightex.Bookings.Report

  describe "generate/1" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content" do
      params = build(:booking, complete_date: ~N[2001-05-07 12:00:00], user_id: "12345678900")

      content = "12345678900,Brasilia,Bananeiras,2001-05-07 12:00:00"

      Flightex.create_or_update_booking(params)
      Report.generate("report-test.csv")
      {:ok, file} = File.read("report-test.csv")

      assert file =~ content
    end
  end

  describe "generate_report/2" do
    setup do
      Flightex.start_agents()

      :ok
    end

    test "when called, return the content filtered by date" do
      [params1, params2, params3] = [
        build(:booking),
        build(:booking, complete_date: ~N[2001-05-08 12:00:00], local_origin: "Sao Paulo"),
        build(:booking, complete_date: ~N[2001-05-09 12:00:00], local_origin: "Rio de Janeiro")
      ]

      {:ok, _} = Flightex.create_or_update_booking(params1)
      {:ok, id1} = Flightex.create_or_update_booking(params2)
      {:ok, id2} = Flightex.create_or_update_booking(params3)

      filename = "report-test.csv"
      Report.generate_report(filename, ~N[2001-05-08 00:00:00], ~N[2001-05-09 23:59:59])

      {:ok, file} = File.read(filename)

      expected_response =
        "#{id1},12345678900,Sao Paulo,Bananeiras,2001-05-08 12:00:00\n" <>
          "#{id2},12345678900,Rio de Janeiro,Bananeiras,2001-05-09 12:00:00\n"

      assert file =~ expected_response
    end
  end
end
