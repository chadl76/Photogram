module PostsHelper

	def display_likes(post)
		votes = post.votes_for.up.by_type(User)
		return list_likers(votes) if votes.size <= 5
		count_likers(votes)
	end

	def list_likers(votes)
		user_names = []
		unless votes.blank?
			votes.voters.each do |voter|
				user_names.push(link_to voter.username, profile_path(voter.username), class: "username")
			end
			user_names.to_sentence.html_safe + like_plural(votes)
		end
	end

	def count_likers(votes)
		vote_count = votes.size
		vote_count.to_s + ' likes'
	end

	def liked_post(post)
		if post.liked_by(current_user)
			return unliked_post(post)
		else
		  return link_to "", like_post_path(post.id), remote: true, class: "glyphicon glyphicon-heart-empty heart-color", :id=> "like_#{post.id}"
		end
	end


	def unliked_post(post)
		return link_to "", unlike_post_path(post.id), remote: true, class: "glyphicon glyphicon-heart", :id=> "like_#{post.id}"
		
	end

	private 

	def like_plural(votes)
		return ' like this' if votes.count > 1
		' likes this'
	end

end
