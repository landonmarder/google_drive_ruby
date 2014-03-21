require "rubygems"
require "google_drive"
require 'json'
require 'pry'

password = File.open(".secret", "r").read
password.gsub!("\n", '')

session = GoogleDrive.login("landon.marder@gmail.com", password)

rows = session.spreadsheet_by_key('0AornRwZY3X2FdDdpRUhnMG1wMWJOdEtGTGZDbmNTYkE').worksheets[0].rows
companies = Hash.new({})

rows.each do |row|
  companies["#{row[0]}"] = { name: row[0], url: row[1], category: row[2] }
end

# Delete the header
companies.delete("Company")

File.open('data/spreadsheet.json', 'w') { |f| f << companies.to_json }
