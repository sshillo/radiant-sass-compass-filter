require 'sass'

class SassFilter < TextFilter
  description_file File.dirname(__FILE__) + "/../sass.html"
  def filter(text)
    Sass::Engine.new(text).render
  end
end