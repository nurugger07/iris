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

end
