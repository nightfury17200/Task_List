defmodule Search.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Search.Tasks.Task

  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:description, :completed])
    |> validate_required([:description, :completed])
  end


  def search(params) do
    completed_flag = Map.get(params, "completed")
    search_text = Map.get(params, "query")
    case {search_text, completed_flag} do
      {nil,nil} -> Task
      {x,_y} when x == "" ->
        from task in Task, where: task.completed == ^completed_flag
      _ ->
        from task in Task, where: ilike(task.description, ^search_text) and task.completed == ^completed_flag
    end
  end


end
