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
      {status, body} = Bees.Venue.search(client(), 55.2, 44.1, 1, "checkin", 800)
      assert status == :ok
      assert length(body) == 1
    end
  end

  test "find by identifier" do
    use_cassette "venue_by_identifier" do
      {status, body} = Bees.Venue.find_by_identifier(client(), "501fea4de4b05e0d96afc368")
      assert status == :ok
      assert body.id == "501fea4de4b05e0d96afc368"
    end
  end

  test "by recommendations" do
    use_cassette "venue_by_recommendations" do
      {status,
        [%{"type" => type, "name" => name, "items" => items}]
      } = Bees.Venue.explore(client(), 55.2, 44.1, 1, "topPicks")

      assert status == :ok
      assert type == "Recommended Places"
      assert name == "recommended"
      assert Enum.count(items) > 0
    end
  end

  test "by recommendations with venue photos" do
    use_cassette "venue_by_recommendations_with_photos" do
      {status, [%{"items" => items}]} = Bees.Venue.explore(client(), 55.2, 44.1, 1, "trending", 0, 1)
      [%{"venue" => %{"photos" => %{"count" => count}}}] = items

      assert count > 0
    end
  end
end
