require 'spec_helper'

describe Zendesk::Response::CallbackMiddleware, :vcr_off do
  let(:response) { "TEST" }

  before(:all) do
    client.insert_callback do |env|
      env[:body] = response
    end
    stub_request(:get, %r{test_endpoint}).to_return(:body => { "ABC" => "DEF" })
  end

  it "should call callbacks " do
    client.connection.get("test_endpoint").body.should == response
  end
end
