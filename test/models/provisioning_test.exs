defmodule Composition.ProvisioningTest do
  use Composition.ModelCase

  alias Composition.Provisioning

  @valid_attrs %{key: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Provisioning.changeset(%Provisioning{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Provisioning.changeset(%Provisioning{}, @invalid_attrs)
    refute changeset.valid?
  end
end
