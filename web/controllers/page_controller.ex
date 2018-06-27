defmodule Recruit2018.PageController do
  use Recruit2018.Web, :controller
  alias Recruit2018.{Repo, Application}

  def index(conn, _params) do
    render conn, "index.html"
  end

  def apply_request(conn, _params) do
    render conn, "closed.html"
  	# render conn, "apply.html"
  end

  def info(conn, _params) do
    render conn, "info.html"
  end

  def code_of_conduct(conn, _params) do
    render conn, "code_of_conduct.html"
  end

  def apply(conn, params) do
    params = Map.put(params, "email", if(is_nil(params["email"]) or params["email"] == "", do: "N/A", else: params["email"]))
    |> Map.put("phone", if(is_nil(params["phone"]) or params["phone"] == "", do: "N/A", else: params["phone"]))
    %Application{}
    |> Application.changeset(params)
    |> Repo.insert
    |> case do
      {:ok, _item} ->
        render conn, "confirmation.html"
      {:error, _changeset} ->
        render conn, "failure.html"
    end
  end
end
