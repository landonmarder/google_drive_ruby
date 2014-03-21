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

companies = Array.new

rows[1..-1].each do |row|
  companies << { name: row[0], url: row[1], category: row[2] }
end


# Write array into the file as json
File.open('data/companies.json', 'w') { |f| f << companies.to_json }

# How to access the json file in middleman
# <% data.companies.each do |company| %>
#    <%= company[:name]%>
# <% end %>
