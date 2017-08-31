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
        assertTrue(!has);
    }

    function testPost() {
        p.post(2 ether, uint32(now) + 10, 0);
        
        assertEq(p.read(), 2 ether);
    }
    
    function testVoid() {
        p.post(1 ether, uint32(now) + 10, 0);

        assertEq(p.read(), 1 ether);
        
        p.void();
        var (, has) = p.peek();

        assertTrue(!has);
    }
    
    function testFailInitialRead() {
        p.read();
    }
}
