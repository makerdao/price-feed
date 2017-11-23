pragma solidity ^0.4.15;

import "ds-test/test.sol";

import "./price-feed.sol";

contract PriceFeedTest is DSTest {
    PriceFeed p;

    function setUp() public {
        p = new PriceFeed();
    }

    function testInitial() public {
        var (val, has) = p.peek();
        
        assertEq(val, 0);
        assertTrue(!has);
    }

    function testPoke() public {
        p.poke(2 ether, uint32(now) + 10);
        
        assertEq(p.read(), 2 ether);
    }

    function testPost() public {
        p.post(2 ether, uint32(now) + 10, 0);
        
        assertEq(p.read(), 2 ether);
    }
    
    function testVoid() public {
        p.post(1 ether, uint32(now) + 10, 0);

        assertEq(p.read(), 1 ether);
        
        p.void();
        var (, has) = p.peek();

        assertTrue(!has);
    }
    
    function testFailInitialRead() public view {
        p.read();
    }
}
