class Comment < ApplicationRecord 
  validates :content, :author_id, :post_id, presence: true 

  belongs_to :author,
    primary_key: :id, 
    foreign_key: :author_id, 
    class_name: :User 

  belongs_to :post 

  belongs_to :parent_comment, 
    primary_key: :id, 
    foreign_key: :parent_comment_id, 
    class_name: :Comment, 
    optional: true 

  has_many :comments, 
    primary_key: :id, 
    foreign_key: :parent_comment_id, 
    class_name: :Comment, 
    dependent: :destroy

end 