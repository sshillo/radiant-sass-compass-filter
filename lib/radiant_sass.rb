module RadiantSass
  include Sass
  Engine.class_eval do
      def import(files)
        nodes = []

        files.split(/,\s*/).each do |filename|
          engine = nil


          if filename =~ /\.css$/
            nodes << Tree::DirectiveNode.new("@import url(#{filename})", @options[:style])
          else

            new_options = @options.dup
            new_options[:filename] = filename
            out = ""
            page = Page.find_by_url(filename)
            raise SyntaxError.new("Invalid File or Not Found", @line) if page.class_name == "FileNotFoundPage" || page.nil?
            page.parts.each do |part|
              out+= part.content
            end
   
            engine = Sass::Engine.new(out, @options)


            engine.constants.merge! @constants
            engine.mixins.merge! @mixins

            begin
              root = engine.render_to_tree
            rescue Sass::SyntaxError => err
              err.add_backtrace_entry(filename)
              raise err
            end
            root.children.each do |child|
              child.filename = filename
              nodes << child
            end
            @constants = engine.constants
            @mixins = engine.mixins
          end
        end

        nodes
      end
  end
  
end