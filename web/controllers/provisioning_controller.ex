defmodule Composition.ProvisioningController do
  use Composition.Web, :controller

  alias Composition.Provisioning

  plug :scrub_params, "provisioning" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    provisionings = Repo.all(Provisioning)
    render(conn, "index.html", provisionings: provisionings)
  end

  def new(conn, _params) do
    changeset = Provisioning.changeset(%Provisioning{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"provisioning" => provisioning_params}) do
    changeset = Provisioning.changeset(%Provisioning{}, provisioning_params)

    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "Provisioning created successfully.")
      |> redirect(to: provisioning_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    provisioning = Repo.get(Provisioning, id)
    render(conn, "show.html", provisioning: provisioning)
  end

  def edit(conn, %{"id" => id}) do
    provisioning = Repo.get(Provisioning, id)
    changeset = Provisioning.changeset(provisioning)
    render(conn, "edit.html", provisioning: provisioning, changeset: changeset)
  end

  def update(conn, %{"id" => id, "provisioning" => provisioning_params}) do
    provisioning = Repo.get(Provisioning, id)
    changeset = Provisioning.changeset(provisioning, provisioning_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "Provisioning updated successfully.")
      |> redirect(to: provisioning_path(conn, :index))
    else
      render(conn, "edit.html", provisioning: provisioning, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    provisioning = Repo.get(Provisioning, id)
    Repo.delete(provisioning)

    conn
    |> put_flash(:info, "Provisioning deleted successfully.")
    |> redirect(to: provisioning_path(conn, :index))
  end
end
