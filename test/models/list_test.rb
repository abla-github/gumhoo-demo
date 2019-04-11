require 'test_helper'

class ListTest < ActiveSupport::TestCase
  def setup
    @user = users(:abla)
    @list = @user.lists.build(name: "My list")
  end

  test "should be valid" do
    assert @list.valid?
  end
  
  test "title should be present" do
    @list.name = "   "
    assert_not @list.valid?
  end
end
