defmodule Recruit2018.Repo.Migrations.AddNotifiedAt do
  use Ecto.Migration

  def change do
    alter table(:application) do
	  add :notified_at, :utc_datetime
    end
  end
end
