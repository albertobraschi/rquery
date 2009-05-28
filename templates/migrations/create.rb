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
    
    
    sql = <<-SQL
      create view <%= entry_table %>_view as select
        s.id as search_id,
        e.*
      from
        <%= entry_table %> e
      left join
        <%= list_table %> l
      on
        l.id = e.list_id
      left join
        <%= search_table %> s
      on
        s.id = l.search_id
    SQL
    
    ActiveRecord::Base.connection.execute(sql)
 
  end
 
  def self.down
    ActiveRecord::Base.connection.execute("drop view <%= entry_table %>_view")
    
    drop_table :<%= entry_table %>
    drop_table :<%= list_table %>
    drop_table :<%= search_table %>
  end
  
end