class Pin < ActiveRecord::Base
  validates_presence_of :title, :url, :text, :category_id, :image, :slug
  validates_uniqueness_of :slug

  belongs_to :category

 attr_accessor :category_id, :image_content_type, :image_file_name

 has_attached_file :image, styles: { medium: "300x300>", thumb: "75x75>" }, default_url: "http://placebear.com/75/75"

 validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end