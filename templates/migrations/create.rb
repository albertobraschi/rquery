class Create<%= target_module %> < ActiveRecord::Migration
 
  def self.up
 
    create_table :<%= search_table %> do |t|
      t.timestamps
      
      <% search_columns.each do |c| %>
        t.<%= c[:type] %> :<%= c[:name] %>
      <% end %>
      
    end

    create_table :<%= list_table %> do |t|
      t.integer :search_id
      t.timestamps
    end
 
    create_table :<%= entry_table %> do |t|
      t.integer :list_id
      t.integer :<%= target_model.underscore %>_id
      t.timestamps
    end
 
  end
 
  def self.down
    drop_table :<%= entry_table %>
    drop_table :<%= list_table %>
    drop_table :<%= search_table %>
  end
  
end