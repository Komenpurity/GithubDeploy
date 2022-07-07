defmodule GithubDeployWeb.PageController do
  use GithubDeployWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
