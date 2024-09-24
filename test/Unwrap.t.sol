// SPDX-License-Identifier: MIT
pragma solidity 0.8.27;

import {
    Bootstrap,
    Constants,
    ICore,
    IERC20,
    IPerpsMarket,
    IPool,
    ISpotMarket,
    Test,
    Zap
} from "./utils/Bootstrap.sol";

contract UnwrapTest is Bootstrap {

    function test_unwrap_base(uint32 amount) public base {
        _spin(ACTOR, usdc, amount, address(zap));
        vm.startPrank(ACTOR);
        uint256 wrapped = zap.wrap({
            _token: address(usdc),
            _synthId: zap.SUSDC_SPOT_ID(),
            _amount: amount,
            _tolerance: DEFAULT_TOLERANCE,
            _receiver: ACTOR
        });
        assertEq(usdc.balanceOf(ACTOR), 0);
        assertGe(susdc.balanceOf(ACTOR), DEFAULT_TOLERANCE);
        susdc.approve(address(zap), type(uint256).max);
        uint256 unwrapped = zap.unwrap({
            _token: address(usdc),
            _synthId: zap.SUSDC_SPOT_ID(),
            _amount: wrapped,
            _tolerance: DEFAULT_TOLERANCE,
            _receiver: ACTOR
        });
        vm.stopPrank();
        assertGe(unwrapped, DEFAULT_TOLERANCE);
        assertEq(usdc.balanceOf(ACTOR), amount);
        assertEq(susdc.balanceOf(ACTOR), 0);
    }

    function test_unwrap_arbitrum(uint32 amount) public arbitrum {
        _spin(ACTOR, usdc, amount, address(zap));
        vm.startPrank(ACTOR);
        uint256 wrapped = zap.wrap({
            _token: address(usdc),
            _synthId: zap.SUSDC_SPOT_ID(),
            _amount: amount,
            _tolerance: DEFAULT_TOLERANCE,
            _receiver: ACTOR
        });
        assertEq(usdc.balanceOf(ACTOR), 0);
        assertGe(susdc.balanceOf(ACTOR), DEFAULT_TOLERANCE);
        susdc.approve(address(zap), type(uint256).max);
        uint256 unwrapped = zap.unwrap({
            _token: address(usdc),
            _synthId: zap.SUSDC_SPOT_ID(),
            _amount: wrapped,
            _tolerance: DEFAULT_TOLERANCE,
            _receiver: ACTOR
        });
        vm.stopPrank();
        assertGe(unwrapped, DEFAULT_TOLERANCE);
        assertEq(usdc.balanceOf(ACTOR), amount);
        assertEq(susdc.balanceOf(ACTOR), 0);
    }

}
