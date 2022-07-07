defmodule GithubDeployWeb.DeployLive.FormComponent do
  use GithubDeployWeb, :live_component

  alias GithubDeploy.Deployment

  @impl true
  def update(%{deploy: deploy} = assigns, socket) do
    changeset = Deployment.change_deploy(deploy)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"deploy" => deploy_params}, socket) do
    changeset =
      socket.assigns.deploy
      |> Deployment.change_deploy(deploy_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"deploy" => deploy_params}, socket) do
    save_deploy(socket, socket.assigns.action, deploy_params)
  end

  defp save_deploy(socket, :edit, deploy_params) do
    case Deployment.update_deploy(socket.assigns.deploy, deploy_params) do
      {:ok, _deploy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deploy updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_deploy(socket, :new, deploy_params) do
    case Deployment.create_deploy(deploy_params) do
      {:ok, _deploy} ->
        {:noreply,
         socket
         |> put_flash(:info, "Deploy created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
