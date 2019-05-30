defmodule LiveViewFormWeb.ExampleLive do
  use Phoenix.LiveView
  alias LiveViewFormWeb.Router.Helpers, as: Routes

  def render(assigns) do
    LiveViewFormWeb.ExampleView.render("form.html", assigns)
  end

  def mount(_session, socket) do
    {:ok, assign(socket, :changeset, LiveViewForm.change_example(%{}))}
  end

  def handle_event("validate", %{"example" => params}, socket) do
    changeset = LiveViewForm.change_example(params) |> Map.put(:action, :insert)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"example" => params}, socket) do
    # Pretending to insert stuff if changeset is valid
    changeset = LiveViewForm.change_example(params)

    case changeset.valid? do
      true ->
        {:stop,
         socket
         |> put_flash(:info, "Example inserted")
         |> redirect(to: Routes.live_path(LiveViewFormWeb.Endpoint, LiveViewFormWeb.ExampleLive))}

      false ->
        {:noreply, assign(socket, :changeset, %{changeset | action: :insert})}
    end
  end
end
