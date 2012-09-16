# encoding: UTF-8

ActiveRecord::Schema.define(:version => 1) do

  create_table "countries", :id => false, :force => true do |t|
    t.string "code", :limit => 2
    t.string "name"
  end

  add_index "countries", ["code"], :name => "index_countries_on_code"
  add_index "countries", ["name"], :name => "index_countries_on_name"

  create_table "subdivisions", :id => false, :force => true do |t|
    t.string "code",         :limit => 6
    t.string "name"
    t.string "country_code", :limit => 2
  end

  add_index "subdivisions", ["country_code", "code"], :name => "index_subdivisions_on_country_code_and_code"
  add_index "subdivisions", ["name"], :name => "index_subdivisions_on_name"

end
