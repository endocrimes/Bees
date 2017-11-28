defmodule Bees.Mixfile do
  use Mix.Project

  def project do
    [
      app: :bees,
      version: "0.3.0",
      description: "Foursquare API client for Elixir",
      elixir: "~> 1.2",
      package: package(),
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  def package do
    [
      maintainers: ["Danielle Tomlinson"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/dantoml/bees" }
    ]
  end

  def application do
    [applications: [:logger, :httpoison, :jsx, :plug, :poison]]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:jsx, "~> 2.6"},
      {:plug, "~> 1.0"},
      {:poison, "~> 3.0"},
      {:exvcr, "~> 0.8", only: :test},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end
end
