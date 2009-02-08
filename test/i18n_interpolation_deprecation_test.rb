require 'test/unit'
require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/i18n_gettext'
# We need ActiveRecord to test the alias_method_chain definided in it is broken
require 'active_record'
require File.dirname(__FILE__) + '/../lib/i18n_interpolation_deprecation'

# Foo class for testing
class Foo; include I18nGetText end

class I18nInterpolationDeprecationTest <  ActiveSupport::TestCase
  
  test 'a GetText call should not call interpolate_with_deprecated_syntax' do
    I18n::Backend::Simple.expects(:interpolate_with_deprecation_syntax).never
    assert_equal 'wadus', Foo.sgettext('wadus')
  end
  
end
