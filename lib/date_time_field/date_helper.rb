module DiMarcello
  module DateTimeField
    module DateHelper
      def self.included(base) #:nodoc:
        ActionView::Helpers::InstanceTag.send :include, InstanceTagMethods
      end
      
      def date_field(object_name, method, options = {}, html_options = {})
        ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_date_field_tag(options)
      end
      
      def time_field(object_name, method, options = {}, html_options = {})
        ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_time_field_tag(options)
      end
      
      def datetime_field(object_name, method, options = {}, html_options = {})
        ActionView::Helpers::InstanceTag.new(object_name, method, self, options.delete(:object)).to_datetime_field_tag(options)
      end
      
      def datetime_field_tag(datetime = Time.current, options = {}, html_options = {})
        DateTimeField.new(datetime, options, html_options).input_datetime
      end
      
      def date_field_tag(date = Date.current, options = {}, html_options = {})
        DateTimeField.new(date, options, html_options).input_date
      end
      
      def time_field_tag(datetime = Time.current, options = {}, html_options = {})
        DateTimeField.new(datetime, options, html_options).input_time
      end
      
      def year_field_tag(date = Date.current, options = {}, html_options = {})
        DateTimeField.new(date, options, html_options).input_year
      end
      
      def month_field_tag(date = Date.current, options = {}, html_options = {})
        DateTimeField.new(date, options, html_options).input_month
      end
      
      def day_field_tag(date = Date.current, options = {}, html_options = {})
        DateTimeField.new(date, options, html_options).input_day
      end
      
      def hour_field_tag(datetime = Time.current, options = {}, html_options = {})
        DateTimeField.new(datetime, options, html_options).input_hour
      end
      
      def minute_field_tag(datetime = Time.current, options = {}, html_options = {})
        DateTimeField.new(datetime, options, html_options).input_minute
      end
      
      def second_field_tag(datetime = Time.current, options = {}, html_options = {})
        DateTimeField.new(datetime, options, html_options).input_second
      end
    end
  end
end