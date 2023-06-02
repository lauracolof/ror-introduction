# CREAR RUTAS:

Todos los paths los definimos en /app/config/routes.rb => "/profile"
Los recursos como get, post, etc, son seguidos por "to:" que dan respuesta a este recurso => get "/welcome", to: "home#index"
Rails cuenta con generadores: rails generate controller Home index => esto además genera más cosas, como controllers, views, test, stylesheets/scss, etc.
Levantamos con rails server

# INTEGRAR BOOTSTAP

Lo integramos con yarn add bootstrap: además de actualizarlo, sumarlo al package.json y agregar su node.module.
En **app/javascript/application.js**, lo importamos con require o con import 'bootstrap'. Creamos una carpeta en **app/javascript/styles.scss**. y lo importamos: **@import '~bootstrap/scss/bootstrap'**; y luego importamos el archivo a styles.scss

Buscar qué es webpack codigofacilito yt

# MODULOS Y MIGRACIONES

Dentro de la carpeta db, debemos tener un archivo que se llame development.sqlite3, podemos usar otra como postgres, mariaDb, mongo, etc. Rails provee el active records para no tener que escribir código sql, y solo debemos sustituir la base de datos manteniendo los métodos y clases. Y lo hacemos a través de los models.

- Podemos crearlo manualmente o generarlo con el generador: **generate model Article title:string status:integer**. Nomnbre de la columna en mayúsculas y titulo_de_props:tipo.
- Las migraciones se ocupan de modificar la estructura de la DB, las tablas, las columnas, las relaciones... y el model se encarga de modificar los datos, insertar, modificar, eliminar, etc, pero no la estructura.
- Una migración es sólo una descripción de un cambio que se ejecutará en la db. El comando para ejecutarlo es **rails db:migrate**
- En article, se generará un código nuevo en development.sqlite3 con un código. y rails lleva un control dentro de la db con un registro de lo que genera para no ejecutarlo 2 veces al mismo.
- Si nos equivocamos en la tabla, podemos ejecutar el comando **rails db:rollback** y deshará última migración que haya ejecutado.
- Con el método change, podemos ejecutar, destruirla o revertirla. Si usamos rollback, debemos volver a migrarla con db:migrate.
- En el archivo schema.rb podemos ver qué tablas tenemos, como se ven, etc, cada vez que se modifica una tabla se modifica el archivo tmb.

Para un a un modelo, debemos pasar por un controller, lo ideal sería crear un controller por tabla.
Los controllers relacionados a un modelo, van en Plural y en mayuscula y podemos generalos con el comando **rails generate controller Articles**

Debemos crear una nueva vista en la carpeta que se genera vacía, y podemos generarla utilizando los helpers o métodos de ayuda de la vista de RoR y nos permiten construir HTML.

# TEXTO ENRIQUECIDO CON ActionText

Es una forma de guardar texto enriquecido, que se puede modificar. Provee de dos cosas: editor de texto (trix), un control de la web para modificarlo y por otro lado un lugar donde guardarlo. Lo instalamos con **rails action_text:install** y se preconfigura. Genera una serie de migraciones y debemos migrarlas con **rails db:migrate**, porque es en estas migraciones donde se almacenará el texto enriquecido. Luego de hacerlo debemos hacer 2 cosas:

- indicarle al modelo /models/article.rb que tiene un texto enriquecido **has_rich_text** y darle un identificador :(body, content, etc).
- También debemos colocar el control de ActionText, el editor, podemos hacerlo con la etiqueta **form.rich_content** en el new.html.erb

# BEFORE_ACTION & AFTER_ACTION

Métodos que se mandan a llamar al nivel de la clase, y normalment ese colocan al inicio del controlador
**Before action**: . Nos permite ejecutar un método antes de que se pase a la acción de un controlador, lo que va después de before action es el nombre del método que se va a ejecutar, puede ser string, pero normalmente se define como :simbolo.
_before_action :find_article_. Se debe definir ese método, y cada vez que alguien entre a a cualquiera de las acciones de articles, se ejecutará el método.
Uno de los usos es evitar la repetición de código, por ejemplo, en un CRUD, evitar buscar constantemente un :id para realizar tareas como get, patch, delete, etc

**After action**: Inverso a before_action. Se utiliza menos, se ejecuta después de que los métodos se hayan ejecutado, se puede por ej, sobreescribir algo.

# PARTIALS:

Son archivos que van a la vista, que por si solos no pueden ser desplegados, deben colocarse en una vista completa. Van dentro de las vistas completas, no puedo mostrar un parcial dentro de un controlador concretamente. Sirve para reciclar código duplicado. Se identifican por comenzar por un \_ en el nombre del archivo.

# USERS AUTHENTICATION - Devise

Devise es la herramienta que la mayoria usa para autenthicación. Es una gema que se instala en el Gemfile:

- Agregar " gem 'devise' " a Gemfile
- bundle install,
- **rails generate devise:install**: lo que ejecuta instalaciones y nos recomienda hacer configuraciones como en nuestro mailer, tener una ruta mensajes, etc.
- **rails generate devise User**
- **rails migrate:db**
- genera automaticamente: "/users/sign_up"

# WORK WITH ACTUAL SESSION:

Cómo podemos saber si hay un user iniciado? Hay un método agregado por devise para saber si hay un user logueado, _user_signed_in?_ devuelve true or false.
Una opción de una opción para tomar los datos del usuario es en index.html.erb:

El método **authenticate_user** logra que antes de cada acción manda a llamar al método, si hay usuario deja pasar la acción y se muestra la vista, sino, redirecciona hacia la auth. y "obliga" a iniciar sesión o registrarse, si solo los usuarios que iniciaron sesion pueden crear, validar, o crear, etc, se puede utilizar con only, para determinar tareas sólo logueado.

En **VIEWS** generar las vistas de devise con **rails generate devise:views** y se generan con archivos html.

# RELATION 1:M

Relación usuarios - artículos: En otros frameworks tiene que configuarse y ser explícita, en ROR no hay convención, sino que un campo que hace referencia a otra tabla, tiene que llamarse el recurso del model, user*id, debe apuntar a articles_id, que identifica de manera única a los registros de cada tabla.
Todas las modificaciones a la estructura de la DB se hacen a través de migraciones, colocando un nombre a la migración: "add_user_id_to_articles", se utilizan * y al final el nombre de la tabla a modificar, espacio, el campo a agregar como _user_id_ y el tipo de dato, como int. pero cuando hablamos de referencias lo mejor es usar el tipo references, "user:references", queremos una referencia hacia user **rails generate migration add_user_id_to_articles user:references**. Todo esto agrega las referencias, indica que el campo no puede ser null y una foreign_key, que por defecto asume que no puedes crear un article sin un user, se puede modificar. Una vez hecho esto, debemos migrar los cambios **rails db:migrate**. si la DB ya tiene creados los campos puede dar error y podemos poner default:1

# Configure relation of models.

Nos ofrece nuevos métodos entre la relación (articulos, usuarios). En la parte que es uno, que sería article. Va en donde va el campo adicional, :user_id. Por convención, nombre del otro modelo con minúsculas y singular :user. Y en el caso de has_many :articles.

CONSOLA INTERACTIVA RAILS:

> rails console
> Article.last
> (0.7ms) SELECT sqlite*version(*)
> Article Load (0.2ms) SELECT "articles".\_ FROM "articles" ORDER BY "articles"."id" DESC LIMIT ? [["LIMIT", 1]]  
> => #<Article id: 3, title: "Type here..", status: nil, created_at: "2023-05-31 23:01:34", updated_at: "2023-05-31 23:01:34", user_id: 1
> User.find(1)
> User Load (0.7ms) SELECT "users".\* FROM "users" WHERE "users"."id" = ? LIMIT ?

# SAVE ARTICLE'S AUTHOR

una opción es en la creación del articulo articles_controller.erb: pero así guardaríamos guardar dos veces el artículo, instanciarlo en la prop y después guardarlo en la db.

```
def create
  @article = Article.create(
    title: params[:article][:title],
    content: params[:article][:content]
  )
  @article.user = current_user
  @article.save
end
```

otra opción: al momento de crear el articulo, es decirle cuál usuario lo está creando, current_user se encarga (es el que tiene sesión iniciada)

```
def create
  @article = Article.create(
    title: params[:article][:title],
    content: params[:article][:content],
    user: current_user
  )
end
```

ultima alternativa y mejor: la asigna rails por si mismo.

```
def create
  @article = current_user.articles.create(
    title: params[:article][:title],
    content: params[:article][:content],
    user: current_user
  )
end
```

# DISPLAY OBJECTS OF ASSOCIATIONS

Acá no se usa current_user, sino @user, porque es la variable que mandamos desde el controller. Sólo queremos buscar un usuario según el id, y no por el que esté iniciado. Siempre que a render le pasemos una colección, va a buscar el mismo parcial, no improta si lo buscamos a traves del modelo, lo pasamos como asociación, etc.

# STRONG PARAMS / GOOD PRACTICES

Los parámetros fuertes son una respuesta casi de defensa a un posible ataque de seguridad, por ejemplo, que en formularios hayan acciones maliciosas. Se pueden evitar por ejemplo, que alguien se de permisos de admin, manualmente editando el html de la consola.
Rails introduce los strongs params en que la convención define el nombre del modelo en minúsculas_params. Y sobre esta parámetro que retorna un hash, definimos cuáles atributos están permitidos. Si se intenta enviar alguno que no esté permitido, rails lo ignora. Cuando entran cosas que no van dentro de los params, retorna "Unpermitted parameter: :{parametro}"

```
  def article_params
    params.require(:article).permit(:title, :content)
  end
```
