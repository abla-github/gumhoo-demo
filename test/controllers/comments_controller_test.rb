require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def setup
    @user = users(:abla)
    @post = posts(:orange)
  end
  
  test "create should require logged-in user" do
    assert_no_difference 'Comment.count' do
      post :create, post_id: @post.id, comment: { content: 'content' }
    end
    assert_redirected_to login_url
  end
  
  test "create a post" do
    log_in_as(@user)
    
    assert_difference 'Comment.count', 1 do
      post :create, post_id: @post.id, comment: { content: 'content' }
    end
  end
end
