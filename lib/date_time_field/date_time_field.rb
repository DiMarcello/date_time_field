module DiMarcello
  module DateTimeField
    #TODO leading zeros for year
    class DateTimeField #:nodoc:
      extend ActiveSupport::Memoizable
      include ActionView::Helpers::TagHelper
      
      DEFAULT_PREFIX = 'date'.freeze unless const_defined?('DEFAULT_PREFIX')
      DEFAULT_SEPARATORS = {
        :date_separator => "/", :time_separator => ":", :datetime_separator => " "
      }.freeze
      POSITION = {
        :date => 1, :time => 2, :year => 1, :month => 2, :day => 3, :hour => 4, :minute => 5, :second => 6
      }.freeze unless const_defined?('POSITION')
      TITLE = {
        :year => "YYYY", :month => "MM", :day => "DD", :hour => "hh", :minute => "mm", :second => "ss"
      }
      
      def initialize(datetime, options = {}, html_options = {})
        @options      = options.dup
        @html_options = html_options.dup
        @datetime     = datetime
      end

      def input_time
        order = time_order.dup - [:year, :month, :day]

        [:second, :minute, :hour].each { |o| order.unshift(o) unless order.include?(o) }
        @options[:discard_second] ||= true unless @options[:include_seconds]
        
        unless @options[:ignore_date]
          @options[:discard_month]    = true
          @options[:discard_year]     = true
          @options[:discard_day]      = true

          order = [:year, :month, :day] + order
        end

        if @options[:single]
          build_input_from_types(order, :time)
        else
          build_inputs_from_types(order)
        end
      end

      def input_date
        order = date_order.dup
        order -= [:hour, :minute, :second]
        
        unless @options[:single]
          @options[:discard_year]   ||= true unless order.include?(:year)
          @options[:discard_month]  ||= true unless order.include?(:month)
          @options[:discard_day]    ||= true unless order.include?(:day)
        end
        [:day, :month, :year].each { |o| order.unshift(o) unless order.include?(o) }
        
        if @options[:include_time]
          @options[:discard_hour]     = true
          @options[:discard_minute]   = true
          @options[:discard_second]   = true
          order += [:hour, :minute, :second]
        end

        # If the day is hidden and the month is visible, the day should be set to the 1st so all month choices are
        # valid (otherwise it could be 31 and february wouldn't be a valid date)
        if @datetime && @options[:discard_day] && !@options[:discard_month]
          @datetime = @datetime.change(:day => 1)
        end
        
        if @options[:single]
          build_input_from_types(order, :date)
        else
          build_inputs_from_types(order)
        end
      end
      
      def input_datetime
        if @options[:ignore_date]
          input_time
        else
          order, time_first = [], (@options[:order] && time_order.include?(@options[:order].first))
          torder, dorder = time_order.dup, date_order.dup
          [:day, :month, :year].each { |o| dorder.unshift(o) unless dorder.include?(o) }
          [:second, :minute, :hour].each { |o| torder.unshift(o) unless torder.include?(o) }
          
          order += dorder unless time_first
          order += torder
          order += dorder if time_first
          order -= [:second] unless @options[:include_seconds]
          @options[:order] = order
          @options[:discard_second] ||= true unless @options[:include_seconds]
          
          if @options[:single_datetime]
            build_input_from_types(order, :datetime)
          else
            s = input_date
            s << separator(:date, :time, true)
            @options[:ignore_date] = true
            s << input_time
          end
        end
      end
      
      def input_second
        if @options[:use_hidden] || @options[:discard_second]
          build_hidden(:second, sec) if @options[:include_seconds]
        else
          build_input(:second, sec)
        end
      end

      def input_minute
        if @options[:use_hidden] || @options[:discard_minute]
          build_hidden(:minute, min)
        else
          build_input(:minute, min)
        end
      end
      
      def input_hour
        if @options[:use_hidden] || @options[:discard_hour]
          build_hidden(:hour, hour)
        else
          build_input(:hour, hour)
        end
      end
      
      def input_day
        if @options[:use_hidden] || @options[:discard_day]
          build_hidden(:day, day)
        else
          build_input(:day, day)
        end
      end
      
      def input_month
        if @options[:use_hidden] || @options[:discard_month]
          build_hidden(:month, month)
        else
          build_input(:month, month_name(month))
        end
      end
      
      def input_year
        val = (!@datetime || @datetime == 0) ? '' : year

        if @options[:use_hidden] || @options[:discard_year]
          build_hidden(:year, val)
        else
          build_input(:year, val)
        end
      end
      
      private
        %w( sec min hour day month year ).each do |method|
          define_method(method) do
            @datetime.kind_of?(Fixnum) ? @datetime : @datetime.send(method) if @datetime
          end
        end
        alias_method :minute, :min
        alias_method :second, :sec
        
        # Builds input tag from date type and html options
        #  build_input(:month, 1)
        #  => "<input type="text" id="post_written_on_2i" name="post[written_on(2i)]" value="1" />
        def build_input(type, value, options = {})
          input_options = {
            :id => input_id_from_type(type),
            :name => input_name_from_type(type),
            :type => 'text',
            :value => rewrite_value(value, type),
            :size => size_for_type(type)
          }.merge(options).merge(@html_options)
          
          input_options.merge!(:disabled => 'disabled') if @options[:disabled]

          tag(:input, input_options, false, false) + "\n"
        end

        # Builds hidden input tag for date part and value
        #  build_hidden(:year, 2008)
        #  => "<input id="post_written_on_1i" name="post[written_on(1i)]" type="hidden" value="2008" />"
        def build_hidden(type, value)
          tag(:input, {
            :type => "hidden",
            :id => input_id_from_type(type),
            :name => input_name_from_type(type),
            :value => rewrite_value(value, type)
          }) + "\n"
        end
        
        # Returns the name attribute for the input tag
        #  => post[written_on(1i)]
        def input_name_from_type(type)
          prefix = @options[:prefix] || DiMarcello::DateTimeField::DateTimeField::DEFAULT_PREFIX
          prefix += "[#{@options[:index]}]" if @options.has_key?(:index)

          field_name = (@options[:field_name] || type).to_s
          if @options[:include_position]
            field_name += "(#{DiMarcello::DateTimeField::DateTimeField::POSITION[type]}i)"
          end

          @options[:discard_type] ? prefix : "#{prefix}[#{field_name}]"
        end
        
        # Returns the id attribute for the input tag
        #  => "post_written_on_1i"
        def input_id_from_type(type)
          input_name_from_type(type).gsub(/([\[\(])|(\]\[)/, '_').gsub(/[\]\)]/, '')
        end
        
        def rewrite_value(value, type = nil)
          iv = value.to_i
          if value.nil? || ([:date, :datetime, :day, :month, :year].include?(type) && iv == 0)
            ""
          elsif iv.to_s == value.to_s && @options[:leading_zeros] && iv < 10
            "0#{iv.to_s}"
          else
            value
          end
        end
        
        # Returns translated day names, but also ensures that a custom day
        # name array has a leading nil element
        def day_names
          names = @options[:day_names] || translated_day_names
          names.unshift(nil) if names.size < 8
          names
        end
        memoize :day_names

        # Returns translated day names
        #  => [nil, "Sunday", "Monday", "Tuesday", "Wednesday",
        #           "Thursday", "Friday", "Saturday"]
        #
        # If :use_short_month option is set
        #  => [nil, "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        def translated_month_names
          begin
            key = @options[:use_short_day] ? :'date.abbr_day_names' : :'date.day_names'
            I18n.translate(key, :locale => @options[:locale])
          end
        end
        
        # Returns translated month names, but also ensures that a custom month
        # name array has a leading nil element
        def month_names
          names = @options[:month_names] || translated_month_names
          names.unshift(nil) if names.size < 13
          names
        end
        memoize :month_names

        # Returns translated month names
        #  => [nil, "January", "February", "March",
        #           "April", "May", "June", "July",
        #           "August", "September", "October",
        #           "November", "December"]
        #
        # If :use_short_month option is set
        #  => [nil, "Jan", "Feb", "Mar", "Apr", "May", "Jun",
        #           "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        def translated_month_names
          begin
            key = @options[:use_short_month] ? :'date.abbr_month_names' : :'date.month_names'
            I18n.translate(key, :locale => @options[:locale])
          end
        end

        # Lookup month name for number
        # If :use_month_names option is passed
        #  month_name(1) => "January"
        #
        # If :add_month_numbers option is passed
        #  month_name(1) => "1 - January"
        #
        # Else
        #  month_name(1) => 1
        def month_name(number)
          if @options[:add_month_numbers]
            "#{number} - #{month_names[number]}"
          elsif @options[:use_month_names]
            month_names[number]
          else
            number
          end
        end
        
        def time_order
          (@options[:order] || [:hour, :minute, :second]) - [:year, :month, :day]
        end
        memoize :time_order
        
        def date_order
          (@options[:order] || translated_date_order) - [:hour, :minute, :second]
        end
        memoize :date_order

        def translated_date_order
          begin
            I18n.translate(:'date.order', :locale => @options[:locale]) || []
          end
        end

        # Given an ordering of datetime components, create the input html
        # and join them with their appropriate seperators
        def build_inputs_from_types(order)
          last, input = nil, ''
          order.each do |type|
            unless @options[:"discard_#{type}"] || @options[:use_hidden]
              input << separator(type, last, true)
              last = type
            end
            input << send("input_#{type}").to_s
          end
          input
        end
        
        def build_input_from_types(order, type)
          last, value, title = nil, '', ''
          order.each do |part|
            unless @options[:"discard_#{part}"]
              separator = separator(part, last, false, true)
              val = rewrite_value(send(part), part).to_s
              value << "#{separator}#{val}" unless val.blank?
              title << "#{separator}#{TITLE[part]}"
              last = part
            end
          end
          @options[:discard_type] = true
          build_input(type, value, :title => title)
        end

        # Returns the separator for a given datetime component
        def separator(type, last_type, add_spaces = false, use_default = false)
          return "" if last_type.nil?
          options = (use_default ? DiMarcello::DateTimeField::DateTimeField::DEFAULT_SEPARATORS : {}).merge @options
          stype = separator_type(type)
          sep = if stype == separator_type(last_type)
            options[:"#{stype}_separator"] || ""
          else
            options[:datetime_separator] || ""
          end
          sep = " #{sep} " if add_spaces && !sep.blank?
          sep.to_s
        end
        
        def separator_type(type)
          case type
            when :month, :day, :year, :date
              :date
            when :hour, :minute, :second, :time
              :time
          end
        end
        
        def size_for_type(type)
          k = :"#{type}_size"
          return @options[k] if @options[k]
          case type
            when :time
              s = 0
              s += 2 unless @options[:discard_hour]
              s += 2 unless @options[:discard_minute]
              s += 2 unless @options[:discard_second]
              s += (s / 3).to_i
            when :date
              s = 0
              s += 2 unless @options[:discard_day]
              s += size_for_type(:month) unless @options[:discard_month]
              s += 4 unless @options[:discard_year]
              s += (s / 4).to_i
            when :datetime
              size_for_type(:time) + size_for_type(:date) + 1
            when :month
              @options[:use_month_names] ? month_names.compact.map(&:size).sort.last : 2
            when :year
              4
            else
              2
          end
        end
    
    end
  end
end