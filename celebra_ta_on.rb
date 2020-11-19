require 'open-uri'
require 'nokogiri'
require 'pry-byebug'
require_relative '.env'

# https://sms.comtele.com.br/
require 'comtele_sdk'
include ComteleSdk

zaps_dos_brodi = %w[ 21988541230 ]

running = true
while running
	url = "https://www.tibia.com/community/?subtopic=worlds"

	html_file = open(url).read
	html_doc = Nokogiri::HTML(html_file)

	celebra_selector = 'div.TableContentAndRightShadow tr:nth-child(11) > td:nth-child(2)'

	celebra_ta = html_doc.search(celebra_selector).text

	if celebra_ta.empty?
		puts "Tibia tá down"
	elsif celebra_ta.downcase == 'off'
		puts "Celebra tá " + celebra_ta
	elsif celebra_ta.downcase == '0'
		puts "Celebra tá on, mas inacessível"
	else
		running = false 
		textmessage_service = TextMessageService.new(API_KEY);
		textmessage_service.send('Dedé Is Home', 'Celebra tá on, papai!', zaps_dos_brodi);
	end
	sleep 60
end





