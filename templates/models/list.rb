class Query::<%= target_module %>::List < ActiveRecord::Base
  
  set_table_name :<%= list_table %>
  
  belongs_to :search, :class_name => "Query::<%= target_module %>::Search"
  has_many :entries, :class_name => "Query::<%= target_module %>::Entry"
end