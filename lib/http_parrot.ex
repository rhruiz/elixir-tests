defmodule HttpParrot do
  alias HTTPoison.Response

  def base, do: "http://httparrot.herokuapp.com"

  def ip do
    case Pact.get("http").get(base <> "/ip") do
      {:ok, %Response{status_code: 200, body: body}} -> body |> Poison.decode! |> Map.get "origin"
      {:ok, _} -> {:error, :unexpected_answer}
      {:fail, a} -> {:fail, a}
    end
  end
end
