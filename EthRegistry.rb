
require "eth"

class EthRegistry
  
  def initialize rpc_client, contract_addr, key
    @rpc_client = rpc_client
    abi = <<ABI
[
	{
		"anonymous": false,
		"inputs": [
			{
				"indexed": false,
				"internalType": "address",
				"name": "addr",
				"type": "address"
			},
			{
				"indexed": false,
				"internalType": "bytes32",
				"name": "key",
				"type": "bytes32"
			},
			{
				"indexed": false,
				"internalType": "string",
				"name": "value",
				"type": "string"
			}
		],
		"name": "LogRegister",
		"type": "event"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "addr",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "key",
				"type": "bytes32"
			}
		],
		"name": "get",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "key",
				"type": "bytes32"
			}
		],
		"name": "get",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "bytes32",
				"name": "key",
				"type": "bytes32"
			},
			{
				"internalType": "string",
				"name": "value",
				"type": "string"
			}
		],
		"name": "register",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "address",
				"name": "",
				"type": "address"
			},
			{
				"internalType": "bytes32",
				"name": "",
				"type": "bytes32"
			}
		],
		"name": "registry",
		"outputs": [
			{
				"internalType": "string",
				"name": "",
				"type": "string"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
]
ABI
    @contract = Ethereum::Contract.create(client: rpc_client, name: "EthRegistry", address: contract_addr, abi: abi)
    if key != nil
      @contract.key = key
      @addr = key.address
    end
  end
  
  def get_own_entry key
    @contract.call.get__address__bytes32(@addr, key)
  end
  
  def get addr, key
    @contract.call.get__address__bytes32(addr, key)
  end
  
  def register key, content
    return false if ! @addr
    @contract.transact.register(key, content)
  end
  
end
