class StaticPagesController < ApplicationController
	include FlickrHelper

  def home
  	@user_id = nil
  	puts request
  	if request.original_url.include?("Render")
			id_pos = request.original_url.index("id=")
			at_sym_pos = request.original_url.index("%40")
			id_number = request.original_url[id_pos+3..at_sym_pos-1]
			id_address = request.original_url[at_sym_pos+3..at_sym_pos+5]
			@user_id = id_number + "@" + id_address
			flickr = Flickr.new(File.join(::Rails.root, 'config', 'flickr.yml'))
			@photos = flickr.photos.search(:user_id => @user_id).values_at(0..11)
		end
  end
end