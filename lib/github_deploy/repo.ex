defmodule GithubDeploy.Repo do
  use Ecto.Repo,
    otp_app: :github_deploy,
    adapter: Ecto.Adapters.Postgres
end
