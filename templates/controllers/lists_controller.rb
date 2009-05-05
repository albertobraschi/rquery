class Query::<%= target_module %>::ListsController < ApplicationController
  def show
    @list = Query::<%= target_module %>::List.find(params[:id])
  end
end
