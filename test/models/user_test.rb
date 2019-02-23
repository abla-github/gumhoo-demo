require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end
  
  test "should be valid" do
    assert @user.valid?
  end
  
  test "name should be present" do
    @user.name = ""
    assert_not @user.valid?
  end
  
  test "email should be present" do
    @user.email = ""
    assert_not @user.valid?
  end
  
  test "name's max length should be 50" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  
  test "email's length should be less than 255" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com
                         USER@foo.COM
                         A_US-ER@foo.bar.org
                         first.last@foo.jp
                         alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"  
    end
  end
  
  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com
                           user_at_foo.org
                           user.name@example.
                           foo@bar_baz.com
                           foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end
  
  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test "associated posts should be destroyed" do
    @user.save
    @user.posts.create!(title:   "title",
                        content: "Lorem ipsum",
                        price:   10)
    assert_difference 'Post.count', -1 do
      @user.destroy
    end
  end
  
  test "has a avatar url" do
    gravatar_id = Digest::MD5::hexdigest(@user.email.downcase)
    avatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=80"
    
    assert_equal @user.avatar_url, avatar_url
  end
  
  test "associated comments should be destroyed" do
    @user.save
    post = @user.posts.create!(title:   "title",
                               content: "Lorem ipsum",
                               price:   10)
    post.comments.create(content: "content", user: @user)
    assert_difference 'Comment.count', -1 do
      @user.destroy
    end
  end
  
  test "should follow and unfollow a user" do
    abla = users(:abla)
    archer = users(:archer)
    assert_not abla.following?(archer)
    abla.follow(archer)
    assert abla.following?(archer)
    assert archer.followers.include?(abla)
    abla.unfollow(archer)
    assert_not abla.following?(archer)
  end
  
  test "feed should have the right posts" do
    abla   = users(:abla)
    archer = users(:archer)
    lana   = users(:lana)
    # Posts from followed user
    lana.posts.each do |post_following|
      assert abla.feed.include?(post_following)
    end
    # Posts from self
    abla.posts.each do |post_self|
      assert abla.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.posts.each do |post_unfollowed|
      assert_not abla.feed.include?(post_unfollowed)
    end
  end
end
