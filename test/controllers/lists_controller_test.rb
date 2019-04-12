require 'test_helper'

class ListsControllerTest < ActionController::TestCase
  def setup
    @user = users(:abla)
    @list = lists(:shopping_list)
  end
  
  test "create should require logged-in user" do
    assert_no_difference 'List.count' do
      post :create, list: { name: 'My List' }
    end
    assert_redirected_to login_url
  end
  
  test "create a list" do
    log_in_as(@user)
    
    assert_difference 'List.count', 1 do
      post :create, list: { name: 'My List' }
    end
  end
end
