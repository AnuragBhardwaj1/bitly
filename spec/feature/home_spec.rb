require 'rails_helper'

RSpec.feature "Home page" do
  describe "shorten a new valid link", type: :feature do

    it "Shorten a valid link" do
      visit root_path
      fill_in 'link[long_link]', with: 'www.google.com'
      click_button 'shorten'

      expect(page).to have_content 'Success: Link created'
    end
  end

  describe "shorten a already shorten valid link", type: :feature do

    before do
      @link = Link.create(long_link: 'www.google.com')
    end

    it "Shorten a valid link" do
      visit root_path
      fill_in 'link[long_link]', with: 'www.google.com'
      click_button 'shorten'

      expect(page).to have_content 'Success: Link exists'
      expect(page).to have_content @link.short_link
    end
  end

  describe "shorten a used invalid link", type: :feature do

    it "render with error" do
      visit root_path
      fill_in 'link[long_link]', with: 'www. google .com'
      click_button 'shorten'

      expect(page).to have_content 'Invalid Url'
    end
  end

  # describe "opening a short_link", type: :feature do
  #   before do
  #     @link = Link.create(long_link: 'www.google.com')
  #   end

  #   it "render with error" do
  #     visit root_path
  #     fill_in 'link[long_link]', with: 'www.google.com'
  #     click_button 'shorten'

  #     new_window = window_opened_by { click_link "#{ root_path + @link.short_link }" }

  #     expect(new_window).to have_content 'www.google.com'
  #   end
  # end
end
