# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SassCompassFilterExtension < Radiant::Extension
  version ".1"
  description "Allows you to create sass with error checking"
  url "http://coding.seanshillo.com"
  define_routes do |map|
    map.namespace :admin, :member => { :remove => :get } do |admin|
      admin.resources :sass_libraries
    end
  end
  def activate
    SassFilter
    #add errors and validation
    admin.page.edit.add :part_controls, "sass_error"
    admin.snippet.edit.add :form, "snippet_sass_error", :after => "edit_content"
    filter_v_code = <<-code
      validate :filter_validation
      def filter_validation 
        if filter_id == "Sass"    
          begin
            RadiantSass::Engine.new(content).render
          rescue RadiantSass::SyntaxError
            errors.add(:content_sass, "Syntax Error at line \#{$!.sass_line}:"  + $!.to_s)
          end
        end
      end
    code
    PagePart.class_eval <<-code
      #{filter_v_code}
    code
    Snippet.class_eval <<-code
      #{filter_v_code}
    code
  end
end