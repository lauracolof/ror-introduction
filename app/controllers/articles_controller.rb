class ArticlesController < ApplicationController
  # generamos el método new y muestra un form para crear el articulo
  def new
    # Diferencia con @ y sin: en Rails, una variable, sólo se puede acceder dentro del método mismo. Y @variable puede acceder desde la vista que está mandando a llamar a la acción.
    @article = Article.new
    @article.title = 'Type here..' #esto le da texto al input
  end
# guardamos lo que hayamos recibido del form new.
  def create
    # a create le debemos pasar un hash donde le indigamos que cree un articulo con un titulo, creará un nuevo registro en la db en la tabla Article con la columna "title". 
    # Podemos obtener el dato en el controllador utilizando params: 
    @article = Article.create(title: params[:article][:title] )
    #recibimos el parámetro que viene desde el control delform y crea el primer articulo. podemos guardarlo en una variable y la mostramos en json
    render json: @article
    # obtenemos un json con id, title, status, create...
  end
end
