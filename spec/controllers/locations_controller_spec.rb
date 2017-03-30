require 'rails_helper'

# These tests are auto-generated from Rails scaffolding, so they're not the best
# tests you'll ever run into. Still, this is a useful stub of a test for our
# application.

RSpec.describe LocationsController, type: :controller, vcr: true do
  render_views

  let(:user) { User.create!(email: "test@test.com", password: "abcd1234") }

  let(:valid_attributes) {
    { title: "The Bean", description: "Technically it's called Cloud Gate", address: "Millennium Park, Chicago" }
  }

  let(:invalid_attributes) {
    { title: "", description: "There's nothing really here.", address: "Millennium Park, Chicago" }
  }

  before { sign_in(user) }

  describe "GET #index" do
    it "assigns all locations as @locations" do
      location = Location.create! valid_attributes

      get :index, params: {}

      expect(assigns(:locations)).to eq([location])
    end
  end

  describe "GET #show" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes

      get :show, params: {id: location.to_param}

      expect(assigns(:location)).to eq(location)
    end

    it "shows a Google Maps embedded map on the page" do
      location = Location.create! valid_attributes

      get :show, params: {id: location.to_param}

      expect(response.body).to include("google.com/maps/embed")
      expect(response.body).to include("q=#{location.address}")
      expect(response.body).to include(Rails.application.secrets.google_api_key)
    end
  end

  describe "GET #new" do
    it "assigns a new location as @location" do
      get :new, params: {}

      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe "GET #edit" do
    it "assigns the requested location as @location" do
      location = Location.create! valid_attributes

      get :edit, params: {id: location.to_param}

      expect(assigns(:location)).to eq(location)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Location" do
        expect {
          post :create, params: {location: valid_attributes}
        }.to change(Location, :count).by(1)
      end

      it "assigns a newly created location as @location" do
        post :create, params: {location: valid_attributes}

        expect(assigns(:location)).to be_a(Location)

        expect(assigns(:location)).to be_persisted
      end

      it "redirects to the created location" do
        post :create, params: {location: valid_attributes}

        expect(response).to redirect_to(Location.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved location as @location" do
        post :create, params: {location: invalid_attributes}

        expect(assigns(:location)).to be_a_new(Location)
      end

      it "re-renders the 'new' template" do
        post :create, params: {location: invalid_attributes}

        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { title: "This is a different title" }
      }

      it "updates the requested location" do
        location = Location.create! valid_attributes

        expect {
          put :update, params: {id: location.to_param, location: new_attributes}
        }.to change {
          location.reload.title
        }
      end

      it "assigns the requested location as @location" do
        location = Location.create! valid_attributes

        put :update, params: {id: location.to_param, location: valid_attributes}

        expect(assigns(:location)).to eq(location)
      end

      it "redirects to the location" do
        location = Location.create! valid_attributes

        put :update, params: {id: location.to_param, location: valid_attributes}

        expect(response).to redirect_to(location)
      end
    end

    context "with invalid params" do
      it "assigns the location as @location" do
        location = Location.create! valid_attributes

        put :update, params: {id: location.to_param, location: invalid_attributes}

        expect(assigns(:location)).to eq(location)
      end

      it "re-renders the 'edit' template" do
        location = Location.create! valid_attributes

        put :update, params: {id: location.to_param, location: invalid_attributes}

        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested location" do
      location = Location.create! valid_attributes

      expect {
        delete :destroy, params: {id: location.to_param}
      }.to change(Location, :count).by(-1)
    end

    it "redirects to the locations list" do
      location = Location.create! valid_attributes

      delete :destroy, params: {id: location.to_param}

      expect(response).to redirect_to(locations_url)
    end
  end

end
