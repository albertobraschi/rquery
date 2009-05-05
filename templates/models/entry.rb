class Query::<%= target_module %>::Entry < ActiveRecord::Base
  
  set_table_name :<%= entry_table %>
  
  belongs_to :list, :class_name => "Query::<%= target_module %>::List"
  belongs_to :<%= target_model.underscore %>, :class_name => "::<%= target_model %>"
end