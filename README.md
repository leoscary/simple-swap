# simpleswap
Ethereum SimpleSwap Smart Contract Project for Final Assignment - Module III
This project implements a smart contract named **SimpleSwap**, which replicates core functionalities of Uniswap V2:
- Add liquidity to a token pair pool
- Remove liquidity
- Swap exact tokens
- Get token price based on reserves
- Calculate expected output amount using reserves

## Deployed Contract on Sepolia

**Contract Address:**  
Contract is verified and published on Etherscan
[0xCA17539F40d1b7650C4251D7B6b064ac23818A42](https://sepolia.etherscan.io/address/0xCA17539F40d1b7650C4251D7B6b064ac23818A42#code)

## Tools Used

- Remix IDE (for development and deployment)
- Etherscan (for verification)
- Visual Studio Code (for code editing)
- MetaMask (for contract interaction)
- DeepL (for traduction)
  
## Technical Overview

SimpleSwap enables any user to:

1. Add liquidity: Deposit two ERC-20 tokens and store the pair’s reserves.
2. Remove liquidity: Withdraw tokens proportionally based on liquidity provided.
3. Swap exact tokens: Perform token swaps using Uniswap’s constant product formula.
4. Get token price: Retrieve tokenA price in terms of tokenB.
5. Calculate output amount: Use reserves to compute expected token output.

This contract handles liquidity and swaps internally, without requiring external Router or Factory contracts.

## Notes

- Compiled with Solidity version 0.8.18
- Optimization enabled (200 runs), as required by the assignment
- No unit tests included, but the contract was manually tested via Remix

Developed by: Leoscary Castillo
Submitted as the final project for Module III of Ethereum Developer Pack Program.
