require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end

  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "p", count: 10
  end

  test "Random word gives message that word isn't in the grid" do
    visit new_url
    fill_in 'word', with: 'freelancers'
    click_on "Let's go!"
    assert_text "Sorry but FREELANCERS can't be built out of"
  end
end

# Tests
# Going to the /new game page displays a random grid
# You can fill the form with a random word, click the play button, and get a message that the word is not in the grid.
# You can fill the form with a one-letter consonant word, click play, and get a message it’s not a valid English word
# You can fill the form with a valid English word (that’s hard because there is randomness!), click play and get a “Congratulations” message

# test 'saying Hello yields a grumpy response from the coach' do
#     visit ask_url
#     fill_in 'question', with: 'Hello'
#     click_on 'Ask'
#     assert_text "I don't care, get dressed and go to work!"
#     take_screenshot
# end
