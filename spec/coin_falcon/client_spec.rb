RSpec.describe CoinFalcon::Client do
  subject { CoinFalcon::Client.new(ENV['CF_KEY'], ENV['CF_SECRET']) }

  let(:market) { 'ETH-BTC' }
  let(:order) { { market: market, operation_type: :limit_order, order_type: :buy, size: 1, price: 0.01 } }

  it 'fetches accounts' do
    response = subject.accounts
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'creates order' do
    response = subject.create_order(order)
    expect(response.code).to eq 201
    expect(response.body).not_to have_key('error')
  end

  it 'cancels order' do
    order_id = subject.create_order(order).body['data']['id']
    response = subject.cancel_order(order_id)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches my orders' do
    response = subject.my_orders
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches my trades' do
    response = subject.my_trades
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches deposit address for currency' do
    response = subject.deposit_address('btc')
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches deposit history' do
    response = subject.deposit_history
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  xit 'fetches deposit details' do
    deposit_id = subject.deposit_history.body['data'].first['id']
    response = subject.deposit_details(deposit_id)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  xit 'creates withdrawal' do
    withdrawal = { currency: :btc, address: 'mszGuGEdvkRsnFaTymW9LHiMan1qcPH4wn', amount: 0.01 }
    response = subject.create_withdrawal(withdrawal)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('message')
  end

  xit 'fetches withdrawal details' do
    withdrawal_id = nil
    response = subject.withdrawal_details(withdrawal_id)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches withdrawal history' do
    response = subject.withdrawal_history
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  xit 'cancels withdrawal' do
    withdrawal_id = nil
    response = subject.cancel_withdrawal(withdrawal_id)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches trades' do
    response = subject.trades(market)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end

  it 'fetches orderbook' do
    response = subject.orderbook(market)
    expect(response.code).to eq 200
    expect(response.body).not_to have_key('error')
  end
end
