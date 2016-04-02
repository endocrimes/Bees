defmodule VenueTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Bees.Venue

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

  test "search by ll" do
    use_cassette "venue" do
      {status, body} = Bees.Venue.search(client, 55.2, 44.1, 1, "checkin", 800)
      assert status == :ok
      assert length(body) == 1
    end
  end
end
