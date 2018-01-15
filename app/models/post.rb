class Post < ApplicationRecord
	paginates_per 3
	validates :image, presence: true
	#validates :user_id, presence: true
	has_attached_file :image, styles: { :medium => "640x"}
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	has_attached_file :avatar, styles: {:medium => "152x152#"}
	validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
	belongs_to :user
	has_many :comments
end
