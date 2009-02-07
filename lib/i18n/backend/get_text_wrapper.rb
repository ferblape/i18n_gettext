module I18n
  module Backend
    class GetTextWrapper < Simple
      
      include GetText

      def default_domain=(name)
        @default_gettext_domain = name
      end

      def init_translations
        @default_gettext_domain ||= "application"
        bindtextdomain @default_gettext_domain, :path => File.join(RAILS_ROOT, 'locale')
        super
      end

      def translate(locale, key, options = {})
        msgid_plural = options.delete(:msgid_plural)
        default = options.delete(:default)
        begin
          if key !~ /[^\d\w\.\_]/
            return super(locale, key, options)
          end
        rescue I18n::MissingTranslationData
        end
        translate_with_gettext(locale, key, msgid_plural, options)
      end
      
      protected
      
        def translate_with_gettext(locale, key, msgid_plural = nil, options = {})
          init_translations unless initialized?
          set_locale(locale)
          if (msgid_plural)
            nsgettext( key.to_s, msgid_plural.to_s, options[:count] )
          else
            gettext( key.to_s )
          end
        end

    end
  end
end