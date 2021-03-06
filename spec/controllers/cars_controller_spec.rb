require 'rails_helper'

RSpec.describe CarsController, type: :controller do
  before(:all) do
    @dealership = Dealership.create(name: 'Stuff', inventory: '1000')
  end

  describe "GET #index" do
    it "returns http success" do
      get :index, dealership_id: @dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the index template" do
      get :index, dealership_id: @dealership.id
      expect(response).to render_template(:index)
    end

    it "sets the cars instance variable" do
      get :index, dealership_id: @dealership.id
      expect(assigns(:cars)).to eq([])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, dealership_id: @dealership.id
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new, dealership_id: @dealership.id
      expect(response).to render_template(:new)
    end

    it "sets the new instance variable" do
      get :new, dealership_id: @dealership.id
      expect(assigns(:car)).to_not eq(nil)
      expect(assigns(:car).id).to eq(nil)
    end
  end

  describe "GET #show" do
    before(:each) do
      @car = @dealership.cars.create(make: 'Toyota', design: 'Supra', year: '1996')
    end

    it "returns http success" do
      get :show, dealership_id: @dealership.id, id: @car.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, dealership_id: @dealership.id, id: @car.id
      expect(response).to render_template(:show)
    end

    it "sets the car instance variable" do
      get :show, dealership_id: @dealership.id, id: @car.id
      expect(assigns(:car).design).to eq(@car.design)
    end
  end

  describe "POST #create" do
    before(:all) do
      @car_params = { car: { make: 'Honda', design: 'Civic', year: '1995', dealership_id: @dealership.id }}
    end

    describe "success" do
      it "sets the car instance variable" do
        post :create, @car_params.merge(dealership_id: @dealership.id)
        expect(assigns(:car)).to_not eq(nil)
        expect(assigns(:car).design).to eq(@car_params[:car][:design])
      end

      it "creates a new car" do
        expect(@dealership.cars.count).to eq(0)
        post :create, @car_params.merge(dealership_id: @dealership.id)
        expect(@dealership.cars.count).to eq(1)
        expect(@dealership.cars.first.design).to eq(@car_params[:car][:design])
      end

      it "sets the flash message on success" do
        post :create, @car_params.merge(dealership_id: @dealership.id)
        expect(flash[:success]).to eq('Car Created')
      end
    end

    describe "failure" do
      it 'renders new on failure' do
        car2 = { car: { make: 'None' }}
        post :create, car2.merge(dealership_id: @dealership.id)
        expect(response).to render_template(:new)
      end
    end
  end

  describe "GET #edit" do
    before(:each) do
      @car = @dealership.cars.create(make: 'Toyota', design: 'Supra', year: '1996')
    end
    it "returns http success" do
      get :edit, dealership_id: @dealership.id, id: @car.id
      expect(response).to have_http_status(:success)
    end

    it "renders the edit template" do
      get :edit, dealership_id: @dealership.id, id: @car.id
      expect(response).to render_template(:edit)
    end

    it "sets the car instance variable" do
      get :edit, dealership_id: @dealership.id, id: @car.id
      expect(assigns(:car).id).to eq(@car.id)
    end
  end

  describe 'PUT #update' do
    before(:each) do
      @car = @dealership.cars.create(make: 'Toyota', design: 'Supra', year: '1996')
    end

    describe 'successes' do
      it 'sets the car instance variable' do
        put :update, { dealership_id: @dealership.id, id: @car.id, car: { design: 'Supra' }}
        expect(assigns(:car).id).to eq(@car.id)
      end

      it 'updates the car' do
        put :update, { dealership_id: @dealership.id, id: @car.id, car: { design: 'Supra' }}
        expect(@car.reload.design).to eq('Supra')
      end

      it 'sets flash message on success' do
        put :update, { dealership_id: @dealership.id, id: @car.id, car: { design: 'Carolla' }}
        expect(flash[:success]).to eq('Car Updated')
      end

      it 'redirects to show on success' do
        put :update, { dealership_id: @dealership.id, id: @car.id, car: { design: 'Accord' }}
        expect(response).to redirect_to(dealership_car_path(@dealership.id, @car.id))
      end
    end
      describe 'failures' do
      it 'renders edit on fail' do
        put :update, { dealership_id: @dealership.id, id: @car.id, car: { design: nil }}
        expect(response).to render_template(:edit)
      end
    end
  end

end
