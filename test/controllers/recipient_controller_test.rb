require 'test_helper'

class RecipientControllerTest < ActionController::TestCase
  test "should get pubkey" do
    get :pubkey
    assert_response :success
  end

end
