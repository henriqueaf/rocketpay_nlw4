defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.{User, Repo}
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all params are valid, returns an user" do
      params = %{
        name: "Henrique",
        password: "123456",
        nickname: "henrique",
        email: "henrique@banana.com",
        age: 31
      }

      {:ok, %User{id: user_id}} = Create.call(params)

      user = Repo.get(User, user_id)

      assert %User{name: "Henrique", age: 31, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Henrique",
        nickname: "henrique",
        email: "henrique@banana.com",
        age: 15
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        password: ["can't be blank"],
        age: ["must be greater than or equal to 18"]
      }

      assert expected_response == errors_on(changeset)
    end
  end
end
