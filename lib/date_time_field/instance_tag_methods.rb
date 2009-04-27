module DiMarcello
  module DateTimeField
    module InstanceTagMethods
      
      def to_date_field_tag(options = {}, html_options = {})
        datetime_field(options, html_options).input_date
      end
      
      def to_time_field_tag(options = {}, html_options = {})
        datetime_field(options, html_options).input_time
      end
      
      def to_datetime_field_tag(options = {}, html_options = {})
        datetime_field(options, html_options).input_datetime
      end

      private
      
        def datetime_field(options, html_options)
          datetime = value(object) || default_datetime(options)

          options = options.dup
          options[:field_name]           = @method_name
          options[:include_position]     = true
          options[:prefix]             ||= @object_name
          options[:index]                = @auto_index if @auto_index && !options.has_key?(:index)
          options[:datetime_separator] ||= '&mdash;'
          options[:time_separator]     ||= ':'

          DateTimeField.new(datetime, options, html_options)
        end
    end
  end
end