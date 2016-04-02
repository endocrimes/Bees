defmodule Bees.Venue do
  @derive Poison.Encoder

  defstruct id: nil, name: nil, contact: nil, location: nil, categories: nil,
  verified: nil, stats: nil, likes: nil, specials: nil, here_now: nil,
  referral_id: nil

  def search(client, latitude, longitude, limit \\ 10, intent \\ "checkin", radius \\ 800) do
    params = [
      ll: "#{latitude},#{longitude}",
      intent: intent,
      radius: radius,
      limit: limit,
      client_id: client.client_id,
      client_secret: client.client_secret,
      v: "20160301"
    ]
    case Bees.Client.get(client, "/venues/search", params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = decode(body)
        {:ok,  response["response"]["venues"]}
      {:error, error} ->
        {:error, error}
    end
  end

  # Private Helpers

  defp decode(body) do
    mapping = %{
      "response" => %{
        "venues" => [%Bees.Venue{}]
      }
    }

    Poison.decode!(body, as: mapping)
  end
end
