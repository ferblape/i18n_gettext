require 'i18n_gettext'
require 'i18n_interpolation_deprecation'
require 'i18n/backend/get_text_wrapper'

ActiveRecord::Base.class_eval do
  include I18nGetText
end

ActionController::Base.class_eval do
  include I18nGetText
end

ActionView::Base.class_eval do
  include I18nGetText
end

ActionMailer::Base.class_eval do
  include I18nGetText
end
