defmodule Bees.Venue do
  @derive Poison.Encoder

  defstruct id: nil, name: nil, contact: nil, location: nil, categories: nil,
  verified: nil, stats: nil, likes: nil, specials: nil, here_now: nil,
  referral_id: nil, photos: nil, groups: nil

  def find_by_identifier(client, identifier) do
    params = [
      v: "20160301"
    ]

    case Bees.Client.get(client, "/venues/#{identifier}", params, false) do
      {:ok, %HTTPoison.Response{body: body}} ->
         response = decode_single(body)
         {:ok, response["response"]["venue"]}
      {:error, error} ->
        {:error, error}
    end
  end

  def search(client, latitude, longitude, limit \\ 10, intent \\ "checkin", radius \\ 800) do
    params = [
      ll: "#{latitude},#{longitude}",
      intent: intent,
      radius: radius,
      limit: limit,
      v: "20160301"
    ]
    case Bees.Client.get(client, "/venues/search", params, false) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = decode_many(body)
        {:ok,  response["response"]["venues"]}
      {:error, error} ->
        {:error, error}
    end
  end

  def explore(client, latitude, longitude, limit \\ 50, section \\ "topPicks", open_now \\ 0, venue_photos \\ 0, radius \\ 800) do
    params = [
      ll: "#{latitude},#{longitude}",
      section: section,
      radius: radius,
      limit: limit,
      openNow: open_now,
      venuePhotos: venue_photos,
      v: "20160301"
    ]

    case Bees.Client.get(client, "/venues/explore", params, false) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = decode_many(body)
        {:ok,  response["response"]["groups"]}
      {:error, error} ->
        {:error, error}
    end
  end

  # Private Helpers

  defp decode_many(body) do
    mapping = %{
      "response" => %{
        "venues" => [decoder]
      }
    }

    Poison.decode!(body, as: mapping)
  end

  defp decode_single(body) do
    mapping = %{
      "response" => %{
        "venue" => decoder
      }
    }

    Poison.decode!(body, as: mapping)
  end

  defp decoder() do
    %Bees.Venue{}
  end
end
