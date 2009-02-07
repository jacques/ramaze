#          Copyright (c) 2006 Michael Fellinger m.fellinger@gmail.com
# All files in this distribution are subject to the terms of the Ruby license.

require 'spec/helper'

Ramaze.options.app.root = '/'
Ramaze.options.app.view = __DIR__(:view)
Ramaze.options.app.layout = __DIR__(:view)

class MainController < Ramaze::Controller
  map '/'
  alias_view :non_existant_method, :list
end

class TCActionOtherLayout < Ramaze::Controller
  map '/other'
  layout 'other_wrapper'

  def index
    "Others Hello"
  end
end

describe "Testing Actionless Templates" do
  behaves_like :mock

  it "should not find template file for non existant method" do
    get('/non_existant_method').status.should == 404
    get('/non_existant_method2').status.should == 404
  end

  it "should render layout(without method) for normal action" do
    get('/other/index').body.should == '<p>Others Hello</p>'
  end
end
