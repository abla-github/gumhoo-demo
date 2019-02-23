module UsersHelper
  
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_url = user.avatar_url(options[:size])
    image_tag(gravatar_url, alt: user.name, class: "img-circle")
  end
end
