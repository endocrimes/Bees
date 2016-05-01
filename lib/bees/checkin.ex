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

  def for_self(client) do
    params = [
      v: "20160301"
    ]
    case Bees.Client.get(client, "/users/self/checkins", params, true) do
      {:ok, %HTTPoison.Response{body: body} } ->
        checkins = decode_many(body)
        { :ok, checkins["response"]["checkins"]["items"] }
      {:error, error } ->
        { :error, error }
    end
  end

  # Private Helpers

  defp decode_many(body) do
    mapping = %{
      "response" => %{
        "checkins" => %{
          "items" => [%Bees.Checkin{ venue: %Bees.Venue{} }]
        }
      }
    }

   Poison.decode!(body, as: mapping)
  end

  defp decode(body) do
    mapping = %{
      "response" => %{
        "checkin" => %Bees.Checkin{ venue: %Bees.Venue{} }
      }
    }

   Poison.decode!(body, as: mapping)
  end
end
