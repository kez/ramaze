#          Copyright (c) 2006 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the Ruby license.

require 'spec/helper'

testcase_requires 'remarkably'

class TCTemplateRemarkablyController < Ramaze::Controller
  template_root 'spec/ramaze/template/remarkably/'
  trait :engine => Ramaze::Template::Remarkably

  include Remarkably

  def index
    h1 "Remarkably Index"
  end

  def links
    ul do
      li { a "Index page", :href => R(self,:index) }
      li { a "Internal template", :href => R(self,:internal) }
      li { a "External template", :href => R(self,:external) }
    end
  end

  def external
  end

  def sum num1, num2
    @num1, @num2 = num1.to_i, num2.to_i
  end
end

describe "Remarkably" do
  ramaze(:mapping => {'/' => TCTemplateRemarkablyController})

  it "index" do
    get('/').body.should == '<h1>Remarkably Index</h1>'
  end

  it "links" do
    get('/links').body.should == '<ul><li><a href="/index">Index page</a></li><li><a href="/internal">Internal template</a></li><li><a href="/external">External template</a></li></ul>'
  end

  it "sum" do
    get('/sum/1/2').body.should == '<div>3</div>'
  end

  it "external" do
    get('/external').body.should == "<html><head><title>Remarkably Test</title></head><body><h1>Remarkably Template</h1></body></html>"
  end

end
