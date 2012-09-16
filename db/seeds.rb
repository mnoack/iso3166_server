# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Required Debian/Ubuntu Package iso-codes
#/usr/share/xml/iso-codes/iso_3166.xml 
#/usr/share/xml/iso-codes/iso_3166_2.xml

require 'active_record'
require 'country'
require 'subdivision'
require 'net/http' # to download iso codes if needed
require 'nokogiri' # to parse isocodes
require 'activerecord-import' # to bulk import all data
require 'activerecord-import/base'

ISO_GIT_BASE     = "http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;"
ISO_3166_URL     = ISO_GIT_BASE + "f=iso_3166/iso_3166.xml;hb=HEAD"
ISO_3166_2_URL   = ISO_GIT_BASE + "f=iso_3166_2/iso_3166_2.xml;hb=HEAD"

def load_countries
  path = get_iso_code('iso_3166.xml', ISO_3166_URL)
  doc = Nokogiri::XML(File.read(path))
  countries = doc.xpath('//iso_3166_entry').map do |element|
    [element[:alpha_2_code], element[:name]]
  end
  print "importing..."
  Country.import [:code, :name], countries
end

def load_subdivisions
  path = get_iso_code('iso_3166_2.xml', ISO_3166_2_URL)
  doc = Nokogiri::XML(File.read(path))
  subdivisions = doc.xpath('//iso_3166_2_entry').map do |element|
    [element[:code], element[:name], element[:code][0..1]]
  end
  print "importing..."
  Subdivision.import [:code, :name, :country_code], subdivisions
end

def get_iso_code(filename, url)
  path = "/usr/share/xml/iso-codes/#{filename}"
  unless File.exists?(path)
    path = "#{File.dirname(__FILE__)}/#{filename}"
    unless File.exists?(path)
      content = Net::HTTP.get(URI(url))
      File.open(path, 'w+', :encoding => 'ASCII-8BIT') {|f| f.write(content)}
    end
  end
  path
end

def load_helper(klass)
  print "#{klass} import"
  klass.delete_all
  yield
  puts "Loaded #{klass.count} entries"
end

load_helper(Country)     { load_countries }
load_helper(Subdivision) { load_subdivisions }
