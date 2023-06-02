class Article < ApplicationRecord
  has_rich_text :content
  belongs_to :user
  has_many :has_categories
  # has_many :categories, through :has_categories
  attr_accessor :category_elements

  #Tabla asociativa
  def save_categories 
    #convertirlo a arr, iterarlo, y crear un registor a la tabla
    return if category_elements.nil? || category_elements.empty? 

    #guarda los elems que no coincidan
    has_categories.where.not(category_id: category_elements).destroy_all


    category_elements.each do |category_id|
      HasCategory.find_or_create_by(article: self, category_id: category_id)
    end
  end

end
