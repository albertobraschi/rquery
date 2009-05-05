class Query::<%= target_module %>::EntriesController < ApplicationController
  def show
    @entry = Query::<%= target_module %>::Entry.find(params[:id])
  end
end