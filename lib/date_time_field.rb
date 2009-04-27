# DateTimeField
module DiMarcello
  module DateTimeField
    autoload :DateHelper, File.join(File.dirname(__FILE__), 'date_time_field', 'date_helper')
    autoload :DateTimeField, File.join(File.dirname(__FILE__), 'date_time_field', 'date_time_field')
    autoload :InstanceTagMethods, File.join(File.dirname(__FILE__), 'date_time_field', 'instance_tag_methods')
    
    ActionView::Helpers::InstanceTag.send :include, InstanceTagMethods
    ActionView::Base.send :include, DateHelper
  end
end