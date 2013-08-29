require_relative '../../spec_helper'
require 'securerandom'

describe MangoPay::Client do
  include_context 'clients'

  describe 'CREATE' do
    it 'creates a new client' do
      expect(new_client['ClientId']).to eq(client_id)
      expect(new_client['Email']).not_to be_nil
      expect(new_client['Passphrase']).not_to be_nil
    end

    it 'refuses the client id' do
      expect(wrong_client['errors']).not_to be_nil
    end

    it "ClientId_already_exist" do
      existing_client = MangoPay::Client.create({
        'ClientId' => new_client['ClientId'],
        'Name' => 'What a nice name'
      })
      expect(existing_client['Type']).to eq('ClientId_already_exist')
      expect(existing_client['Message']).to eq('A partner with this ClientId already exist')
    end
  end
end