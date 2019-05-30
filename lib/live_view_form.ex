defmodule LiveViewForm do
  @moduledoc """
  LiveViewForm keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  alias LiveViewForm.Example

  def change_example(%Example{} = example \\ %Example{}, attrs) do
    Example.changeset(example, attrs)
  end
end
