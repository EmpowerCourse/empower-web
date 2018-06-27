defmodule Recruit2018.Repo.Migrations.InitialTables do
  use Ecto.Migration

  def change do
    create table(:application) do
      add :first_name, :string, null: false, size: 25
      add :last_name, :string, null: false, size: 25
      add :email, :string, null: false, size: 150
      add :phone, :string, null: false, size: 25
      add :reason, :string, null: false, size: 3000
      timestamps
    end
  end
end
