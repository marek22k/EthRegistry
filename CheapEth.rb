
require "ethereum.rb"
require "eth"

class CheapEth
  
  attr_reader :rpc_client
  
  def initialize
    @rpc_client = Ethereum::HttpClient.new("https://rpc.cheapeth.org/rpc")
    @rpc_client.gas_price = @rpc_client.eth_gas_price["result"].to_i(16)
  end
  
  def gas_price
    @rpc_client.gas_price/1.0/(10**18)
  end
  
  def get_current_block
    @rpc_client.eth_block_number["result"].to_i 16
  end
  
  def get_balance_of addr
    @rpc_client.get_balance(addr)/1.0/(10**18)
  end
  
  def get_nonce_of addr
    @rpc_client.get_nonce addr
  end
  
end
