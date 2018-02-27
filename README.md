# Bees

Bees is an Elixir client library for the Foursquare/Swarm API.

## Features

Bees currently supports:

  1. Finding venues by lat/long `Bees.Venue.search/6`
  2. Finding venues by identifier `Bees.Venue.find_by_identifier/2`
  3. Finding venues by recommendations `Bees.Venue.explore/8`
  4. Finding venues by category `Bees.Venue.category/7`
  5. Checking into a venue `Bees.Checkin.with_venue/4`

Adding endpoints should be relatively simple, and I'm open to pull requests.

## Installation

The package can be installed as:

  1. Add bees to your list of dependencies in `mix.exs`:

        def deps do
          [{:bees, "~> 0.3.0"}]
        end

  2. Ensure bees is started before your application:

        def application do
          [applications: [:bees]]
        end

## Usage

```elixir
client = %Bees.Client{
  client_id: "CLIENT_ID_HERE",
  client_secret: "CLIENT_SECRET_HERE",
  access_token: "ACCESS_TOKEN_FOR_CHECKIN"
}

case Bees.Venue.find_by_identifier(client, "501fea4de4b05e0d96afc368") do
  {:ok, venue} ->
    IO.inspect venue
  {:error, error} ->
    IO.inspect error
end
```

