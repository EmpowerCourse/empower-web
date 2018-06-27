defmodule Recruit2018.Repo.Migrations.AddClassCity do
  use Ecto.Migration

  def change do
    alter table(:application) do
	  add :class_city, :string, null: false, size: 13, default: ""
    end
  end
end
