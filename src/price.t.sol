pragma solidity ^0.4.15;

import "ds-test/test.sol";

import "./price.sol";

contract DSPriceTest is DSTest {
    DSPrice p;

    function setUp() {
        p = new DSPrice();
    }

    function testInitial() {
        var (val, has) = p.peek();
        
        assertEq(val, 0);
        assert(!has);
    }

    function testProd() {
        p.prod(2 ether, uint32(now) + 10);
        
        assertEq(p.read(), 2 ether);
    }
    
    function testVoid() {
        p.prod(1 ether, uint32(now) + 10);

        assertEq(p.read(), 1 ether);
        
        p.void();
        var (, has) = p.peek();

        assert(!has);
    }

    function testFailInitialRead() {
        p.read();
    }
}
