class HomeController < ApplicationController

  # antes de cada acción manda a llamar al método authenticate_user, si hay usuario deja pasar la acción y se muestra la vista, sino, redirecciona hacia la auth. y "obliga" a iniciar sesión o registrarse, si solo los usuarios que iniciaron sesion pueden crear, validar, o crear, etc, se puede utilizar el only.
  before_action :authenticate_user, only: [:new, :create, :update, :destroy]
  def index
  end
end
