module I18nGetText
    
  module Methods
  
    def sgettext(msgid, div = '|')
      text = I18n.translate msgid, :default => msgid
      if div
        if i = text.rindex(div)
          text = text[(i+1)..-1]
        end
      end
      text
    end
  
    alias :s_ :sgettext
  
    def gettext(msgid)
      sgettext(msgid, nil)
    end
  
    alias :_ :gettext
  
    # call-seq:
    #   nsgettext(msgid, msgid_plural, n, div = "|")
    #   nsgettext(msgids, n, div = "|")  # msgids = [msgid, msgid_plural]
    #   n_(msgid, msgid_plural, n, div = "|")
    #   n_(msgids, n, div = "|")  # msgids = [msgid, msgid_plural]
    #
    # The nsgettext is similar to the ngettext.
    # But if there is no localized text, 
    # it returns the last part of msgid separeted by +div+.
    #
    # * msgid: the singular form with "div". (e.g. "Special|An apple")
    # * msgid_plural: the plural form. (e.g. "%{num} Apples")
    # * n: a number used to determine the plural form.
    # * Returns: the localized text which key is +msgid_plural+ if +n+ is plural(follow plural-rule) or +msgid+.
    #   "plural-rule" is defined in po-file.
    def nsgettext(arg1, arg2, arg3 = '|', arg4 = '|')
      if arg1.kind_of?(Array)
        msgid, msgid_plural = arg1[0], arg1[1]
        n = arg2
        if arg3 and arg3.kind_of?(Numeric)
          raise ArgumentError, "3rd parameter is wrong: value = %{n}" % { :n => arg3 }
        end
        div = arg3
      else
        msgid = arg1
        msgid_plural = arg2
        n = arg3
        div = arg4
      end
    
      default_text = (n == 1) ? msgid : msgid_plural
      I18n.translate msgid, :count => n, :default => default_text, :msgid_plural => msgid_plural
    end
  
    alias :n_ :nsgettext
  
    def N_(msgid)
      msgid
    end
  
    def Nn_(msgid, msgid_plural)
      msgid
    end
    
  end
  
  def self.included(mod)
    mod.extend(Methods)
  end
  
  include Methods
  
end
