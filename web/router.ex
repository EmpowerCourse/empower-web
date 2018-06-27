defmodule Recruit2018.Router do
  use Recruit2018.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Recruit2018 do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/apply", PageController, :apply_request
    post "/apply", PageController, :apply
    get "/info", PageController, :info
    get "/code_of_conduct", PageController, :code_of_conduct
  end

  # scope "/api", Recruit2018 do
  #   pipe_through :api

  # end
end
