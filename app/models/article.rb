class Article < ActiveRecord::Base
  validation :title, presence: true, length: {minimum: 3, maximum: 50}
  validation :description, presence: true, length: {minimum: 3, maximum: 50}
end
