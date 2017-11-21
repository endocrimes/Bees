defmodule PhotoTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Bees.Photo

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

  test "for_venue" do
    use_cassette "photo_for_venue" do
      {status, body} = Bees.Photo.from_venue(client(), "510d6edfe4b0d7e116e6d1e0", 1, 1)
      assert status == :ok
      assert Enum.count(body["items"]) == 1
    end
  end
end
