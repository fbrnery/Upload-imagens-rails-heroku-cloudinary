class Post < ApplicationRecord
    has_one_attached :avatar
    has_rich_text :content
end
