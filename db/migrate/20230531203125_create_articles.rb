# código ruby válido, que especifica los cambios que debemos hacer a la db para guardar info. La estructura está definiendo que tenemos una tabla, llamada articles, con un title: string y una status:integer y los timestamps que indican modificación y creación.

class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.integer :status

      t.timestamps
    end
  end
end
