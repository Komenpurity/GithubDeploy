defmodule GithubDeploy.DeploymentTest do
  use GithubDeploy.DataCase

  alias GithubDeploy.Deployment

  describe "deploys" do
    alias GithubDeploy.Deployment.Deploy

    import GithubDeploy.DeploymentFixtures

    @invalid_attrs %{name: nil}

    test "list_deploys/0 returns all deploys" do
      deploy = deploy_fixture()
      assert Deployment.list_deploys() == [deploy]
    end

    test "get_deploy!/1 returns the deploy with given id" do
      deploy = deploy_fixture()
      assert Deployment.get_deploy!(deploy.id) == deploy
    end

    test "create_deploy/1 with valid data creates a deploy" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Deploy{} = deploy} = Deployment.create_deploy(valid_attrs)
      assert deploy.name == "some name"
    end

    test "create_deploy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Deployment.create_deploy(@invalid_attrs)
    end

    test "update_deploy/2 with valid data updates the deploy" do
      deploy = deploy_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Deploy{} = deploy} = Deployment.update_deploy(deploy, update_attrs)
      assert deploy.name == "some updated name"
    end

    test "update_deploy/2 with invalid data returns error changeset" do
      deploy = deploy_fixture()
      assert {:error, %Ecto.Changeset{}} = Deployment.update_deploy(deploy, @invalid_attrs)
      assert deploy == Deployment.get_deploy!(deploy.id)
    end

    test "delete_deploy/1 deletes the deploy" do
      deploy = deploy_fixture()
      assert {:ok, %Deploy{}} = Deployment.delete_deploy(deploy)
      assert_raise Ecto.NoResultsError, fn -> Deployment.get_deploy!(deploy.id) end
    end

    test "change_deploy/1 returns a deploy changeset" do
      deploy = deploy_fixture()
      assert %Ecto.Changeset{} = Deployment.change_deploy(deploy)
    end
  end
end
