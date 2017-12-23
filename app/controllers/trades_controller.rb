class TradesController < ApplicationController

  def index
    @trades = Trade.all
  end

  def show
  end

  def check_trades
    x = 600
    x.times do
      begin
        liqui_response = HTTParty.get('https://api.liqui.io/api/3/depth/omg_eth?limit=10')
      rescue Errno::ETIMEDOUT, Net::OpenTimeout
        puts "poloniex rescue"
        retry
      end
      begin
        poloniex_response = HTTParty.get('https://poloniex.com/public?command=returnOrderBook&currencyPair=ETH_OMG&depth=10')
      rescue Errno::ETIMEDOUT, Net::OpenTimeout
        puts "poloniex rescue"
        retry
      end
      puts "///// #{x} ///////"
      x -= 1;
      Trade.check_trades(liqui_response, poloniex_response)

      sleep(rand(5..9))
    end
  end
end
