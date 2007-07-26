require 'spec/helper'

class TCActionLayout < Ramaze::Controller
  map '/'
  layout :wrapper
  template_root "#{File.expand_path(File.dirname(__FILE__))}/template"

  def wrapper
    "<pre>#@content</pre>"
  end

  def index
    'Hello, World!'
  end

  def foo
    "bar"
  end
end

class TCActionOtherLayout < Ramaze::Controller
  map '/other'
  layout :other_wrapper
  template_root "#{File.expand_path(File.dirname(__FILE__))}/template"

  def index
    "Others Hello"
  end
end

describe 'Action rendering' do
  before :all do
    ramaze
  end

  it 'should work with layouts' do
    get('/').body.should == "<pre>Hello, World!</pre>"
    get('/foo').body.should == "<pre>bar</pre>"
    get('/bar').body.should == "<pre>Hello from bar</pre>"
  end

  it 'should work with layout from file' do
    get('/other').body.should == "<p>Others Hello</p>"
    get('/other/bar').body.should == "<p>Hello from bar</p>"
  end
end
