defmodule GithubDeploy.DeploymentFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GithubDeploy.Deployment` context.
  """

  @doc """
  Generate a deploy.
  """
  def deploy_fixture(attrs \\ %{}) do
    {:ok, deploy} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> GithubDeploy.Deployment.create_deploy()

    deploy
  end
end
