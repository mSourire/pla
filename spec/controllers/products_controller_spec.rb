require 'rails_helper'

RSpec.describe ProductsController, type: :controller do

  let(:existing_product) { Product.create({ id: 5, name: 'Cucumber', price: 20, description: 'Green and crispy' }) }

  describe "GET index" do
    context "when a format is HTML" do
      it "renders the index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    context "when a format is JSON" do
      context "if there are no products yet" do
        it "renders empty JSON" do
          get :index, format: :json
          expect(response.status).to be(200)
          puts JSON.parse(response.body)
          expect(JSON.parse(response.body).length).to eq(0)
        end
      end

      context "if products exist" do
        it "serves multiple products as JSON" do
          existing_product
          get :index, format: :json
          expect(response.status).to be(200)
          expect(JSON.parse(response.body).length).to eq(1)
        end
      end
    end
  end


  describe "POST create" do
    it "assigns @product" do
      post :create, format: :json
      expect(assigns(:product)).to be_kind_of(Product)
    end

    context "when successfully created" do
      it "returns empty response body with 201 status code" do
          post :create, params: { product: { name: 'Tomatos', price: 30, description: 'Red and juicy' } }, format: :json
          expect(response.status).to be(201)
          expect(response.body.length).to eq(0)
      end
    end

    context "when couldn't created" do
      it "returns JSON with error message and 400 status code" do
          post :create, params: { product: { name: 'Tomatos', price: 30 } }, format: :json
          expect(response.status).to be(400)
          expect(JSON.parse(response.body)['errors'].length).to be > 0
      end
    end
  end

  describe "GET show" do
    context "when product exists" do
      context "when format is HTML" do
        it "renders the show template" do
          get :show, params: { id: existing_product.id }
          expect(response).to render_template(:show)
        end
      end

      context "when format is JSON" do
        it "renders the product in JSON" do
          get :show, params: { id: existing_product.id }, format: :json
          expect(JSON.parse(response.body)['id']).to eq(existing_product.idexisting_product.id)
        end
      end
    end

    context "when product does not exist" do
      context "when format is HTML" do
        it "redirects to root path" do
          get :show, params: { id: -1 }
          expect(response).to redirect_to root_path
        end
      end

      context "when format is JSON" do
        it "replies with 404 status code" do
          get :show, params: { id: -1 }, format: :json
          expect(response.status).to be(404)
        end
      end
    end
  end


  describe "GET edit" do
    context "when product exists" do
      it "renders an edit template" do
        get :edit, params: { id: existing_product.id }
        expect(response).to render_template(:edit)
      end
    end

    context "when product doesn't exist" do
      it "redirects to root path" do
        get :edit, params: { id: -1 }
        expect(response).to redirect_to root_path
      end
    end
  end


  describe "PUT update" do
    context "when product exists" do
      context "when it is successfully updated" do
        it "replies with 200 status code" do
          put :update, params: { id: existing_product.id, product: { name: 'Watermelon'} }, format: :json
          expect(response.status).to be(200)
        end
      end

      context "when couldn't update" do
        it "renders JSON with errors and 400 status code" do
          put :update, params: { id: existing_product.id, product: { price: -100 } }, format: :json
          expect(response.status).to be(400)
          expect(JSON.parse(response.body)['errors'].length).to be > 0
        end
      end
    end

    context "when product doesn't exist" do
      it "replies with 404 status code" do
        put :update, params: { id: -1 }, format: :json
        expect(response.status).to be(404)
      end
    end
  end


  describe "DELETE destroy" do
    context "when product exists" do
      it "destroys it and replies with 204 status code" do
        delete :destroy, params: { id: existing_product.id }
        expect(response.status).to be(204)
      end
    end

    context "when product doesn't exist" do
      it "replies with 404 status code" do
        delete :destroy, params: { id: -1 }
        expect(response.status).to be(404)
      end
    end
  end

end
