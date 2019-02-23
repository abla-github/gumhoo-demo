require 'test_helper'

class PostsInterfaceTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:abla)
  end

  test "post interface" do
    log_in_as(@user)
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=text]'
    # Invalid submission
    link = "https://books.com.tw/products/F013709987"
    assert_no_difference 'Post.count' do
      post posts_path, post: { title:   "",
                               content: "",
                               price:   nil,
                               picture: "",
                               link:    link }
    end
    assert_select 'div#error_explanation'
    # Valid submission
    title   = "Valid title"
    content = "This post really ties the room together"
    price   = 10
    picture = "https://robohash.org/my-own-slug.jpg?size=300x300"
    assert_difference 'Post.count', 1 do
      post posts_path, post: { title:   title,
                               content: content,
                               price:   price,
                               picture: picture,
                               link:    link}
    end
    foo = assigns(:post)
    assert foo.picture?
    assert_redirected_to root_url
    follow_redirect!
    assert_match title, response.body
    # Delete a post.
    assert_select 'a', text: 'delete'
    first_post = @user.posts.paginate(page: 1).first
    assert_difference 'Post.count', -1 do
      delete post_path(first_post)
    end
    # Visit a different user.
    get user_path(users(:archer))
    assert_select 'a', text: 'delete', count: 0
  end
  
  test "post sidebar count" do
    log_in_as(@user)
    get following_user_path(@user)
    assert_match "#{@user.posts.count} posts", response.body
    # User with zero posts
    other_user = users(:malory)
    log_in_as(other_user)
    get following_user_path(other_user)
    assert_match "0 post", response.body
    other_user.posts.create!(title: "test", content: "A micropost", price:5)
    get following_user_path(other_user)
    assert_match "1 post", response.body
  end
end
