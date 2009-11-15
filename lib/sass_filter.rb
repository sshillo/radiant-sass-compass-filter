require 'sass'

class SassFilter < TextFilter
  description_file File.dirname(__FILE__) + "/../sass.html"
  def filter(text)
    out = text
    unless caller[2].match(/snippet/).to_s  == "snippet" #don't render for snippet, or it will be rendered twice
      begin
        out = Sass::Engine.new(text).render
      rescue Sass::SyntaxError
        out = "Syntax Error at line #{$!.sass_line}: " + $!.to_s
      end
    end
    out
  end
end