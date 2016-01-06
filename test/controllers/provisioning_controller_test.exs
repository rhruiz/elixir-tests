defmodule Composition.ProvisioningControllerTest do
  use Composition.ConnCase

  alias Composition.Provisioning
  @valid_attrs %{key: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, provisioning_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing provisionings"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, provisioning_path(conn, :new)
    assert html_response(conn, 200) =~ "New provisioning"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, provisioning_path(conn, :create), provisioning: @valid_attrs
    assert redirected_to(conn) == provisioning_path(conn, :index)
    assert Repo.get_by(Provisioning, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, provisioning_path(conn, :create), provisioning: @invalid_attrs
    assert html_response(conn, 200) =~ "New provisioning"
  end

  test "shows chosen resource", %{conn: conn} do
    provisioning = Repo.insert %Provisioning{}
    conn = get conn, provisioning_path(conn, :show, provisioning)
    assert html_response(conn, 200) =~ "Show provisioning"
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    provisioning = Repo.insert %Provisioning{}
    conn = get conn, provisioning_path(conn, :edit, provisioning)
    assert html_response(conn, 200) =~ "Edit provisioning"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    provisioning = Repo.insert %Provisioning{}
    conn = put conn, provisioning_path(conn, :update, provisioning), provisioning: @valid_attrs
    assert redirected_to(conn) == provisioning_path(conn, :index)
    assert Repo.get_by(Provisioning, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    provisioning = Repo.insert %Provisioning{}
    conn = put conn, provisioning_path(conn, :update, provisioning), provisioning: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit provisioning"
  end

  test "deletes chosen resource", %{conn: conn} do
    provisioning = Repo.insert %Provisioning{}
    conn = delete conn, provisioning_path(conn, :delete, provisioning)
    assert redirected_to(conn) == provisioning_path(conn, :index)
    refute Repo.get(Provisioning, provisioning.id)
  end
end
