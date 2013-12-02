defmodule Iris.Mixfile do
  use Mix.Project

  def project do
    [ app: :iris,
      version: "0.0.1-dev",
      elixir: "~> 0.11.2-dev",
      name: "Iris",
      source_url: "https://github.com/nurugger07/iris",
      deps: deps(Mix.env) ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { Iris, [] }]
  end

  defp deps(:prod) do
    [
      { :cowboy,  github: "extend/cowboy", optional: true }
    ]
  end

  defp deps(_) do
    deps(:prod) ++
      [ { :hackney, github: "benoitc/hackney" } ]
  end
end
