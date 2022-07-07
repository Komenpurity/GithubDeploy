defmodule GithubDeployWeb.DeployLiveTest do
  use GithubDeployWeb.ConnCase

  import Phoenix.LiveViewTest
  import GithubDeploy.DeploymentFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  defp create_deploy(_) do
    deploy = deploy_fixture()
    %{deploy: deploy}
  end

  describe "Index" do
    setup [:create_deploy]

    test "lists all deploys", %{conn: conn, deploy: deploy} do
      {:ok, _index_live, html} = live(conn, Routes.deploy_index_path(conn, :index))

      assert html =~ "Listing Deploys"
      assert html =~ deploy.name
    end

    test "saves new deploy", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, Routes.deploy_index_path(conn, :index))

      assert index_live |> element("a", "New Deploy") |> render_click() =~
               "New Deploy"

      assert_patch(index_live, Routes.deploy_index_path(conn, :new))

      assert index_live
             |> form("#deploy-form", deploy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deploy-form", deploy: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deploy_index_path(conn, :index))

      assert html =~ "Deploy created successfully"
      assert html =~ "some name"
    end

    test "updates deploy in listing", %{conn: conn, deploy: deploy} do
      {:ok, index_live, _html} = live(conn, Routes.deploy_index_path(conn, :index))

      assert index_live |> element("#deploy-#{deploy.id} a", "Edit") |> render_click() =~
               "Edit Deploy"

      assert_patch(index_live, Routes.deploy_index_path(conn, :edit, deploy))

      assert index_live
             |> form("#deploy-form", deploy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#deploy-form", deploy: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deploy_index_path(conn, :index))

      assert html =~ "Deploy updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes deploy in listing", %{conn: conn, deploy: deploy} do
      {:ok, index_live, _html} = live(conn, Routes.deploy_index_path(conn, :index))

      assert index_live |> element("#deploy-#{deploy.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#deploy-#{deploy.id}")
    end
  end

  describe "Show" do
    setup [:create_deploy]

    test "displays deploy", %{conn: conn, deploy: deploy} do
      {:ok, _show_live, html} = live(conn, Routes.deploy_show_path(conn, :show, deploy))

      assert html =~ "Show Deploy"
      assert html =~ deploy.name
    end

    test "updates deploy within modal", %{conn: conn, deploy: deploy} do
      {:ok, show_live, _html} = live(conn, Routes.deploy_show_path(conn, :show, deploy))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Deploy"

      assert_patch(show_live, Routes.deploy_show_path(conn, :edit, deploy))

      assert show_live
             |> form("#deploy-form", deploy: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#deploy-form", deploy: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.deploy_show_path(conn, :show, deploy))

      assert html =~ "Deploy updated successfully"
      assert html =~ "some updated name"
    end
  end
end
