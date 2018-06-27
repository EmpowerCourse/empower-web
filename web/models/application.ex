defmodule Recruit2018.Application do
  use Recruit2018.Web, :model
  import Ecto.Query
  alias Recruit2018.Repo

  schema "application" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    field :phone, :string
    field :reason, :string
    field :class_city, :string
    field :notified_at, Ecto.DateTime

    timestamps
  end

  @available_fields ~w(first_name last_name email phone reason class_city)

  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @available_fields)
  end

  def get_unnotified_applications() do
    (from a in Recruit2018.Application,
     where: is_nil(a.notified_at),
     select: a)
    |> Repo.all
  end

  def set_notified(model) do
    model
    |> Ecto.Changeset.change()
    |> set_notified_changeset()
    |> Repo.update!()
  end

  defp set_notified_changeset(changeset) do
    changeset
    |> put_change(:notified_at, Ecto.DateTime.from_erl(:erlang.universaltime()))
  end
end
