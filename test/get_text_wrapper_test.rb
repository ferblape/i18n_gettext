require 'test/unit'
require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/i18n_gettext'
require File.dirname(__FILE__) + '/../lib/i18n/backend/get_text_wrapper'

# Foo class for testing
class Foo; include I18nGetText end

class GetTextWrapperTest <  ActiveSupport::TestCase
  
  setup do
    @backend = I18n::Backend::GetTextWrapper.new
  end
  
  test 'backend can change domain' do
  end
  
end
