defmodule GithubDeploy.Deployment do
  @moduledoc """
  The Deployment context.
  """

  import Ecto.Query, warn: false
  alias GithubDeploy.Repo

  alias GithubDeploy.Deployment.Deploy

  @doc """
  Returns the list of deploys.

  ## Examples

      iex> list_deploys()
      [%Deploy{}, ...]

  """
  def list_deploys do
    Repo.all(Deploy)
  end

  @doc """
  Gets a single deploy.

  Raises `Ecto.NoResultsError` if the Deploy does not exist.

  ## Examples

      iex> get_deploy!(123)
      %Deploy{}

      iex> get_deploy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_deploy!(id), do: Repo.get!(Deploy, id)

  @doc """
  Creates a deploy.

  ## Examples

      iex> create_deploy(%{field: value})
      {:ok, %Deploy{}}

      iex> create_deploy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_deploy(attrs \\ %{}) do
    %Deploy{}
    |> Deploy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a deploy.

  ## Examples

      iex> update_deploy(deploy, %{field: new_value})
      {:ok, %Deploy{}}

      iex> update_deploy(deploy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_deploy(%Deploy{} = deploy, attrs) do
    deploy
    |> Deploy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a deploy.

  ## Examples

      iex> delete_deploy(deploy)
      {:ok, %Deploy{}}

      iex> delete_deploy(deploy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_deploy(%Deploy{} = deploy) do
    Repo.delete(deploy)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking deploy changes.

  ## Examples

      iex> change_deploy(deploy)
      %Ecto.Changeset{data: %Deploy{}}

  """
  def change_deploy(%Deploy{} = deploy, attrs \\ %{}) do
    Deploy.changeset(deploy, attrs)
  end
end
