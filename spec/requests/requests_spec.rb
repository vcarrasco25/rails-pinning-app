require "spec_helper"

RSpec.describe "Our Application Routes" do
	describe "GET /pins/name-:slug" do

	  before(:each) do
        @title = "Rails Wizard"
        @url = "http://railswizard.org"
        @slug = "rails-wizard"
        @text = "A fun and helpful Rails Resource"
        @category_id = "rails"
        @image = "http://placebear.com/75/75"
        @pin = Pin.create(title: @title, url: @url, slug: @slug, text: @text, category_id: @category_id, image: @image)
      end

      after(:each) do
        pin = Pin.find_by_slug("rails-wizard")
        if !pin.nil?
          pin.destroy
        end
      end

	  it'renders the pins/show template' do
	    pin = Pin.first
		get pin_by_name_path(slug: pin.slug)
		"#{pin.title}"
		render_template(pin_by_name_path, {pin: @pin})
	  end

	  it 'populates the @pin variable with the appropriate pin' do
		pin = Pin.first
		get pin_by_name_path(slug: pin.slug)
		"#{pin.title}"
		expect(assigns[:pin]).to eq(pin)
	  end
	end
  
end