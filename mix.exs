defmodule Bees.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bees,
      version: "0.0.1",
      description: "Foursquare API client for Elixir",
      elixir: "~> 1.2",
      package: package,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps
    ]
  end

  def package do
    [
      maintainers: ["Daniel Tomlinson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/danieltomlinson/bees" }
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :jsx, :plug, :poison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.8.0"},
      {:jsx, "~> 2.6"},
      {:plug, "~> 1.0"},
      {:poison, "~> 2.0"},
      {:exvcr, "~> 0.7", only: :test}
    ]
  end
end
