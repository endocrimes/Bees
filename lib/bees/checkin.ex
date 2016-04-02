defmodule Bees.Checkin do
  @derive Poison.Encoder

  defstruct id: nil, shout: nil, created_at: nil, type: nil, venue: nil

  def with_venue(client, venue, broadcast \\ "public", shout \\ "") do
    params = [
      venueId: venue.id,
      broadcast: broadcast,
      shout: shout,
      v: "20160301"
    ]
    case Bees.Client.post(client, "/checkins/add", "",  params, true) do
      {:ok, %HTTPoison.Response{body: body} } ->
        checkin = decode(body)
        { :ok, checkin["response"]["checkin"] }
      {:error, error } ->
        { :error, error }
    end
  end

  # Private Helpers

  defp decode(body) do
    mapping = %{
      "response" => %{
        "checkin" => %Bees.Checkin{ venue: %Bees.Venue{} }
      }
    }

   Poison.decode!(body, as: mapping)
  end
end
