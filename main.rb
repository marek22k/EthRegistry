
require_relative "EthRegistry.rb"
require_relative "CheapEth.rb"
require_relative "gui.rb"

$contract_addr = "0x735954982e500db6809792dec536684ffd2bb0d6"


cheap_eth = CheapEth.new

app = Fox::FXApp.new
main = MainWindow.new app, cheap_eth
app.create
app.run
