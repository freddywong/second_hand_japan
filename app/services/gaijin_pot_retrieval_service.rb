require 'open-uri'

class GaijinPotRetrievalService
  DOMAIN_URL = 'https://classifieds.gaijinpot.com'
  SUBDIRECTORY_URL = '/index/index/page/'

  def initialize
    @page_number = 1
    @page_url = page_url(@page_number)
  end

  def call
    while listings_exist?
      listing_urls.each do |url|
        page = listing_page(url)
        listing = GaijinPotListing.find_or_initialize_by(listing_id: url.split('/')[-1])
        listing.update_attributes(
          url: url,
          title: title(page),
          description: description(page),
          date_posted: date_posted(page),
          image_url: image_url(page),
          tags: tags(page)
        )
      end
      next_page
    end
  end

  private

  def page_url(page_number)
    Nokogiri::HTML(
      open(
        "#{DOMAIN_URL}#{SUBDIRECTORY_URL}#{page_number}", 
        :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read
      )
  end

  def listings_exist?
    @page_url.css('div.maincolumn h1').text.blank?
  end

  def listing_urls
    @page_url.css('div#page h2 a').inject([]) do |urls, link|
      urls << "#{DOMAIN_URL}#{link['href']}"
    end
  end

  def listing_page(url)
    Nokogiri::HTML(open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
  end

  def title(page)
    page.css('div.productlist div.detail h2').text
  end

  def description(page)
    page.css('div.productlist p').first.text
  end

  def date_posted(page)
    page.css('p.dateline').text
  end

  def image_url(page)
    image_url = page.css('div.productlist div.thumb a').first.attributes['href'].value
    "#{DOMAIN_URL}#{image_url}"
  end

  def tags(page)
    page.css('p.tags a').inject([]) do |tags, link|
      tags << link.text
    end    
  end

  def next_page
    @page_number += 1
    @page_url = page_url(@page_number)
  end
end