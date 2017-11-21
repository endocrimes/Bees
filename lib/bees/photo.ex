defmodule Bees.Photo do
  @derive Poison.Encoder

  defstruct id: nil, createdAt: nil, source: nil, prefix: nil, suffix: nil,
    width: nil, height: nil, user: nil, checkin: nil, visibility: nil

  def from_venue(client, id, limit \\ 100, offset \\ 0) do
    params = [
      limit: limit,
      offset: offset,
      v: "20160301"
    ]

    case Bees.Client.get(client, "/venues/#{id}/photos", params, false) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        response = decode_many(body)
        {:ok, response["response"]["photos"]}
      {:error, error} ->
        {:error, error}
    end
  end

  # Private Helpers

  defp decode_many(body) do
    mapping = %{
      "response" => %{
        "photos" => %{
          "items" => [decoder()]
        }
      }
    }

    Poison.decode!(body, as: mapping)
  end

  defp decoder() do
    %Bees.Photo{}
  end
end
