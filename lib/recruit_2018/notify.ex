defmodule Recruit2018.Notify do
  require Logger
  import Bamboo.Email
  use Bamboo.Phoenix, view: Recruit2018.EmailView
  use Bamboo.Mailer, otp_app: :recruit_2018

  def system_email do
    new_email()
    |> from(Application.get_env(:recruit_2018, :system_email))
  end

  def new_applications_email(message) do
    assigns = [message: message]

    system_email()
    |> to(get_recipients())
    |> system_name_subject("New Applications Received")
#    |> render_text_view("default.text", assigns)
    |> render_html_view("default.html", assigns)
  end

  # def email_confirmation_email(user, url) do
  #   app_name = get_app_name()
  #   assigns = [user: user, url: url, app_name: get_app_name()]
  #   system_email()
  #   |> to(user.email)
  #   |> system_name_subject("Account Confirmation")
  #   |> render_text_view("email_confirmation.text", assigns)
  #   |> render_html_view("email_confirmation.html", assigns)
  # end

  # def email_is_valid?(email) do
  #   Regex.match?(~r/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b/i, email)
  # end

  defp get_recipients() do
    users = [%{name: "Ali", email: "ali@sightsource.net"}, 
      %{name: "Harper", email: "harper@sightsource.net"},
      %{name: "Balint", email: "balint@sightsource.net"}
    ]
    for user <- users do
      {user.name, user.email}
    end
  end

  defp get_app_name(), do: Application.get_env(:recruit_2018, :app_name)

  defp system_name_subject(email, email_subject) do
    email
    |> subject("#{get_app_name()}: #{email_subject}")
  end

  defp render_text_view(email, text_view, assigns) do
    email
    |> put_text_layout({Recruit2018.LayoutView, "email.text"})
    |> render(text_view, assigns)
  end

  defp render_html_view(email, html_view, assigns) do
    email
    |> put_html_layout({Recruit2018.LayoutView, "email.html"})
    |> render(html_view, assigns)
  end
end