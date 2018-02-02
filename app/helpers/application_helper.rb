module ApplicationHelper
	def profile_avatar_select(user)
		return image_tag user.avatar.url(:medium), id: 'image-preview', class: 'img-responsive img-circle profile-image' if user.avatar.exists?
		image_tag 'default-avatar.png', size: "150", id: 'image-preview', class: 'img-responsive img-circle profile-image'
	end
end
