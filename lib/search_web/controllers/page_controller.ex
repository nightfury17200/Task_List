defmodule SearchWeb.PageController do
  use SearchWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
