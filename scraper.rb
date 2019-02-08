require 'open-uri'
require 'nokogiri'

# url = Nokogiri::HTML(open('http://wiadomosci.gazeta.pl/wiadomosci/7,114884,24436784,po-chce-ustanowic-dziewieciodniowe-swieto-upamietnialoby-40.html'))
url = Nokogiri::HTML(open('https://plejada.pl/zdjecia-gwiazd/big-brother-janusz-dzieciol-przeszedl-metamorfoze-galeria/82tx8r0'))
# url = Nokogiri::HTML(open('https://pl.wikipedia.org/wiki/Ulica_Bednarska_w_%C5%81odzi'))

skroty = [/ul\./, /pl\./, /godz\./, /prof\./, /os\./, /gen\./, /m\.in\./, /hab\./, /itd\./, /itp\./, /n\.e\./, /p\.n\.e\./, /zob\./, /por\./, /c\.o\./, /br\./, /zob\./, /por\./, /sp z o\. o\./, /etc\./, /al\./, /m\./, /l\./, /zm\./, /zam\./, /szt\./, /r\./, /red\./, /inż\./, /w\./, /im\./, /[A-Z]\./];
skroty_reg = Regexp.union(skroty);


page = []


url.search('p').each do |tag|
    tag = tag.content.split(/(?<=([!?.]))/)
    tag.each_with_index do |str, i|
        if(str.match(skroty_reg))
            page.push((str + tag.to_a[i+2]).gsub(/\s+/, ' ').gsub(/^ /, ""))
        elsif(/^(\s*)[A-Z](.*)[\.\?\!]+(\s*)$/ =~ str && str.split(" ").length > 3)
            page.push(str.gsub(/\s+/, ' ').gsub(/^ /, ""))
        end
    end
end


puts page


File.open("page.txt", "w+") do |f|
    f.puts(page)
  end