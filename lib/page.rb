require 'nokogiri'
require 'open-uri'
require 'rubygems'

def data_mining

  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))
  symbole_noko = page.xpath('//td[@class="text-left col-symbol"]')
  price_noko = page.xpath('//a[@class="price"]')

  symbol_array = []
  price_array = []

  symbole_noko.each do |symbol_filter|
    symbol_array << symbol_filter.text
  end

  price_noko.each do |price_filter|
    price_array << price_filter.text
  end
  price_array_without_dollar = []
  #enlever le $
  price_array.each{|x| price_array_without_dollar << (x.delete '($)').to_f}
  #Hash
  a = Hash[symbol_array.zip(price_array_without_dollar)]
  return a
end

def get_townhall_email
  page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
  url_array = []
  mail_adress = []
#url
  url = page.xpath('//a[@class = "lientxt"]/@href')
  url.each do |url_filter|
    url_array << url_filter.text
  end
  #ville
  ville_array = []
  ville = page.xpath('//a[@class = "lientxt"]')
  ville.each do |ville_filter|
    ville_array << ville_filter.text
  end

  #filtre des adresses emails
  url_array.each do |get_mail|
    page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/#{get_mail}"))
    mail = page.xpath('//tbody/tr[4]/td[2]')
    mail_array = mail.grep(/@/)
    mail_array.each do |mail_filter|
      mail_adress << mail_filter.text
    end
  end

  a = Hash[ville_array.zip(mail_adress)]
  return a
end
puts get_townhall_email
