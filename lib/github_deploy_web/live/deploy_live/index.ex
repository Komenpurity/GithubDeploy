defmodule GithubDeployWeb.DeployLive.Index do
  use GithubDeployWeb, :live_view

  alias GithubDeploy.Deployment
  alias GithubDeploy.Deployment.Deploy

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :deploys, list_deploys())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Deploy")
    |> assign(:deploy, Deployment.get_deploy!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Deploy")
    |> assign(:deploy, %Deploy{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Deploys")
    |> assign(:deploy, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    deploy = Deployment.get_deploy!(id)
    {:ok, _} = Deployment.delete_deploy(deploy)

    {:noreply, assign(socket, :deploys, list_deploys())}
  end

  defp list_deploys do
    Deployment.list_deploys()
  end
end
