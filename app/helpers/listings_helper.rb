module ListingsHelper
  def thumbnail_url(listing)
    case listing.type
    when 'GaijinPotListing'
      old_size = listing.image_url.split('-').last
      url_without_size = listing.image_url.split(old_size).last
      new_size = '100x100.png'
      "#{url_without_size}#{new_size}"
    end
  end
end