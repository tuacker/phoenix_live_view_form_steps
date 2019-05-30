defmodule LiveViewForm.Repo do
  use Ecto.Repo,
    otp_app: :live_view_form,
    adapter: Ecto.Adapters.Postgres
end
