require 'spec_helper'

RSpec.describe PinsController do

  describe "GET index" do
    
    it 'renders the index template' do
      get :index
      expect(response).to render_template("index")
    end

    it 'populates @pins with all pins' do
      get :index
      expect(assigns[:pins]).to eq(Pin.all)
    end
  end

	describe "GET new" do
    it 'responds with successfully' do
      get :new
      expect(response.success?).to be(true)
    end
    
    it 'renders the new view' do
      get :new      
      expect(response).to render_template(:new)
    end
    
    it 'assigns an instance variable to a new pin' do
      get :new
      expect(assigns(:pin)).to be_a_new(Pin)
    end
  end
  
  describe "POST create" do
    before(:each) do
      @pin_hash = { 
        title: "Rails Wizard", 
        url: "http://railswizard.org", 
        slug: "rails-wizard", 
        text: "A fun and helpful Rails Resource",
        category_id: "rails",
        image: "https://placebear.com/75/75"
      }    
    end
    
    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end
    
    it 'responds with a redirect' do
      post :create, pin: @pin_hash
      expect(response.redirect?).to be(true)
    end
    
    it 'creates a pin' do
      post :create, pin: @pin_hash  
      expect(Pin.find_by_slug("rails-wizard").present?).to be(true)
    end
    
    it 'redirects to the show view' do
      post :create, pin: @pin_hash
      expect(response).to redirect_to(pin_url(assigns(:pin)))
    end
    
    it 'redisplays new form on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(response).to render_template(:new)
    end
    
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      @pin_hash.delete(:title)
      post :create, pin: @pin_hash
      expect(assigns[:errors].present?).to be(true)
    end    
    
  end

  describe "GET edit" do

    before(:each) do
      @title = "Rails Wizard"
      @url = "http://railswizard.org"
      @slug = "rails-wizard"
      @text = "A fun and helpful Rails Resource"
      @category_id = "rails"
      @image = "https://placebear.com/75/75"
      @pin = Pin.create(title: @title, url: @url, slug: @slug, text: @text, category_id: @category_id, image: @image)
    end

    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end

    #responds with success
    it 'responds with successfully' do
      new_text = "just a Rails Resource"
      get :edit, {id: @pin.id}, { title: @title, url: @url, slug: @slug, text: new_text, category_id: @category_id, image: @image}
      expect(response.success?).to be(true)
    end
 
    #renders the edit template
    it 'renders the edit view' do
      get :edit, {id: @pin.id}
      expect(response).to render_template(:edit, {id: @pin.id})
    end

    #assigns an instance variable called @pin to the Pin with the appropriate id
    it 'assigns an instance variable to an edit pin' do
      get :edit, {id: @pin.id}
      expect(assigns(:pin)).to be_an_instance_of(Pin)
    end 

  end

  describe "POST update" do

    before(:each) do
      @title = "Rails Wizard"
      @url = "http://railswizard.org"
      @slug = "rails-wizard"
      @text = "A fun and helpful Rails Resource"
      @category_id = "rails"
      @image = "https://placebear.com/75/75"
      @pin = Pin.create(title: @title, url: @url, slug: @slug, text: @text, category_id: @category_id, image: @image)
    end

    after(:each) do
      pin = Pin.find_by_slug("rails-wizard")
      if !pin.nil?
        pin.destroy
      end
    end

    #responds with success
    #An :id key for the @pin id and a pin key that contains 
    #the hash of the status params to be updated.
    it 'responds with successfully' do
      new_text = "Magically helping those learning Rails"
      post :update, {id: @pin.id, pin: {text: new_text}}
      expect(response.success?).to be(true)
    end

    #updates a pin
    it 'updates a pin when a POST request is sent to pins/:id' do
      new_text = "Warlocking to learn Rails"
      post :update, {id: @pin.id, pin: { title: @title, url: @url, slug: @slug, text: new_text, category_id: @category_id, image: @image}}
      expect(@pin.reload.text==new_text).to be(true)
    end

    #redirects to the show view
    it 'redirects to show view' do
      new_text = "Magically helping those learning Rails"
      post :update, {id: @pin.id, pin: {text: new_text}}
      redirect_to(pin_path(@pin))
    end

    #renders the edit view
    it "re-renders the edit method" do
      new_text = ""
      post :update, {id: @pin.id, pin: {text: new_text}}
      expect(response).to render_template(:edit, {id: @pin.id})
    end

    #assigns an @errors instance variable
    it 'assigns the @errors instance variable on error' do
      # The title is required in the Pin model, so we'll
      # delete the title from the @pin_hash in order
      # to test what happens with invalid parameters
      new_text = ""
      post :update, {id: @pin.id, pin: {text: new_text}}
      expect(assigns[:errors].present?).to be(true)
    end  

  end


end