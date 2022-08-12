defmodule Testing do
  alias Search.Tasks.Task
  alias Search.Repo

  def run_event do
    start_time = System.monotonic_time()
    Repo.all(Task)
    |> emit_event(start_time)
  end

  def run_event_check do
    start_time = System.monotonic_time()

    Repo.transaction(
      fn ->
        Task
        |> Repo.stream(max_rows: 100)
        |> call_event(start_time)
      end,
      timeout: :infinity
    )
  end

  defp call_event(arg, start_time) do
    arg
    |> Enum.to_list()
    |> emit_event(start_time)
  end

  def emit_event(list, start_time) do
    stop_time = System.monotonic_time()
    IO.inspect(list)
    counts = list |> Enum.count()
    :telemetry.execute(
      [:search, :task_list, :stop],
      %{time: stop_time, duration: stop_time - start_time},
      %{count: counts}
    )
  end
end

# Testing.run_event_check
