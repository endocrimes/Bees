defmodule UserTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Bees.User

  defp client() do
    %Bees.Client{
      client_id: "CLIENT_ID",
      client_secret: "CLIENT_SECRET",
      access_token: "ACCESS_TOKEN"
    }
  end

  setup_all do
    Bees.Client.start
  end

  test "retrieve details for a user" do
    use_cassette "user_details" do
      {status, user} = Bees.User.details(client)

      assert status == :ok
      assert user != nil
      assert user.id == "fake-id"
    end
  end
end
