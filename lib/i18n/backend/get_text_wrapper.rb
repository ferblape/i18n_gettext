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
        from_gettext = options.delete(:gettext)
        msgid_plural = options.delete(:msgid_plural)
        default = options.delete(:default)
        begin
          if key !~ /[^\d\w\.\_]/
            return super(locale, key, options)
          end
        rescue I18n::MissingTranslationData => e
          raise e unless from_gettext # Gettext will never fail, which is expected!
        end
        translate_with_gettext(locale, key, msgid_plural, options)
      end
      
      protected

        # The current locale text provided by the i18n rails backend.
        # Used to ensure minimal calls to set_locale.
        attr_accessor :current_wrapper_locale
      
        def translate_with_gettext(locale, key, msgid_plural = nil, options = {})
          init_translations unless initialized?
          # Gettext#set_locale is quite expensive, only set if it is needed
          if self.current_wrapper_locale != locale
            self.current_wrapper_locale = locale
            # Always enforce UTF-8 (thanks to Vít Ondruch for this patch)
            # Aparently can cause codeset errors if not forced
            set_locale(Locale::Object.new(locale.to_s, nil, "UTF-8"))
          end
          if (msgid_plural)
            nsgettext( key.to_s, msgid_plural.to_s, options[:count] )
          else
            gettext( key.to_s )
          end
        end

    end
  end
end
