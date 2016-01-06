defmodule Composition.Router do
  use Composition.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  socket "/ticket_socket", Composition do
    channel "tickets:*", TicketChannel
    channel "announcements", AnnouncementChannel
  end

  scope "/", Composition do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/provisionings", ProvisioningController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Composition do
  #   pipe_through :api
  # end
end
