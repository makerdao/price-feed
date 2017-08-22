pragma solidity ^0.4.15;

import "ds-test/test.sol";

import "./DsPrice.sol";

contract DsPriceTest is DSTest {
    DsPrice price;

    function setUp() {
        price = new DsPrice();
    }

    function testFail_basic_sanity() {
        assert(false);
    }

    function test_basic_sanity() {
        assert(true);
    }
}
