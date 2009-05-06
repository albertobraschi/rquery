class RqueryGenerator < Rails::Generator::NamedBase
  
  def manifest
 
    record do |m|
      
      m.directory "app/controllers/query/#{target_module.underscore}"
      m.directory "app/models/query/#{target_module.underscore}"
      m.directory "app/views/query/#{target_module.underscore}"
 
      m.template "controllers/searches_controller.rb",  "app/controllers/query/#{target_module.underscore}/searches_controller.rb"
      m.template "controllers/lists_controller.rb",     "app/controllers/query/#{target_module.underscore}/lists_controller.rb"
      m.template "controllers/entries_controller.rb",   "app/controllers/query/#{target_module.underscore}/entries_controller.rb"

      m.template "models/search.rb",          "app/models/query/#{target_module.underscore}/search.rb"
      m.template "models/list.rb",            "app/models/query/#{target_module.underscore}/list.rb"
      m.template "models/entry.rb",           "app/models/query/#{target_module.underscore}/entry.rb"
      
      
      m.migration_template "migrations/create.rb", "db/migrate", {
        :migration_file_name => "create_#{target_module.underscore}"
      }
      

      m.directory "app/views/query/#{target_module.underscore}/searches"
      m.directory "app/views/query/#{target_module.underscore}/lists"
      m.directory "app/views/query/#{target_module.underscore}/entries"
       
      m.template "views/searches/new.html.erb",     "app/views/query/#{target_module.underscore}/searches/new.html.erb"
      m.template "views/lists/show.html.erb",       "app/views/query/#{target_module.underscore}/lists/show.html.erb"
      m.template "views/entries/show.html.erb",     "app/views/query/#{target_module.underscore}/entries/show.html.erb"
      

      sentinel = 'ActionController::Routing::Routes.draw do |map|'
      
      resources = <<-EOS
        map.namespace :query do |n|
          n.namespace :#{target_module.underscore} do |n2|
            n2.resources :searches
            n2.resources :lists
            n2.resources :entries
          end
        end
      EOS


      path = "./config/routes.rb"
      content = File.read(path)

      unless content.match(/(#{Regexp.escape("n.namespace :#{target_module.underscore} do |n2|")})/)
        content = File.read(path).gsub(/(#{Regexp.escape(sentinel)})/mi) do |match|
          "#{match}\n  #{resources}\n"
        end
        File.open(path, 'wb') { |file| file.write(content) }
      end

      
    end
    
  end
  
  def target_model
    args[0].classify
  end
  
  def target_module
    class_name
  end
  
  def search_columns
    colums = args.clone
    colums.shift
    
    colums.collect do |it|
      token = it.split(/:/)
      {:name => token[0], :type => token[1]}
    end
  end
  
  def search_table
    "query_#{target_module.underscore}_searches"
  end
  
  def list_table
    "query_#{target_module.underscore}_lists"
  end
  
  def entry_table
    "query_#{target_module.underscore}_entries"
  end
  
  
  
end