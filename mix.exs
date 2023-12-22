defmodule AdventOfCode.Mix do
  use Mix.Project

  def project do
    [
      #    ↓ feel free to change it to the appropriate year
      app: :aoc2023,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :dev,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
