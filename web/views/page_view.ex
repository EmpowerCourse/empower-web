defmodule Recruit2018.PageView do
  use Recruit2018.Web, :view

  def render("success.json", %{message: message}) do
    %{
      Success: true,
      Message: message
    }
  end
end
