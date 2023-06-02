class Category < ApplicationRecord
  has_many :has_categories
  has_many :article, through :has_categories
end
