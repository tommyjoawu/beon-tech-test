require 'rails_helper'

RSpec.describe "API Users", type: :request do

  RSpec.shared_context 'with multiple companies' do
    let!(:company_1) { create(:company) }
    let!(:company_2) { create(:company) }

    before do
      5.times do
        create(:user, company: company_1)
      end
      5.times do
        create(:user, company: company_2)
      end
    end
  end

  describe "#index" do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'

      it 'returns only the users for the specified company' do
        get api_users_path(company_id: company_1)
        
        expect(result.size).to eq(company_1.users.size)
        expect(result.map { |element| element['id'] } ).to eq(company_1.users.ids)
      end
    end
  end
end
