require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
    it "instantiates a new product instance variable" do
      get :new
      expect(assigns(:product)).to be_a_new(Product)
    end
  end

  describe "#create" do
    context "with valid parameters" do
      def valid_product
        post :create, params:{ product: {title: 'this valid title',
        description: 'Long enough description',
        price: 100}
        }
      end
    it 'saves a record to the database' do
      count_before = Product.count
      valid_product
      count_after = Product.count
      expect(count_after).to eq(count_before+1)
    end
    it 'redirects to the product show page' do
      valid_product
      expect(response).to redirect_to(product_path(Product.last))
    end
    it 'sets a flash message' do
      valid_product
      expect(flash[:notice]).to be
    end

  end
    context 'with invalid parameters' do
      def invalid_product
        post :create, params: {product: {title: '', description: 'das', price: -1}}
      end
      it "doesn't save the record to the database" do
        count_before = Product.count
        invalid_product
        count_after = Product.count
        expect(count_after).to eq(count_before)
      end
      it 'renders the new template' do
        invalid_product
        expect(response).to render_template(:new)
      end
    end
end

describe '#show' do
  it 'renders the show template' do
    product = FactoryGirl.create(:product)
    get :show, params: {id: product.id}
    expect(response).to render_template(:show)
  end
  it 'defines an instance variable for product based on passed id' do
    product = FactoryGirl.create(:product)
    get :show, params: {id: product.id}
    expect(assigns(:product)).to eq(product)
  end
end

describe '#edit' do
  it 'defines an instance variable for product based on passed id' do
    product = FactoryGirl.create(:product)
    get :show, params: {id: product.id}
    expect(assigns(:product)).to eq(product)
  end
end

describe '#update' do
  context "with valid parameters" do
    def valid_product
      post :create, params:{ product: {title: 'this valid title',
      description: 'Long enough description',
      price: 100}
      }
    end
  it 'saves a record to the database' do
    count_before = Product.count
    valid_product
    count_after = Product.count
    expect(count_after).to eq(count_before+1)
  end
  it 'redirects to the product show page' do
    valid_product
    expect(response).to redirect_to(product_path(Product.last))
  end
end
end

describe '#index' do
  it 'renders index template' do
    get :index
    expect(response).to render_template(:index)
  end

  it 'defines an instance variable for all products' do
    product = FactoryGirl.create(:product)
    product1 = FactoryGirl.create(:product)
    get :index
    expect(assigns(:products)).to eq([product, product1])
  end
end
end
