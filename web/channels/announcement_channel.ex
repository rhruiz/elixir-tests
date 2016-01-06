defmodule Composition.AnnouncementChannel do
  use Phoenix.Channel

  def join("announcements", _auth_msg, socket) do
    {:ok, socket}
  end
end
