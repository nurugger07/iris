defmodule Iris.Router do

  @doc """
  routes do
    root "/", :application

    resources :user

    resources :post do
      resource :comment, only: [:index, :new, :create]
    end
  end
  """
  defmacro routes(code) do
    quote do
      unquote(code)
    end
  end

  def root(path, controller//:application, action//:index) do
    [[method: "GET", path: path, controller: controller, action: action]]
  end

  def resources(resource) do
    [
      [method: "GET", path: "/users", controller: :user, action: :index],
      [method: "GET", path: "/user/:id", controller: :user, action: :show],
      [method: "GET", path: "/user/new", controller: :user, action: :new],
      [method: "GET", path: "/user/:id/edit", controller: :user, action: :edit],
      [method: "POST", path: "/user", controller: :user, action: :create],
      [method: "PUT", path: "/user", controller: :user, action: :update],
      [method: "DELETE", path: "/user/:id", controller: :user, action: :destroy],
    ]
  end

  def get(path, [controller]) do
    [controller, action] = parse_controller(controller)
    get(path, [controller: controller, action: action])
  end

  def get(path, [{_, controller}, {_, action}]) do
    controller = convert_to_atom(controller)
    action = convert_to_atom(action)
    build_route(:get, path, controller, action)
  end

  def post(path, [controller]) do
    [controller, action] = parse_controller(controller)
    post(path, [controller: controller, action: action])
  end

  def post(path, [{_, controller}, {_, action}]) do
    controller = convert_to_atom(controller)
    action = convert_to_atom(action)
    build_route(:post, path, controller, action)
  end

  defp build_route(method, path, controller, action) when is_atom(method) do
    atom_to_binary(method) |> String.upcase |> build_route(path, controller, action)
  end
  defp build_route(method, path, controller, action) when is_binary(method) do
    [[method: method, path: path, controller: controller, action: action]]
  end

  defp parse_controller({_, controller}) do
    cond do
      String.contains?(controller, "#") -> String.split(controller, "#")
      true -> controller
    end
  end

  defp convert_to_atom(val) when is_atom(val), do: val
  defp convert_to_atom(val) do
    :unicode.characters_to_binary(val) |> binary_to_atom
  end
end
