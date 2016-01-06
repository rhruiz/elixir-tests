defmodule Composition.TicketChannel do
  use Phoenix.Channel

  def join("tickets:" <> user, auth_msg, socket) do
    {:ok, socket}
  end
end
