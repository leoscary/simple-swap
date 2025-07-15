LAST UPDATED: 
I use the platform to update the latest TP3 data:

The transaction with hash [0xc0aae46581ab99dd0f4a91e9abe1ae7970a2f8f3ac35260805fc6066b79715a6](https://sepolia.etherscan.io/tx/0xc0aae46581ab99dd0f4a91e9abe1ae7970a2f8f3ac35260805fc6066b79715a6) successfully executed the verify function on the SwapVerifier contract ([0x9f8F02DAB384DDdf1591C3366069Da3Fb0018220](https://sepolia.etherscan.io/address/0x9f8F02DAB384DDdf1591C3366069Da3Fb0018220)).

This confirms that my SimpleSwap contract ([0x6bD1DD3b4879Df63A9328B4A082Fbc349B175649](https://sepolia.etherscan.io/address/0x6bD1DD3b4879Df63A9328B4A082Fbc349B175649)), in conjunction with my custom ERC-20 tokens, LeoscaryTokenA ([0x76799844273304F4A95568A42CEB84B09b5AEab3](https://sepolia.etherscan.io/address/0x76799844273304F4A95568A42CEB84B09b5AEab3)) and LeoscaryTokenB ([0x6a0f262a777a0e68403b5b6093634b3471f472ba](https://sepolia.etherscan.io/address/0x6a0f262a777a0e68403b5b6093634b3471f472ba)), is functioning correctly on the Sepolia network.

Key functionalities validated by the verify function include:

* **Token Transfers:** Confirmed that the SwapVerifier successfully received 1 unit of both LeoscaryTokenA and LeoscaryTokenB.

* **Allowance Mechanism:** The necessary ERC-20 allowances were correctly established, enabling SimpleSwap to move tokens on behalf of the SwapVerifier.

* **Liquidity Provision:** SimpleSwap successfully added liquidity using both Token A and Token B.

* **Price and Output Calculation:** The getPrice and getAmountOut functions performed as expected, demonstrating accurate calculations.

* **Token Swapping:** SimpleSwap successfully executed a token swap (swapExactTokensForTokens).

* **Liquidity Removal:** SimpleSwap was able to remove liquidity, completing the full cycle.

The successful outcome verifies the robustness and accuracy of the SimpleSwap implementation under the controlled conditions defined by the SwapVerifier.

Thank you.
------------------------------------------------------------------------------------------------------------------------------------

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
