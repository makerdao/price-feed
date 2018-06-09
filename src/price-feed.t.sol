/// price-feed.t.sol - tests for price-feed.sol

// Copyright (C) 2017, 2018  DappHub, LLC

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

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
