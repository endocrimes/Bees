defmodule Bees.User do
  @derive Poison.Encoder

  defstruct id: nil, firstName: nil, lastName: nil, gender: nil, canonicalUrl: nil

  @type t :: %__MODULE__{
    id: String.t,
    firstName: String.t,
    lastName: String.t,
    gender: String.t,
    canonicalUrl: String.t
  }

  @spec details(Bees.Client.t, String.t) :: tuple
  def details(client, user_id \\ "self") do
    params = [
      v: "20160301"
    ]

    case Bees.Client.get(client, "/users/#{user_id}", params, true) do
      {:ok, %HTTPoison.Response{body: body}} ->
        user = decode(body)
        { :ok, user["response"]["user"] }
      {:error, error} -> {:error, error}
    end
  end

  # Private Helpers

  defp decode(body) do
    mapping = %{
      "response" => %{
        "user" => %Bees.User{ }
      }
    }

    Poison.decode!(body, as: mapping)
  end
end
