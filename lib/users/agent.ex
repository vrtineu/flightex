defmodule Flightex.Users.Agent do
  use Agent
  alias Flightex.Users.User

  def start_link(initial_state \\ %{}) do
    Agent.start_link(fn -> initial_state end, name: __MODULE__)
  end

  def save(%User{} = user) do
    Agent.update(__MODULE__, &Map.put(&1, user.cpf, user))
    {:ok, user}
  end

  def get(cpf), do: Agent.get(__MODULE__, &get_user(&1, cpf))

  def get_user(state, cpf) do
    case Map.get(state, cpf) do
      nil -> {:error, "User not found"}
      user -> {:ok, user}
    end
  end
end
