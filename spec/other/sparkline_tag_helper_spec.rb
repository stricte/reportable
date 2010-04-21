require File.join(File.dirname(__FILE__), '..', 'spec_helper')

describe Saulabs::Reportable::ReportTagHelper do

  before do
    @helper = TestHelper.new
  end

  describe '#google_report_tag' do

    it 'should render an image with the correct source' do
      @helper.should_receive(:image_tag).once.with(
        'http://chart.apis.google.com/chart?cht=ls&chs=300x34&chd=t:1.0,2.0,3.0&chco=0077cc&chm=B,e6f2fa,0,0,0&chls=1,0,0&chds=1.0,3.0',
        { :title => '', :alt => '' }
      )

      @helper.google_report_tag([[DateTime.now, 1.0], [DateTime.now, 2.0], [DateTime.now, 3.0]])
    end

    it 'should add parameters for labels to the source of the image if rendering of lables is specified' do
      @helper.should_receive(:image_tag).once.with(
        'http://chart.apis.google.com/chart?cht=ls&chs=300x34&chd=t:1.0,2.0,3.0&chco=0077cc&chm=B,e6f2fa,0,0,0&chls=1,0,0&chds=1.0,3.0&chxt=x,y,r,t&chxr=0,0,3|1,0,3.0|2,0,3.0|3,0,3',
        { :title => '', :alt => '' }
      )

      @helper.google_report_tag([[DateTime.now, 1.0], [DateTime.now, 2.0], [DateTime.now, 3.0]], :labels => [:x, :y, :r, :t])
    end

    it 'should set the parameters for custom colors if custom colors are specified' do
      @helper.should_receive(:image_tag).once.with(
        'http://chart.apis.google.com/chart?cht=ls&chs=300x34&chd=t:1.0,2.0,3.0&chco=000000&chm=B,ffffff,0,0,0&chls=1,0,0&chds=1.0,3.0',
        { :title => '', :alt => '' }
      )

      @helper.google_report_tag([[DateTime.now, 1.0], [DateTime.now, 2.0], [DateTime.now, 3.0]], :line_color => '000000', :fill_color => 'ffffff')
    end

    it 'should set the parameters for a custom title if a title specified' do
      @helper.should_receive(:image_tag).once.with(
        'http://chart.apis.google.com/chart?cht=ls&chs=300x34&chd=t:1.0,2.0,3.0&chco=0077cc&chm=B,e6f2fa,0,0,0&chls=1,0,0&chds=1.0,3.0&chtt=title',
        { :title => 'title', :alt => '' }
      )

      @helper.google_report_tag([[DateTime.now, 1.0], [DateTime.now, 2.0], [DateTime.now, 3.0]], :title => 'title')
    end

    it 'should use a specified alt text as alt text for the image' do
      @helper.should_receive(:image_tag).once.with(
        'http://chart.apis.google.com/chart?cht=ls&chs=300x34&chd=t:1.0,2.0,3.0&chco=0077cc&chm=B,e6f2fa,0,0,0&chls=1,0,0&chds=1.0,3.0',
        { :title => '', :alt => 'alt' }
      )

      @helper.google_report_tag([[DateTime.now, 1.0], [DateTime.now, 2.0], [DateTime.now, 3.0]], :alt => 'alt')
    end

  end

end

class TestHelper

  include Saulabs::Reportable::ReportTagHelper

end
