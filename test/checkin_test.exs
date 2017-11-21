defmodule CheckinTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Bees.Checkin

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

  test "check in with a correct venue identifier" do
    use_cassette "checkin" do
      venueId = "501fea4de4b05e0d96afc368"
      {status, body} = Bees.Checkin.with_venue(client(), %Bees.Venue{id: venueId}, "public", "This is a test")
      assert status == :ok
      assert body != nil
      assert body.venue != nil
      assert body.venue.id == venueId
      assert body.shout == "This is a test"
    end
  end

  test "retreive checkins for a user" do
    use_cassette "user_checkins" do
      {status, body} = Bees.Checkin.for_self(client())
      assert status == :ok
      assert body != nil
    end
  end
end
