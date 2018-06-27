defmodule Recruit2018.SendNotifications do
  use GenServer
  require Logger
  alias Recruit2018.Notify
  alias Recruit2018.Application, as: App

@default_interval_ms 28_800_000 # once every 8 hours

  def start_link() do
    opts = Map.new()
    |> Map.put_new(:interval, Application.get_env(:recruit_2018, :notify_check_interval_ms))
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def init(opts) do
    interval = Map.get(opts, :interval, @default_interval_ms)
    set_timer(self(), opts, :check, interval)
  end
  
  def handle_info(:check, opts) do
    {:ok, opts} = clear_timer(opts)
    Logger.debug("SendNotifications: checking for new notfications to send")
    send_new_notifications()
    interval = Map.get(opts, :interval, @default_interval_ms)
    {:ok, opts} = set_timer(self(), opts, :check, interval)
    {:noreply, opts}
  end
  def handle_info(request, opts) do
    Logger.debug("SendNotifications:Unknown request: #{inspect request}")
    {:noreply, opts}
  end

  defp send_new_notifications() do
    applications = App.get_unnotified_applications()
    if Enum.any?(applications) do
      message = applications
      |> Enum.reduce("<p>The following #{length(applications)} new applications have been added since last check.</p><ul>", fn(a, acc) -> acc <> "<li>#{a.first_name} #{a.last_name} (#{a.email})</li>" end)
      message = message <> "</ul>"
      Notify.new_applications_email(message)
      |> Notify.deliver_now
      applications
      |> Enum.each(fn(a) -> App.set_notified(a) end)
    end
  end

  defp set_timer(process, opts, atom, time) do
    timer = Process.send_after(process, atom, time)
    opts = Map.put_new(opts, :timer, timer)
    {:ok, opts}
  end

  defp clear_timer(opts) do
    {:ok, timer} = Map.fetch(opts, :timer)
    if timer != nil do
      Process.cancel_timer(timer)
    end
    opts = Map.delete(opts, :timer)
    {:ok, opts}
  end
end