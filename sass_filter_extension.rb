# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SassFilterExtension < Radiant::Extension
  version "1.0"
  description "Allows you to create DRY CSS in Radiant using Hampton Catlin's wonderful Sass library."
  url "http://haml.hamptoncatlin.com"
 
  def activate
    SassFilter
  end
  
end