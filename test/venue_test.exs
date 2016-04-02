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
    use_cassette "venue_by_location" do
      {status, body} = Bees.Venue.search(client, 55.2, 44.1, 1, "checkin", 800)
      assert status == :ok
      assert length(body) == 1
    end
  end

  test "find by identifier" do
    use_cassette "venue_by_identifier" do
      {status, body} = Bees.Venue.find_by_identifier(client, "501fea4de4b05e0d96afc368")
      assert status == :ok
      assert body.id == "501fea4de4b05e0d96afc368"
    end
  end
end
