require 'json'
require 'open-uri'
require 'httparty'

SLACK_API_TOKEN = ""

path = "api/emoji.list?token=#{SLACK_API_TOKEN}&pretty=1"
emoji_list = HTTParty.get("https://slack.com/#{path}")

Dir.mkdir 'images' unless Dir.exist?('images')

emoji_list["emoji"].each_pair do |name, url|
  puts name
  unless url.include?("alias:")
    download = open(url.delete("\\"))
    IO.copy_stream(download, "images/#{name}.png")
  end
end
