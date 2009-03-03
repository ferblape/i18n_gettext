require 'test/unit'
require File.dirname(__FILE__) + '/test_helper'
require File.dirname(__FILE__) + '/../lib/i18n_gettext'

# Foo class for testing
class Foo; include I18nGetText end

class I18nGettextTest <  ActiveSupport::TestCase

  test 'sgettext should return the same as default' do
    assert_equal 'wadus', Foo.sgettext('wadus')
  end
  
  test 'sgettext should call I18n.translate' do
    I18n.expects(:translate).returns('other wadus').once
    assert_equal 'other wadus', Foo.sgettext('wadus')
  end
  
  test 'sgettext should return the right index of the string given a separator' do
    assert_equal 'after', Foo.sgettext('before&after', '&')    
  end
  
  test 's_ is an alias' do
    assert_equal 'wadus', Foo.s_('wadus')
    assert_equal 'after', Foo.s_('before&after', '&')    
  end
  
  test 'gettext should call sgettext without separator' do
    Foo.expects(:sgettext).with('wadus', nil).returns('wadus').once
    assert_equal 'wadus', Foo.gettext('wadus')
  end
  
  test '_ is an alias ' do
    Foo.expects(:sgettext).with('wadus', nil).returns('wadus').once
    assert_equal 'wadus', Foo._('wadus')    
  end
  
  test 'nsgettext should call I18n.translate' do
    I18n.expects(:translate).returns('singular wadus').once
    assert_equal 'singular wadus', Foo.nsgettext('singular wadus', 'plural wadus', 1)
  end

  test 'nsgettext should return singular if n=1' do
    assert_equal 'singular wadus', Foo.nsgettext('singular wadus', 'plural wadus', 1)
  end

  test 'nsgettext should return plural if n == 0' do
    assert_equal 'plural wadus', Foo.nsgettext('singular wadus', 'plural wadus', 0)
  end

  test 'nsgettext should return plural if n > 1' do
    assert_equal 'plural wadus', Foo.nsgettext('singular wadus', 'plural wadus', 2)
  end
  
  test 'nsgettext should accept the parameter structure: nsgettext(msgid, msgid_plural, n, div = "|")' do
    assert_equal 'plural wadus', Foo.nsgettext('singular wadus', 'plural wadus', 2)
  end

  test 'nsgettext should accept the parameter structure: nsgettext(msgids, n, div = "|"), where msgids = [msgid, msgid_plural]' do
    assert_equal 'plural wadus', Foo.nsgettext(['singular wadus', 'plural wadus'], 2)
  end
  
  test 'n_ is an alias from nsgettext' do
    assert_equal Foo.nsgettext(['singular wadus', 'plural wadus'], 2), Foo.n_(['singular wadus', 'plural wadus'], 2)
  end
  
  test 'N_ should return the param' do
    assert_equal 'wadus', Foo.N_('wadus')
  end
  
  test 'Nn_ should return the param' do
    assert_equal 'wadus', Foo.Nn_('wadus', 'plural wadus')
  end

end
