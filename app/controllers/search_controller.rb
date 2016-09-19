require 'json'
require 'open-uri'
require 'net/http'
class SearchController < ApplicationController
  def download

  	url= params[:search]

  	if url != nil
  		begin
	  	djkk_url = URI.escape(url)
	  	doc = Nokogiri::HTML(open(djkk_url))
	  	#response=Net::HTTP.get_response(URI(djkk_url))
	  	inline_script = doc.xpath('//script[not(@src)]')
	  	@download_url=inline_script.first.text.delete( ";" "]" "+")[20..1000].gsub(/title|artist|m4a: s_str/, 'title'=>'"title"', 'artist'=>'"artist"', 'm4a: s_str'=>'"m4a":')
	  	@http_str = "http://mx.djkk.com/mix"
	  	@title=JSON.parse(@download_url)['title']
	  	@artist=JSON.parse(@download_url)['artist']
	  	@m4a=@http_str+JSON.parse(@download_url)['m4a']

 
	  	rescue Exception => e #如果上面的代码执行发生异常就捕获  
	  	    
	  	   flash.now[:notice] = "请输入正确的地址！"
	  	end  
  
  	end
  end
end
