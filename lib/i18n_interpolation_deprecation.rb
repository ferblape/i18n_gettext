module I18n
  module Backend
    class Simple

      protected
        # Alias for break the alias_method_chain of the deprecated syntax, 
        # that breaks the compatibility with GetText
        alias :interpolate :interpolate_without_deprecated_syntax
    end
  end
end