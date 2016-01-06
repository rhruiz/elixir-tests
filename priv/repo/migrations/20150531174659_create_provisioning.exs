defmodule Composition.Repo.Migrations.CreateProvisioning do
  use Ecto.Migration

  def change do
    create table(:provisionings) do
      add :key, :string
      add :name, :string

      timestamps
    end

  end
end
