require File.dirname(__FILE__) + '/../test_helper'

class SassFilterExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'sass_filter'), SassFilterExtension.root
    assert_equal 'Sass Filter', SassFilterExtension.extension_name
  end
  
end
