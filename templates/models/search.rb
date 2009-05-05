class Query::<%= target_module %>::Search < ActiveRecord::Base

  set_table_name :<%= search_table %>
  
  def execute_search
    
    scope = ::<%= target_model %>.scoped({})
    scope = yield(scope) if block_given?

    <%= target_model.underscore.pluralize %> = scope.find(:all)

    list = Query::<%= target_module %>::List.create
    list.search = self

    <%= target_model.underscore.pluralize %>.each do |<%= target_model.underscore %>|
      entry = Query::<%= target_module %>::Entry.new
      entry.<%= target_model.underscore %> = <%= target_model.underscore %>
      
      list.entries << entry
    end

    list.save
    list
  end
  
end