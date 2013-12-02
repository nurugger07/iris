defmodule IrisTest do
  use ExUnit.Case

  import Iris.Router

  test "set root path" do
    assert root("/", :application) == 
      [[method: "GET", path: "/", controller: :application, action: :index]]
  end

  test "set resources paths" do
    assert resources(:user) ==
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
