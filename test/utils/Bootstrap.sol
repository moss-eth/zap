// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.20;

import {console2} from "lib/forge-std/src/console2.sol";
import {
    Zap,
    BaseGoerliParameters,
    BaseParameters,
    Setup
} from "script/Deploy.s.sol";
import {ZapEvents} from "./../../src/ZapEvents.sol";
import {Constants} from "./Constants.sol";
import {MockSpotMarketProxy} from "test/utils/mocks/MockSpotMarketProxy.sol";
import {MockUSDC} from "test/utils/mocks/MockUSDC.sol";
import {MockSUSD} from "test/utils/mocks/MockSUSD.sol";
import {SynthetixV3Errors} from "./errors/SynthetixV3Errors.sol";
import {Test} from "lib/forge-std/src/Test.sol";

contract Bootstrap is Test, ZapEvents, SynthetixV3Errors, Constants {
    using console2 for *;

    Zap internal zap;

    function initializeLocal() internal {
        BootstrapLocal bootstrap = new BootstrapLocal();
        (address zapAddress) = bootstrap.init();

        zap = Zap(zapAddress);
    }

    function initializeBase() internal {
        BootstrapBase bootstrap = new BootstrapBase();
        (address zapAddress) = bootstrap.init();

        zap = Zap(zapAddress);
    }

    function initializeBaseGoerli() internal {
        BootstrapBaseGoerli bootstrap = new BootstrapBaseGoerli();
        (address zapAddress) = bootstrap.init();

        zap = Zap(zapAddress);
    }
}

contract BootstrapLocal is Setup, Constants {
    function init() public returns (address zapAddress) {
        zapAddress = Setup.deploySystem(
            address(new MockUSDC()),
            address(new MockSUSD()),
            address(new MockSpotMarketProxy()),
            LOCAL_SUSDC_SPOT_MARKET_ID
        );
    }
}

contract BootstrapBase is Setup, BaseParameters {
    function init() public returns (address zapAddress) {
        zapAddress = Setup.deploySystem(
            USDC, USD_PROXY, SPOT_MARKET_PROXY, SUSDC_SPOT_MARKET_ID
        );
    }
}

contract BootstrapBaseGoerli is Setup, BaseGoerliParameters {
    function init() public returns (address zapAddress) {
        zapAddress = Setup.deploySystem(
            USDC, USD_PROXY, SPOT_MARKET_PROXY, SUSDC_SPOT_MARKET_ID
        );
    }
}
