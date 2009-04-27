require 'test_helper'

class DateHelperSingleFieldTagTest < ActionView::TestCase
  tests DiMarcello::DateTimeField::DateHelper
  #TODO Tests with numeric value
  
  def test_second_field_tag
    expected = %(<input id="date_second" name="date[second]" value="18" size="2" type="text" />\n)
    
    assert_dom_equal expected, second_field_tag(time)
  end
  
  def test_second_field_tag_with_leading_zeros
    expected = %(<input id="date_second" name="date[second]" value="02" size="2" type="text" />\n)
    
    assert_dom_equal expected, second_field_tag(time.dup.change(:sec => 2), :leading_zeros => true)
  end
  
  def test_second_field_tag_with_size
    expected = %(<input id="date_second" name="date[second]" value="18" size="3" type="text" />\n)
    
    assert_dom_equal expected, second_field_tag(time, :second_size => 3)
  end
  
  def test_second_field_tag_with_disabled
    expected = %(<input id="date_second" name="date[second]" value="18" size="2" type="text" disabled="disabled" />\n)
    
    assert_dom_equal expected, second_field_tag(time, :disabled => true)
  end

  def test_second_field_tag_with_field_name_override
    expected = %(<input id="date_seconde" name="date[seconde]" value="18" size="2" type="text" />\n)

    assert_dom_equal expected, second_field_tag(time, :field_name => 'seconde')
  end

  def test_second_field_tag_nil
    expected = %(<input id="date_second" name="date[second]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, second_field_tag(nil)
  end

  def test_second_field_tag_numeric
    expected = %(<input id="date_second" name="date[second]" value="10" size="2" type="text" />\n)

    assert_dom_equal expected, second_field_tag(10)
  end
  
  def test_second_field_tag_zero
    expected = %(<input id="date_second" name="date[second]" value="0" size="2" type="text" />\n)

    assert_dom_equal expected, second_field_tag(0)
  end
  
  def test_second_field_tag_with_html_options
    expected = %(<input id="date_second" name="date[second]" value="18" size="2" type="text" class="selector" accesskey="M" />\n)

    assert_dom_equal expected, second_field_tag(time, {}, :class => 'selector', :accesskey => 'M')
  end
  
  
  
  def test_minute_field_tag
    expected = %(<input id="date_minute" name="date[minute]" value="4" size="2" type="text" />\n)
    
    assert_dom_equal expected, minute_field_tag(time)
  end
  
  def test_minute_field_tag_with_leading_zeros
    expected = %(<input id="date_minute" name="date[minute]" value="04" size="2" type="text" />\n)
    
    assert_dom_equal expected, minute_field_tag(time, :leading_zeros => true)
  end
  
  def test_minute_field_tag_with_size
    expected = %(<input id="date_minute" name="date[minute]" value="4" size="3" type="text" />\n)
    
    assert_dom_equal expected, minute_field_tag(time, :minute_size => 3)
  end
  
  def test_minute_field_tag_with_disabled
    expected = %(<input id="date_minute" name="date[minute]" value="4" size="2" type="text" disabled="disabled" />\n)
    
    assert_dom_equal expected, minute_field_tag(time, :disabled => true)
  end

  def test_minute_field_tag_with_field_name_override
    expected = %(<input id="date_minuut" name="date[minuut]" value="4" size="2" type="text" />\n)

    assert_dom_equal expected, minute_field_tag(time, :field_name => 'minuut')
  end

  def test_minute_field_tag_nil
    expected = %(<input id="date_minute" name="date[minute]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, minute_field_tag(nil)
  end

  def test_minute_field_tag_numeric
    expected = %(<input id="date_minute" name="date[minute]" value="10" size="2" type="text" />\n)

    assert_dom_equal expected, minute_field_tag(10)
  end
  
  def test_minute_field_tag_zero
    expected = %(<input id="date_minute" name="date[minute]" value="0" size="2" type="text" />\n)

    assert_dom_equal expected, minute_field_tag(0)
  end

  def test_minute_field_tag_with_html_options
    expected = %(<input id="date_minute" name="date[minute]" value="4" size="2" type="text" class="selector" accesskey="M" />\n)

    assert_dom_equal expected, minute_field_tag(time, {}, :class => 'selector', :accesskey => 'M')
  end

  
  
  def test_hour_field_tag
    expected = %(<input id="date_hour" name="date[hour]" value="8" size="2" type="text" />\n)
    
    assert_dom_equal expected, hour_field_tag(time)
  end
  
  def test_hour_field_tag_with_leading_zeros
    expected = %(<input id="date_hour" name="date[hour]" value="08" size="2" type="text" />\n)
    
    assert_dom_equal expected, hour_field_tag(time, :leading_zeros => true)
  end
  
  def test_hour_field_tag_with_size
    expected = %(<input id="date_hour" name="date[hour]" value="8" size="3" type="text" />\n)
    
    assert_dom_equal expected, hour_field_tag(time, :hour_size => 3)
  end
  
  def test_hour_field_tag_with_disabled
    expected = %(<input id="date_hour" name="date[hour]" value="8" size="2" type="text" disabled="disabled" />\n)
    
    assert_dom_equal expected, hour_field_tag(time, :disabled => true)
  end

  def test_hour_field_tag_with_field_name_override
    expected = %(<input id="date_uur" name="date[uur]" value="8" size="2" type="text" />\n)

    assert_dom_equal expected, hour_field_tag(time, :field_name => 'uur')
  end

  def test_hour_field_tag_nil
    expected = %(<input id="date_hour" name="date[hour]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, hour_field_tag(nil)
  end

  def test_hour_field_tag_numeric
    expected = %(<input id="date_hour" name="date[hour]" value="10" size="2" type="text" />\n)

    assert_dom_equal expected, hour_field_tag(10)
  end
  
  def test_hour_field_tag_zero
    expected = %(<input id="date_hour" name="date[hour]" value="0" size="2" type="text" />\n)

    assert_dom_equal expected, hour_field_tag(0)
  end

  def test_hour_field_tag_with_html_options
    expected = %(<input id="date_hour" name="date[hour]" value="8" size="2" type="text" class="selector" accesskey="M" />\n)

    assert_dom_equal expected, hour_field_tag(time, {}, :class => 'selector', :accesskey => 'M')
  end
  
  
  
  def test_day_field_tag
    expected = %(<input id="date_day" name="date[day]" value="16" size="2" type="text" />\n)
    
    assert_dom_equal expected, day_field_tag(time)
  end
  
  def test_day_field_tag_with_leading_zeros
    expected = %(<input id="date_day" name="date[day]" value="02" size="2" type="text" />\n)
    
    assert_dom_equal expected, day_field_tag(time.dup.change(:day => 2), :leading_zeros => true)
  end
  
  def test_day_field_tag_with_size
    expected = %(<input id="date_day" name="date[day]" value="16" size="3" type="text" />\n)
    
    assert_dom_equal expected, day_field_tag(time, :day_size => 3)
  end
  
  def test_day_field_tag_with_disabled
    expected = %(<input id="date_day" name="date[day]" value="16" size="2" type="text" disabled="disabled" />\n)
    
    assert_dom_equal expected, day_field_tag(time, :disabled => true)
  end

  def test_day_field_tag_with_field_name_override
    expected = %(<input id="date_dag" name="date[dag]" value="16" size="2" type="text" />\n)

    assert_dom_equal expected, day_field_tag(time, :field_name => 'dag')
  end

  def test_day_field_tag_nil
    expected = %(<input id="date_day" name="date[day]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, day_field_tag(nil)
  end

  def test_day_field_tag_zero
    expected = %(<input id="date_day" name="date[day]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, day_field_tag(0)
  end

  def test_day_field_tag_numeric
    expected = %(<input id="date_day" name="date[day]" value="10" size="2" type="text" />\n)

    assert_dom_equal expected, day_field_tag(10)
  end
  
  def test_day_field_tag_with_html_options
    expected = %(<input id="date_day" name="date[day]" value="16" size="2" type="text" class="selector" accesskey="M" />\n)

    assert_dom_equal expected, day_field_tag(time, {}, :class => 'selector', :accesskey => 'M')
  end
  
  
  
  def test_month_field_tag
    expected = %(<input id="date_month" name="date[month]" value="8" size="2" type="text" />\n)
    
    assert_dom_equal expected, month_field_tag(time)
  end
  
  def test_month_field_tag_with_leading_zeros
    expected = %(<input id="date_month" name="date[month]" value="08" size="2" type="text" />\n)
    
    assert_dom_equal expected, month_field_tag(time, :leading_zeros => true)
  end
  
  def test_month_field_tag_with_size
    expected = %(<input id="date_month" name="date[month]" value="8" size="3" type="text" />\n)
    
    assert_dom_equal expected, month_field_tag(time, :month_size => 3)
  end
  
  def test_month_field_tag_with_disabled
    expected = %(<input id="date_month" name="date[month]" value="8" size="2" type="text" disabled="disabled" />\n)
    
    assert_dom_equal expected, month_field_tag(time, :disabled => true)
  end

  def test_month_field_tag_with_field_name_override
    expected = %(<input id="date_maand" name="date[maand]" value="8" size="2" type="text" />\n)

    assert_dom_equal expected, month_field_tag(time, :field_name => 'maand')
  end

  def test_month_field_tag_nil
    expected = %(<input id="date_month" name="date[month]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, month_field_tag(nil)
  end

  def test_month_field_tag_numeric
    expected = %(<input id="date_month" name="date[month]" value="10" size="2" type="text" />\n)

    assert_dom_equal expected, month_field_tag(10)
  end
  
  def test_month_field_tag_zero
    expected = %(<input id="date_month" name="date[month]" value="" size="2" type="text" />\n)

    assert_dom_equal expected, month_field_tag(0)
  end

  def test_month_field_tag_with_html_options
    expected = %(<input id="date_month" name="date[month]" value="8" size="2" type="text" class="selector" accesskey="M" />\n)

    assert_dom_equal expected, month_field_tag(time, {}, :class => 'selector', :accesskey => 'M')
  end
  
  
  
  def test_year_field_tag
    expected = %(<input id="date_year" name="date[year]" value="2003" size="4" type="text" />\n)
    
    assert_dom_equal expected, year_field_tag(time)
  end
  
  def test_year_field_tag_with_size
    expected = %(<input id="date_year" name="date[year]" value="2003" size="3" type="text" />\n)
    
    assert_dom_equal expected, year_field_tag(time, :year_size => 3)
  end
  
  def test_year_field_tag_with_disabled
    expected = %(<input id="date_year" name="date[year]" value="2003" size="4" type="text" disabled="disabled" />\n)
    
    assert_dom_equal expected, year_field_tag(time, :disabled => true)
  end

  def test_year_field_tag_with_field_name_override
    expected = %(<input id="date_jaar" name="date[jaar]" value="2003" size="4" type="text" />\n)

    assert_dom_equal expected, year_field_tag(time, :field_name => 'jaar')
  end

  def test_year_field_tag_nil
    expected = %(<input id="date_year" name="date[year]" value="" size="4" type="text" />\n)

    assert_dom_equal expected, year_field_tag(nil)
  end

  def test_year_field_tag_numeric
    expected = %(<input id="date_year" name="date[year]" value="10" size="4" type="text" />\n)

    assert_dom_equal expected, year_field_tag(10)
  end

  def test_year_field_tag_zero
    expected = %(<input id="date_year" name="date[year]" value="" size="4" type="text" />\n)

    assert_dom_equal expected, year_field_tag(0)
  end

  def test_year_field_tag_with_html_options
    expected = %(<input id="date_year" name="date[year]" value="2003" size="4" type="text" class="selector" accesskey="M" />\n)

    assert_dom_equal expected, year_field_tag(time, {}, :class => 'selector', :accesskey => 'M')
  end


  private
  
  def time
    @time ||= Time.mktime(2003, 8, 16, 8, 4, 18)
  end
end