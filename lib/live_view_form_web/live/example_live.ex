defmodule LiveViewFormWeb.ExampleLive do
  use Phoenix.LiveView
  alias LiveViewFormWeb.Router.Helpers, as: Routes

  def render(assigns) do
    LiveViewFormWeb.ExampleView.render("form.html", assigns)
  end

  def mount(_session, socket) do
    socket =
      socket
      |> assign(:current_step, 1)
      |> assign(:changeset, LiveViewForm.change_example(%{}))

    {:ok, socket}
  end

  def handle_event("prev-step", _value, socket) do
    new_step = max(socket.assigns.current_step - 1, 1)
    {:noreply, assign(socket, :current_step, new_step)}
  end

  def handle_event("next-step", _value, socket) do
    current_step = socket.assigns.current_step
    changeset = socket.assigns.changeset

    step_invalid =
      case current_step do
        1 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:title, :description] end)
        2 -> Enum.any?(Keyword.keys(changeset.errors), fn k -> k in [:type] end)
        _ -> true
      end

    new_step = if step_invalid, do: current_step, else: current_step + 1

    {:noreply, assign(socket, :current_step, new_step)}
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
         |> put_flash(:info, "Example inserted => #{inspect(changeset.changes)}")
         |> redirect(to: Routes.live_path(LiveViewFormWeb.Endpoint, LiveViewFormWeb.ExampleLive))}

      false ->
        {:noreply, assign(socket, :changeset, %{changeset | action: :insert})}
    end
  end
end
