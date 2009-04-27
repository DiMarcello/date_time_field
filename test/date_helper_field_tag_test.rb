require 'test_helper'

class DateHelperFieldTagTest < ActionView::TestCase
  tests DiMarcello::DateTimeField::DateHelper
  
  def test_date_field_tag
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]")
  end

  def test_date_field_tag_with_leading_zeros
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="08" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :leading_zeros => true)
  end

  def test_date_field_tag_with_size
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="5" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="3" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="3" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :day_size => 3, :month_size => 3, :year_size => 5)
  end

  def test_date_field_tag_with_order
    expected =  %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :order => [:month, :day, :year])
  end

  def test_date_field_tag_with_incomplete_order
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    
    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :order => [:day])
  end

  def test_date_field_tag_with_disabled
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" disabled="disabled" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" disabled="disabled" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" disabled="disabled" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :disabled => true)
  end

  def test_date_field_tag_with_zero_value
    expected =  %(<input id="date_first_year" name="date[first][year]" value="" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="" type="text" size="2" />\n)

    assert_dom_equal expected, date_field_tag(0, :prefix => "date[first]")
  end

  def test_date_field_tag_with_nil_value
    expected =  %(<input id="date_first_year" name="date[first][year]" value="" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="" type="text" size="2" />\n)

    assert_dom_equal expected, date_field_tag(nil, :prefix => "date[first]")
  end

  def test_date_field_tag_with_html_options
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" class="selector" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" class="selector" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" class="selector" />\n)

    assert_dom_equal expected, date_field_tag(time, {:prefix => "date[first]"}, :class => "selector")
  end

  def test_date_field_tag_with_separator
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << " / "
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << " / "
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)

    assert_dom_equal expected, date_field_tag(time, { :date_separator => "/", :prefix => "date[first]"})
  end


  def test_date_field_tag_single
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16" type="text" size="10" title="YYYY/MM/DD" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :single => true)
  end

  def test_date_field_tag_single_with_zero_value
    expected =  %(<input id="date_first" name="date[first]" value="" type="text" size="10" title="YYYY/MM/DD" />\n)

    assert_dom_equal expected, date_field_tag(0, :prefix => "date[first]", :single => true)
  end

  def test_date_field_tag_single_with_nil_value
    expected =  %(<input id="date_first" name="date[first]" value="" type="text" size="10" title="YYYY/MM/DD" />\n)

    assert_dom_equal expected, date_field_tag(nil, :prefix => "date[first]", :single => true)
  end

  def test_date_field_tag_single_with_separator
    expected =  %(<input id="date_first" name="date[first]" value="2003-8-16" type="text" size="10" title="YYYY-MM-DD" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :single => true, :date_separator => "-")
  end

  def test_date_field_tag_single_with_title
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16" type="text" size="10" title="title" />\n)

    assert_dom_equal expected, date_field_tag(time, {:prefix => "date[first]", :single => true}, :title => "title")
  end

  def test_date_field_tag_single_with_order
    expected =  %(<input id="date_first" name="date[first]" value="8/16/2003" type="text" size="10" title="MM/DD/YYYY" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :single => true, :order => [:month, :day, :year])
  end

  def test_date_field_tag_single_with_incomplete_order
    expected =  %(<input id="date_first" name="date[first]" value="2003/16/8" type="text" size="10" title="YYYY/DD/MM" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :single => true, :order => [:month])
  end

  def test_date_field_tag_single_with_disabled
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16" type="text" size="10" disabled="disabled" title="YYYY/MM/DD" />\n)

    assert_dom_equal expected, date_field_tag(time, :prefix => "date[first]", :single => true, :disabled => true)
  end

  def test_date_field_tag_single_with_html_options
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16" type="text" size="10" class="selector" title="YYYY/MM/DD" />\n)

    assert_dom_equal expected, date_field_tag(time, {:prefix => "date[first]", :single => true}, :class => "selector")
  end

  
  
  def test_time_field_tag
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]")
  end
  
  def test_time_field_tag_with_second
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)
    expected << %(<input id="date_first_second" name="date[first][second]" value="18" type="text" size="2" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :include_seconds => true)
  end

  def test_time_field_tag_with_leading_zeros
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="08" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="08" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="04" type="text" size="2" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :leading_zeros => true)
  end

  def test_time_field_tag_with_size
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="3" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="3" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :hour_size => 3, :minute_size => 3, :year_size => 5)
  end

  def test_time_field_tag_with_order
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :order => [:minute, :hour])
  end

  def test_time_field_tag_with_incomplete_order
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)
    
    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :order => [:minute])
  end

  def test_time_field_tag_with_disabled
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" disabled="disabled" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" disabled="disabled" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :disabled => true)
  end

  def test_time_field_tag_with_zero_value
    expected =  %(<input id="date_first_year" name="date[first][year]" value="" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="0" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="0" type="text" size="2" />\n)

    assert_dom_equal expected, time_field_tag(0, :prefix => "date[first]")
  end

  def test_time_field_tag_with_nil_value
    expected =  %(<input id="date_first_year" name="date[first][year]" value="" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="" type="text" size="2" />\n)

    assert_dom_equal expected, time_field_tag(nil, :prefix => "date[first]")
  end

  def test_time_field_tag_with_html_options
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" class="selector" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" class="selector" />\n)

    assert_dom_equal expected, time_field_tag(time, {:prefix => "date[first]"}, :class => "selector")
  end

  def test_time_field_tag_with_separator
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="hidden" />\n)
    
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << " : "
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)

    assert_dom_equal expected, time_field_tag(time, { :time_separator => ":", :prefix => "date[first]"})
  end
  
  
  
  def test_time_field_tag_single
    expected =  %(<input id="date_first" name="date[first]" value="8:4" type="text" size="5" title="hh:mm" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :single => true)
  end
  
  def test_time_field_tag_single_with_second
    expected =  %(<input id="date_first" name="date[first]" value="8:4:18" type="text" size="8" title="hh:mm:ss" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :single => true, :include_seconds => true)
  end

  def test_time_field_tag_single_with_zero_value
    expected =  %(<input id="date_first" name="date[first]" value="0:0" type="text" size="5" title="hh:mm" />\n)

    assert_dom_equal expected, time_field_tag(0, :prefix => "date[first]", :single => true)
  end

  def test_time_field_tag_single_with_nil_value
    expected =  %(<input id="date_first" name="date[first]" value="" type="text" size="5" title="hh:mm" />\n)

    assert_dom_equal expected, time_field_tag(nil, :prefix => "date[first]", :single => true)
  end

  def test_time_field_tag_single_with_separator
    expected =  %(<input id="date_first" name="date[first]" value="8-4" type="text" size="5" title="hh-mm" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :single => true, :time_separator => "-")
  end

  def test_time_field_tag_single_with_title
    expected =  %(<input id="date_first" name="date[first]" value="8:4" type="text" size="5" title="title" />\n)

    assert_dom_equal expected, time_field_tag(time, {:prefix => "date[first]", :single => true}, :title => "title")
  end

  def test_time_field_tag_single_with_order
    expected =  %(<input id="date_first" name="date[first]" value="4:8" type="text" size="5" title="mm:hh" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :single => true, :order => [:minute, :hour])
  end

  def test_time_field_tag_single_with_incomplete_order
    expected =  %(<input id="date_first" name="date[first]" value="8:4" type="text" size="5" title="hh:mm" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :single => true, :order => [:minute])
  end

  def test_time_field_tag_single_with_disabled
    expected =  %(<input id="date_first" name="date[first]" value="8:4" type="text" size="5" title="hh:mm" disabled="disabled" />\n)

    assert_dom_equal expected, time_field_tag(time, :prefix => "date[first]", :single => true, :disabled => true)
  end

  def test_time_field_tag_single_with_html_options
    expected =  %(<input id="date_first" name="date[first]" value="8:4" type="text" size="5" title="hh:mm" class="selector" />\n)

    assert_dom_equal expected, time_field_tag(time, {:prefix => "date[first]", :single => true}, :class => "selector")
  end
  
  
  
  def test_datetime_field_tag
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]")
  end
  
  def test_datetime_field_tag_with_seconds
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)
    expected << %(<input id="date_first_second" name="date[first][second]" value="18" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :include_seconds => true)
  end

  def test_datetime_field_tag_with_leading_zeros
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="08" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="08" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="04" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :leading_zeros => true)
  end

  def test_datetime_field_tag_with_size
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="5" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="3" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="3" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="3" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="3" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :day_size => 3, :month_size => 3, :year_size => 5, :hour_size => 3, :minute_size => 3)
  end

  def test_datetime_field_tag_with_order
    expected =  %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :order => [:month, :hour, :day, :year, :minute])
  end

  def test_datetime_field_tag_with_incomplete_order
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="hidden" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="hidden" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)
    
    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :order => [:day, :minute])
  end

  def test_datetime_field_tag_with_disabled
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" disabled="disabled" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" disabled="disabled" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" disabled="disabled" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" disabled="disabled" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" disabled="disabled" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :disabled => true)
  end

  def test_datetime_field_tag_with_zero_value
    expected =  %(<input id="date_first_year" name="date[first][year]" value="" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="0" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="0" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(0, :prefix => "date[first]")
  end

  def test_datetime_field_tag_with_nil_value
    expected =  %(<input id="date_first_year" name="date[first][year]" value="" type="text" size="4" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="" type="text" size="2" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(nil, :prefix => "date[first]")
  end

  def test_datetime_field_tag_with_html_options
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" class="selector" />\n)
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" class="selector" />\n)
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" class="selector" />\n)
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" class="selector" />\n)
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" class="selector" />\n)

    assert_dom_equal expected, datetime_field_tag(time, {:prefix => "date[first]"}, :class => "selector")
  end

  def test_datetime_field_tag_with_separator
    expected =  %(<input id="date_first_year" name="date[first][year]" value="2003" type="text" size="4" />\n)
    expected << " / "
    expected << %(<input id="date_first_month" name="date[first][month]" value="8" type="text" size="2" />\n)
    expected << " / "
    expected << %(<input id="date_first_day" name="date[first][day]" value="16" type="text" size="2" />\n)
    expected << " &mdash; "
    expected << %(<input id="date_first_hour" name="date[first][hour]" value="8" type="text" size="2" />\n)
    expected << " &ndash; "
    expected << %(<input id="date_first_minute" name="date[first][minute]" value="4" type="text" size="2" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :datetime_separator => "&mdash;", :time_separator => "&ndash;", :date_separator => "/", :prefix => "date[first]")
  end



  def test_datetime_field_tag_single_datetime
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16 8:4" type="text" size="16" title="YYYY/MM/DD hh:mm" />\n)
    
    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true)
  end

  def test_datetime_field_tag_single_datetime_with_second
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16 8:4:18" type="text" size="19" title="YYYY/MM/DD hh:mm:ss" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true, :include_seconds => true)
  end

  def test_datetime_field_tag_single_datetime_with_zero_value
    expected =  %(<input id="date_first" name="date[first]" value="" type="text" size="16" title="YYYY/MM/DD hh:mm" />\n)

    assert_dom_equal expected, datetime_field_tag(0, :prefix => "date[first]", :single_datetime => true)
  end

  def test_datetime_field_tag_single_datetime_with_nil_value
    expected =  %(<input id="date_first" name="date[first]" value="" type="text" size="16" title="YYYY/MM/DD hh:mm" />\n)

    assert_dom_equal expected, datetime_field_tag(nil, :prefix => "date[first]", :single_datetime => true)
  end

  def test_datetime_field_tag_single_datetime_with_separator
    expected =  %(<input id="date_first" name="date[first]" value="2003-8-16T8/4" type="text" size="16" title="YYYY-MM-DDThh/mm" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true, :date_separator => "-", :time_separator => "/", :datetime_separator => "T")
  end

  def test_datetime_field_tag_single_datetime_with_title
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16 8:4" type="text" size="16" title="title" />\n)

    assert_dom_equal expected, datetime_field_tag(time, {:prefix => "date[first]", :single_datetime => true}, :title => "title")
  end

  def test_datetime_field_tag_single_datetime_with_order
    expected =  %(<input id="date_first" name="date[first]" value="8/16/2003 4:8" type="text" size="16" title="MM/DD/YYYY mm:hh" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true, :order => [:month, :day, :minute, :year, :hour])
  end
  
  def test_datetime_field_tag_single_datetime_with_order_time_first
    expected =  %(<input id="date_first" name="date[first]" value="8:4 8/16/2003" type="text" size="16" title="hh:mm MM/DD/YYYY" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true, :order => [:hour, :month, :day, :year, :minute])
  end

  def test_datetime_field_tag_single_datetime_with_incomplete_order
    expected =  %(<input id="date_first" name="date[first]" value="2003/16/8 8:4" type="text" size="16" title="YYYY/DD/MM hh:mm" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true, :order => [:month, :minute])
  end

  def test_datetime_field_tag_single_datetime_with_disabled
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16 8:4" type="text" size="16" disabled="disabled" title="YYYY/MM/DD hh:mm" />\n)

    assert_dom_equal expected, datetime_field_tag(time, :prefix => "date[first]", :single_datetime => true, :disabled => true)
  end

  def test_datetime_field_tag_single_datetime_with_html_options
    expected =  %(<input id="date_first" name="date[first]" value="2003/8/16 8:4" type="text" size="16" class="selector" title="YYYY/MM/DD hh:mm" />\n)

    assert_dom_equal expected, datetime_field_tag(time, {:prefix => "date[first]", :single_datetime => true}, :class => "selector")
  end
  
  
  
  def test_datetime_field_tag_single
    options = {:prefix => "date[first]", :single => true}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end
  
  def test_datetime_field_tag_single_with_seconds
    options = {:prefix => "date[first]", :single => true, :include_seconds => true}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_leading_zeros
    options = {:prefix => "date[first]", :single => true, :leading_zeros => true}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_size
    options = {:prefix => "date[first]", :single => true, :date_size => 10, :time_size => 16}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_order
    options = {:prefix => "date[first]", :single => true, :order => [:month, :day, :year, :hour, :minute]}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_order_time_first
    options = {:prefix => "date[first]", :single => true, :order => [:minute, :hour, :month, :day, :year]}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_incomplete_order
    options = {:prefix => "date[first]", :single => true, :order => [:month, :minute]}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_disabled
    options = {:prefix => "date[first]", :single => true, :disabled => true}
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_zero_value
    options = {:prefix => "date[first]", :single => true}
    expected =  date_field_tag(0, options)
    expected << time_field_tag(0, options)

    assert_dom_equal expected, datetime_field_tag(0, options)
  end

  def test_datetime_field_tag_single_with_nil_value
    options = {:prefix => "date[first]", :single => true}
    expected =  date_field_tag(nil, options)
    expected << time_field_tag(nil, options)

    assert_dom_equal expected, datetime_field_tag(nil, options)
  end

  def test_datetime_field_tag_single_with_html_options
    options = {:prefix => "date[first]", :single => true, :class => "selector" }
    expected =  date_field_tag(time, options)
    expected << time_field_tag(time, options)

    assert_dom_equal expected, datetime_field_tag(time, options)
  end

  def test_datetime_field_tag_single_with_separator
    options = {:prefix => "date[first]", :single => true, :datetime_separator => "&mdash;", :time_separator => "-", :date_separator => "/" }
    expected =  date_field_tag(time, options)
    expected << " &mdash; "
    expected << time_field_tag(time, options)
    
    assert_dom_equal expected, datetime_field_tag(time, options)
  end
  
  
  private
  
  def time
    @time ||= Time.mktime(2003, 8, 16, 8, 4, 18)
  end
end