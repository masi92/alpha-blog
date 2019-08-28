module ApplicationHelper
    def gravatar_for(user, options = { size: 150})
        gravatar_id = Digest::MD5::hexdigest(user.to_s)
        size = options[:size]
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, class:"rounded-circle")
    end
end