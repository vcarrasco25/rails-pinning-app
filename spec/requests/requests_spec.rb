require "spec_helper"

RSpec.describe "Our Application Routes" do
	describe "GET /pins/name-:slug" do

	  it'renders the pins/show template' do
	    pin = Pin.first
		get pin_by_name_path(slug: pin.slug)
		expect(response).to render_template(:show)
	  end

	  it 'populates the @pin variable with the appropriate pin' do
		pin = Pin.first
		pin_by_name_path(slug: pin.slug)
		"#{pin.title}"
		expect(assigns[:pin]).to eq(pin)
	  end
	end
  
end