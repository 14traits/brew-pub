require "csv"

class Brewery
  attr_accessor :brewery_name, :type, :address, :website, :state, :state_breweries

  def initialize(input_options)
    @brewery_name = input_options[:brewery_name] || "John's Pub"
    @type = input_options[:type] || "Brewpub"
    @address = input_options[:address] || "555 Main St, Lake Villa, Illinios, 70063"
    @website = input_options[:website] || "www.nope.com"
    @state = input_options[:state] || "Illinios"
    @state_breweries = input_options[:state_breweries] || 555
  end
end

zip_code = "94710"
index = 0
output = []

puts "Enter a zip code: "
zip_code = gets.chomp.to_s
puts "You entered #{zip_code}, finding pubs by you now..."

#  LOADING CSV FILE
csv_text = File.read("./breweries_us.csv")
csv = CSV.parse(csv_text, headers: true, header_converters: :symbol)
# Fixed ingestion by converting headers to symbols thanks to my man Chris!
csv.each do |row|
  Brewery.new(row)
end

# Find By 100% zip code Match #WINNING
# csv.length.times do
#   if csv[index][:address].include?(zip_code)
#     output << csv[index]
#     index += 1
#   else
#     index += 1
#   end
# end

# going to try to break up the address
csv.length.times do
  test_zip = csv[index][:address].split(//).last(5).to_s
  if csv[index][:address].include?(zip_code)
    output << csv[index]
    index += 1
  else
    index += 1
  end
end

# p csv[index][:address]
pp output
