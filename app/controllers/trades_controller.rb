class TradesController < ApplicationController

  def index
    @trades = Trade.all
  end

  def show
  end

  def check_trades
    50.times do
      liqui_response = HTTParty.get('https://api.liqui.io/api/3/depth/omg_eth?limit=10')
      poloniex_response = HTTParty.get('https://poloniex.com/public?command=returnOrderBook&currencyPair=ETH_OMG&depth=10')
      puts "working"

      Trade.check_trades(liqui_response, poloniex_response)

      sleep(rand(5..9))
    end
  end
end
