// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {BaseHook} from "v4-periphery/src/utils/BaseHook.sol";
import {ERC1155} from "solmate/src/tokens/ERC1155.sol";

import {Currency} from "v4-core/types/Currency.sol";
import {PoolKey} from "v4-core/types/PoolKey.sol";
import {PoolId} from "v4-core/types/PoolId.sol";
import {BalanceDelta} from "v4-core/types/BalanceDelta.sol";
import {SwapParams, ModifyLiquidityParams} from "v4-core/types/PoolOperation.sol";

import {IPoolManager} from "v4-core/interfaces/IPoolManager.sol";

import {Hooks} from "v4-core/libraries/Hooks.sol";

contract PointsHook is BaseHook, ERC1155 {
    /**
     * @notice Deploys the PointsHook contract and registers it with the PoolManager
     * @dev Pass the PoolManager address to the BaseHook constructor
     * @param _poolmanager IPoolManager The address of the PoolManager contract
     */
    constructor(IPoolManager _poolmanager) BaseHook(_poolmanager) {}

    // Set up permission for hook
    /**
     * @notice Specifies which hooks this contract implements and their permissions
     * @dev Overrides the getHookPermissions function from BaseHook
     * @return Hooks.Permissions A struct indicating which hooks are implemented
     */
    function getHookPermissions()
        public
        pure
        override
        returns (Hooks.Permissions memory)
    {
        return
            Hooks.Permissions({
                beforeInitialize: false,
                afterInitialize: false,
                beforeAddLiquidity: false,
                beforeRemoveLiquidity: false,
                afterAddLiquidity: false,
                afterRemoveLiquidity: false,
                beforeSwap: false,
                afterSwap: true,
                beforeDonate: false,
                afterDonate: false,
                beforeSwapReturnDelta: false,
                afterSwapReturnDelta: false,
                afterAddLiquidityReturnDelta: false,
                afterRemoveLiquidityReturnDelta: false
            });
    }

    /**
     * @notice Returns the metadata URI template for ERC-1155 tokens.
     * @return A URI string containing the "{id}" placeholder.
     *
     */
    function uri(uint256) public view virtual override returns (string memory) {
        return "my:uri:{id}";
    }

    // Stub for active hook -> afterswap

    function _afterSwap(
        address,
        PoolKey calldata key,
        SwapParams calldata swapParams,
        BalanceDelta delta,
        bytes calldata hookData
    ) internal override returns (bytes4, int128) {
        return (this.afterSwap.selector, 0);
    }
}
