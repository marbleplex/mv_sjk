#!/usr/bin/env ruby
# coding : utf-8
#
# http://www.google.co.jp/movies?near=%E6%96%B0%E5%AE%BF 
%w(hpricot open-uri).each{|m| require m}
uri = 'http://www.google.co.jp/movies?near=%E6%96%B0%E5%AE%BF'
opt = {"User-Agent" => 'Mozilla/4.0 (compatible; MSIE 7.0; Windows NT 6.0)'}
doc = Hpricot(open(uri, opt).read)
movie_results = (doc/'div.movie_results')[0]
(movie_results/'div.theater').each do |t|
  puts '## ' + (t/'h2 a')[0].inner_html + ' ##'
  (t/'div.showtimes div.movie').each do |m|
    title = (m/'div.name a').inner_html
    time  = (m/'span.info').inner_html[/\d+分/]
    puts "* #{title} - #{time}"
    puts '  ' + (m/'div.times').inner_html.scan(/\d{1,2}:\d{1,2}/).join(',')
  end
end
