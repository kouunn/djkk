require 'json'
require 'open-uri'
require 'net/http'
class SearchController < ApplicationController
  def download

  	url= params[:search]

  	if url != nil
  	djkk_url = URI.escape(url)
  	doc = Nokogiri::HTML(open(djkk_url))

  	#response=Net::HTTP.get_response(URI(djkk_url))
  	inline_script = doc.xpath('//script[not(@src)]')
  	@download_url=inline_script.first.text.delete( ";" "]" "+")[20..1000].gsub(/title|artist|m4a: s_str/, 'title'=>'"title"', 'artist'=>'"artist"', 'm4a: s_str'=>'"m4a":')
  	@http_str = "http://mx.djkk.com/mix"
  	@title=JSON.parse(@download_url)['title']
  	@artist=JSON.parse(@download_url)['artist']
  	@m4a=@http_str+JSON.parse(@download_url)['m4a']
  	  #JSON.parse(response.body)['trans_result'][0]['dst']
	#@download_url=JSON.parse(@download_url)
  	end
  end
end
