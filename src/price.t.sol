/// price feed, with expiration and medianizer poke

// Copyright (C) 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

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

    function testPost() {
        p.post(2 ether, uint32(now) + 10, 0);
        
        assertEq(p.read(), 2 ether);
    }
    
    function testVoid() {
        p.post(1 ether, uint32(now) + 10, 0);

        assertEq(p.read(), 1 ether);
        
        p.void();
        var (, has) = p.peek();

        assert(!has);
    }
    
    function testFailInitialRead() {
        p.read();
    }
}
