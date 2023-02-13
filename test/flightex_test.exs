defmodule FlightexTest do
  use ExUnit.Case

  describe "start_agents/0" do
    test "starts the user and booking agents" do
      assert {:ok, _} = Flightex.start_agents()
    end
  end

  describe "create_or_update_user/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "creates a user" do
      user = %{
        name: "John",
        email: "john@email.com",
        cpf: "12345678900"
      }

      assert {:ok, _} = Flightex.create_or_update_user(user)
    end
  end

  describe "create_or_update_booking/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "creates a booking" do
      booking = %{
        complete_date: ~N[2001-05-07 03:05:00],
        local_origin: "Brasilia",
        local_destination: "Bananeiras",
        user_id: "12345678900"
      }

      assert {:ok, _} = Flightex.create_or_update_booking(booking)
    end
  end

  describe "generate/1" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "generates a report" do
      response = Flightex.generate()

      expected_response = :ok

      assert response == expected_response
    end
  end

  describe "generate_report/3" do
    setup do
      Flightex.start_agents()
      :ok
    end

    test "generates a report" do
      from_date = ~N[2001-05-07 03:05:00]
      to_date = ~N[2001-05-07 03:05:00]
      response = Flightex.generate_report(from_date, to_date)

      expected_response = :ok

      assert response == expected_response
    end
  end
end
