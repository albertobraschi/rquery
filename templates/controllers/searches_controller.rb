class Query::<%= target_module %>::SearchesController < ApplicationController
  def new
    @search = Query::<%= target_module %>::Search.new
  end

  def create
    @search = Query::<%= target_module %>::Search.new(params[:<%= "query_#{target_module.underscore}_search" %>])

    if @search.save
      result_list = @search.execute_search do |scope|
        
        <% search_columns.each do |c| %>
          scope = scope.scoped(:conditions => [" <%= c[:name] %> = ? ", @search.<%= c[:name] %>]) unless @search.<%= c[:name] %>.blank?
        <% end %>
        
        scope = scope.scoped(:limit => 10)
        
      end
      redirect_to result_list
    else
      render :action => "new"
    end
  end
end
