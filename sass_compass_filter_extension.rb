# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SassCompassFilterExtension < Radiant::Extension
  version ".1"
  description "Allows you to create sass with error checking"
  url "http://coding.seanshillo.com"
 
  def activate
    SassCompassFilter
    admin.page.edit.add :part_controls, "sass_error"
    PagePart.class_eval do
       validate :filter_validation
       def filter_validation
         if filter_id == "Sass Compass"    
           begin
             Sass::Engine.new(content).render
           rescue Sass::SyntaxError
             errors.add(:content_sass, "Syntax Error at line #{$!.sass_line}: " + $!.to_s)
           end
         end
       end
    end
  end
  
end