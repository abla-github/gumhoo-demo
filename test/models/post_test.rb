require 'test_helper'

class PostTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:abla)
    # This code is not idiomatically correct.
    @post = @user.posts.build(title:   "My post",
                              content: "Lorem ipsum",
                              price:   10,
                              link:    "https://tw.yahoo.com")
  end

  test "should be valid" do
    assert @post.valid?
  end
  
  test "title should be present" do
    @post.title = "   "
    assert_not @post.valid?
  end

  test "user id should be present" do
    @post.user_id = nil
    assert_not @post.valid?
  end
  
  test "content should be present" do
    @post.content = "   "
    assert_not @post.valid?
  end

  test "content should be at most 140 characters" do
    @post.content = "a" * 141
    assert_not @post.valid?
  end
  
  test "price should be present" do
    @post.price = nil
    assert_not @post.valid?
  end
  
  test "order should be most recent first" do
    assert_equal posts(:most_recent), Post.first
  end
  
  test "associated comments should be destroyed" do
    @post.save
    @post.comments.create(content: "content", user: @user)
    assert_difference 'Comment.count', -1 do
      @post.destroy
    end
  end
end
