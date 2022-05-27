defmodule Search.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Search.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        completed: true,
        description: "some description"
      })
      |> Search.Tasks.create_task()

    task
  end
end
