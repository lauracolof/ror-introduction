class ArticlesController < ApplicationController

  before_action :find_article, except: [:new, :create, :index]
  # only sirve para decir en cuáles acciones actuará before action. También existe "except: []"

  def index 
    @articles = Article.all
  end
    
  def new
    # Diferencia con @ y sin: en Rails, una variable, sólo se puede acceder dentro del método mismo. Y @variable puede acceder desde la vista que está mandando a llamar a la acción.
    @article = Article.new
    #@article.title = 'Demo' #esto le da texto al input
  end

  # guardamos lo que hayamos recibido del form new.
  def create
    # a create le debemos pasar un hash donde le indigamos que cree un articulo con un titulo, creará un nuevo registro en la db en la tabla Article con la columna "title". 
    # Podemos obtener el dato en el controllador utilizando params: 
    @article = Article.create(title: params[:article][:title], content: params[:article][:content] )
    #recibimos el parámetro que viene desde el control delform y crea el primer articulo. podemos guardarlo en una variable y la mostramos en json
    render json: @article
    # obtenemos un json con id, title, status, create...
  end

  def show
    # @article = Article.find(params[:id]) #:id acá es un simbolo
  end

  def edit
    # @article = Article.find(params[:id])
  end

  def update 
    # @article = Article.find(params[:id])
    @article.update(title: params[:article][:title], content: params[:article][:content] )
    # update acá es un método del obj @article
  end

  def destroy 
    # @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path #ruta inicial.
  end

  def find_article 
    @article = Article.find(params[:id]) #gracias a este método find_article, nos ahorramos todas las lineas en las que se utilizaba arriba.
  end

end
