// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IERC20 {
    function transferFrom(address from, address to, uint amount) external returns (bool);
    function transfer(address to, uint amount) external returns (bool);
    function balanceOf(address account) external view returns (uint);
}

/// @title SimpleSwap - A basic token swap and liquidity pool contract similar to Uniswap V2
/// @author TuNombre
/// @notice This contract allows adding/removing liquidity and swapping tokens with price calculation
contract SimpleSwap {
    /// @notice Mapping of token reserves: reserves[tokenA][tokenB] => amount of tokenA paired with tokenB
    mapping(address => mapping(address => uint)) public reserves;

    /// @notice Adds liquidity to the token pair pool
    /// @param tokenA Address of token A
    /// @param tokenB Address of token B
    /// @param amountADesired Desired amount of token A to add
    /// @param amountBDesired Desired amount of token B to add
    /// @param amountAMin Minimum amount of token A acceptable (slippage protection)
    /// @param amountBMin Minimum amount of token B acceptable (slippage protection)
    /// @param to Address to receive liquidity tokens (simplified here)
    /// @param deadline Timestamp after which the transaction will revert
    /// @return amountA Actual amount of token A added
    /// @return amountB Actual amount of token B added
    /// @return liquidity Amount of liquidity tokens minted (simplified)
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity) {
        require(block.timestamp <= deadline, "Deadline passed");

        // Transfer tokens from user to contract
        IERC20(tokenA).transferFrom(msg.sender, address(this), amountADesired);
        IERC20(tokenB).transferFrom(msg.sender, address(this), amountBDesired);

        require(amountADesired >= amountAMin, "amountA < min");
        require(amountBDesired >= amountBMin, "amountB < min");

        // Update reserves
        reserves[tokenA][tokenB] += amountADesired;
        reserves[tokenB][tokenA] += amountBDesired;

        // Simplified liquidity calculation: sum of amounts
        liquidity = amountADesired + amountBDesired;
        amountA = amountADesired;
        amountB = amountBDesired;
    }

    /// @notice Removes liquidity from the token pair pool
    /// @param tokenA Address of token A
    /// @param tokenB Address of token B
    /// @param liquidity Amount of liquidity tokens to burn
    /// @param amountAMin Minimum amount of token A to receive
    /// @param amountBMin Minimum amount of token B to receive
    /// @param to Address to receive withdrawn tokens
    /// @param deadline Timestamp after which the transaction will revert
    /// @return amountA Amount of token A returned
    /// @return amountB Amount of token B returned
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint liquidity,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB) {
        require(block.timestamp <= deadline, "Deadline passed");

        uint reserveA = reserves[tokenA][tokenB];
        uint reserveB = reserves[tokenB][tokenA];

        // Calculate amounts proportional to liquidity burned
        amountA = (reserveA * liquidity) / (reserveA + reserveB);
        amountB = (reserveB * liquidity) / (reserveA + reserveB);

        require(amountA >= amountAMin, "amountA < min");
        require(amountB >= amountBMin, "amountB < min");

        // Update reserves
        reserves[tokenA][tokenB] -= amountA;
        reserves[tokenB][tokenA] -= amountB;

        // Transfer tokens to user
        IERC20(tokenA).transfer(to, amountA);
        IERC20(tokenB).transfer(to, amountB);
    }

    /// @notice Swaps an exact amount of input tokens for output tokens
    /// @param amountIn Amount of input tokens to swap
    /// @param amountOutMin Minimum amount of output tokens expected (slippage protection)
    /// @param path Array of two token addresses: [tokenIn, tokenOut]
    /// @param to Address to receive output tokens
    /// @param deadline Timestamp after which the transaction will revert
    /// @return amounts Array with input and output amounts
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts) {
        require(path.length == 2, "Only 2-token path allowed");
        require(block.timestamp <= deadline, "Deadline passed");

        address tokenIn = path[0];
        address tokenOut = path[1];

        uint reserveIn = reserves[tokenIn][tokenOut];
        uint reserveOut = reserves[tokenOut][tokenIn];

        // Transfer input tokens from user
        IERC20(tokenIn).transferFrom(msg.sender, address(this), amountIn);
        reserves[tokenIn][tokenOut] += amountIn;

        // Calculate output amount based on reserves and fee
        uint amountOut = getAmountOut(amountIn, reserveIn, reserveOut);
        require(amountOut >= amountOutMin, "Slippage: amountOut < min");

        reserves[tokenOut][tokenIn] -= amountOut;
        IERC20(tokenOut).transfer(to, amountOut);

        
        // Create a new array of size 2 to store input and output amounts
        // Assign values to the array
        amounts[0] = amountIn;
        amounts[1] = amountOut;
    }

    /// @notice Returns the price of tokenA in terms of tokenB (scaled by 1e18)
    /// @param tokenA Address of token A
    /// @param tokenB Address of token B
    /// @return price Price of tokenA denominated in tokenB
    function getPrice(address tokenA, address tokenB) external view returns (uint price) {
        uint reserveA = reserves[tokenA][tokenB];
        uint reserveB = reserves[tokenB][tokenA];
        require(reserveA > 0 && reserveB > 0, "Insufficient liquidity");
        price = (reserveB * 1e18) / reserveA; // tokenB per tokenA
    }

    /// @notice Calculates output amount of tokens for a given input amount and reserves, factoring 0.3% fee
    /// @param amountIn Input amount of tokens
    /// @param reserveIn Reserve of input token
    /// @param reserveOut Reserve of output token
    /// @return amountOut Amount of output tokens to receive
    function getAmountOut(uint amountIn, uint reserveIn, uint reserveOut) public pure returns (uint amountOut) {
        require(reserveIn > 0 && reserveOut > 0, "Invalid reserves");
        uint amountInWithFee = amountIn * 997; // 0.3% fee
        uint numerator = amountInWithFee * reserveOut;
        uint denominator = (reserveIn * 1000) + amountInWithFee;
        amountOut = numerator / denominator;
    }
}
