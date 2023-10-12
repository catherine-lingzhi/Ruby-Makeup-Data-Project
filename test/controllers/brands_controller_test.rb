require "test_helper"

class BrandsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get brands_index_url
    assert_response :success
  end

  test "should get show" do
    get brands_show_url
    assert_response :success
  end
end
