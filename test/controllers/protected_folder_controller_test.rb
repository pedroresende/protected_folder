require "test_helper"

class ProtectedFolderControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get protected_folder_show_url
    assert_response :success
  end
end
