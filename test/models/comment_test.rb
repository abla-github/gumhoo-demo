require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    # @user = users(:abla)
    # @post = posts(:orange)
    @comment = comments(:one)
  end
  
  test "should be valid" do
    assert @comment.valid?
  end
  
  test "content should be present" do
    @comment.content = ""
    assert_not @comment.valid?
  end
  
end
