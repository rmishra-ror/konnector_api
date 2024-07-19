require 'rails_helper'

RSpec.describe "Users API", type: :request do
  let!(:users) do
    [
      User.create(name: "John", email: "john@gmail.com",
                  campaigns_list: [{ "campaign_name": "cam1", "campaign_id": "id1" },
                                   { "campaign_name": "cam2", "campaign_id": "id2" }]),
      User.create(name: "Jane", email: "jane@gmail.com",
                  campaigns_list: [{ "campaign_name": "cam1", "campaign_id": "id1" },
                                   { "campaign_name": "cam3", "campaign_id": "id3" }])
    ]
  end
  let(:user_id) { users.first.id }

  describe 'GET /users' do
    before { get '/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json.size).to eq(2)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) do
      { name: 'Alice', email: 'alice@gmail.com', campaigns_list: [{ "campaign_name": "cam4", "campaign_id": "id4" }] }
    end

    context 'when the request is valid' do
      before { post '/users', params: valid_attributes }

      it 'creates a user' do
        expect(json['name']).to eq('Alice')
        expect(json['email']).to eq('alice@gmail.com')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: { name: 'Foobar' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        resp = JSON.parse(response.body)
        expect(resp["email"]).to include("can't be blank", "is invalid")
        expect(resp["campaigns_list"]).to include("can't be blank")
      end
    end
  end

  describe 'GET /users/filter' do
    context 'when the request is valid' do
      before { get '/users/filter', params: { campaign_names: 'cam1,cam2' } }

      it 'returns users matching campaign names' do
        expect(json).not_to be_empty
        expect(json.size).to eq(2)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when campaign_names parameter is missing' do
      before { get '/users/filter' }

      it 'returns a validation error' do
        expect(response).to have_http_status(:bad_request)
        expect(json['error']).to match(/campaign_names parameter is required/)
      end
    end

    context 'when campaign_names parameter is not a string' do
      before { get '/users/filter', params: { campaign_names: { cam1: "cam1", cam2: "cam2" } } }

      it 'returns a validation error' do
        expect(response).to have_http_status(:bad_request)
        expect(json['error']).to match(/campaign_names parameter must be a comma-separated string/)
      end
    end
  end
end

def json
  JSON.parse(response.body)
end
