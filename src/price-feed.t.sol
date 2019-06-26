pragma solidity ^0.4.23;

import "ds-test/test.sol";

import "./price-feed.sol";

contract MedianizerTest is Medianizer {
    uint128     val;
    bool public has;
    function poke() external {
        val = 1;
        has = true;
    }
}

contract PriceFeedTest is DSTest {
    PriceFeed p;
    MedianizerTest m;

    function setUp() public {
        p = new PriceFeed();
        m = new MedianizerTest();
    }

    function testInitial() public {
        bytes32 val;
        bool has;
        (val, has) = p.peek();
        
        assertEq(val, 0);
        assertTrue(!has);
    }

    function testPoke() public {
        p.poke(2 ether, uint32(now) + 10);
        
        assertEq(p.read(), 2 ether);
    }

    function testPost() public {
        p.post(2 ether, uint32(now) + 10, m);
        
        assertEq(p.read(), 2 ether);
    }
    
    function testVoid() public {
        p.poke(1 ether, uint32(now) + 10);

        assertEq(p.read(), 1 ether);
        
        p.void();
        bool has;
        (, has) = p.peek();

        assertTrue(!has);
    }
    
    function testFailInitialRead() public view {
        p.read();
    }
}
