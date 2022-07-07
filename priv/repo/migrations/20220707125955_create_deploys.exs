defmodule GithubDeploy.Repo.Migrations.CreateDeploys do
  use Ecto.Migration

  def change do
    create table(:deploys) do
      add :name, :string

      timestamps()
    end
  end
end
