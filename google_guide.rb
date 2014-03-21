require "rubygems"
require "google_drive"
require 'json'
require 'pry'

# Password is located ina .secret file
password = File.open(".secret", "r").read
password.gsub!("\n", '')

# Authenticate with Google
session = GoogleDrive.login("landon.marder@gmail.com", password)

# Get the spreadsheet you want
rows = session.spreadsheet_by_key('0AornRwZY3X2FdDdpRUhnMG1wMWJOdEtGTGZDbmNTYkE').worksheets[0].rows
companies = Hash.new({})

# Convert spreadsheet to hash
rows.each do |row|
  companies["#{row[0]}"] = { name: row[0], url: row[1], category: row[2] }
end

# Delete the header
companies.delete("Company")

# Write hash into the file as json
File.open('data/companies.json', 'w') { |f| f << companies.to_json }

# How to access the json file in middleman
# <% data.companies.keys.each do |company| %>
#   <%= data.companies[company][:name]%>
# <% end %>
