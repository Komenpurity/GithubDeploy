defmodule GithubDeploy.Deployment.Deploy do
  use Ecto.Schema
  import Ecto.Changeset

  schema "deploys" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(deploy, attrs) do
    deploy
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
