# EthRegistry
This repo contains a solidity file, with the source code for a simple registry (name-value). Everybody can write there in his namespace.
In the ruby files is a simple program that allows to interact with the smart contract.
The following gems are needed:
- fxruby
- eth
- ethereum.rb

Execute with:
```
ruby main.rb
```

## Contract addresses
| Blockchain                   | Contract                                         |
|------------------------------|--------------------------------------------------|
| cheapETH                     | ```0x735954982e500db6809792dec536684ffd2bb0d6``` |
| devETH                       | ```0x8b0d3Bb22df3420FFf61Fd4B24b89C908aB60cb6``` |
| KuCoin Community Chain (KCC) | ```0x91aa912ba3fba5983df77b5d5b194a05704574fb``` |
| Polygon                      | ```0x79280ea1de810cb0678396153cc8511d9c3e6626``` |
| Binance Smart Chain (BSC)    | ```0x4E30DDcAa6c2D59809bDf96Cc8109f222c25fD15``` |
| Avalanche C-Chain            | ```0x8b0d3Bb22df3420FFf61Fd4B24b89C908aB60cb6``` |
| Fantom                       | ```0x8b0d3Bb22df3420FFf61Fd4B24b89C908aB60cb6``` |
| bloxberg                     | ```0xC92a2CCfF02B3785A518808BbfC1C8e097216a35``` |
| xDAI Chain                   | ```0x8b0d3Bb22df3420FFf61Fd4B24b89C908aB60cb6``` |
| Polis Olympus                | ```0x71c16A82aeF871A89de2d0559804ca6DcE0603D5``` |
| Harmony ONE                  | ```0x8b0d3Bb22df3420FFf61Fd4B24b89C908aB60cb6``` |

Entries are **not** synced between blockchains.
Contract uploaded from ```0x055860064Ec3824172da977b021224C057307a28```.

## Change Blockchain
For this purpose two lines have to be edited. Once the line for the Smart Contract and once the line with the RPC interface.

main.rb line 6:
```
$contract_addr = "[Contract address (see above)]"
```

CheapEth.rb line 10:
```
@rpc_client = Ethereum::HttpClient.new("[RPC url]")
```
