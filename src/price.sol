/// price feed, with optional expiration and medianizer poke

// Copyright (C) 2017  DappHub, LLC

// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND (express or implied).

pragma solidity ^0.4.15;

import "ds-thing/thing.sol";

contract DSPrice is DSThing {

    uint128 public val;
    uint32 public zzz;
    address med;

    function tell(address med_)
        note
        auth
    {
        med = med_;
    }

    function peek()
        constant
        returns (bytes32,bool)
    {
        return (bytes32(val), now < zzz);
    }

    function read()
        constant
        returns (bytes32)
    {
        assert(now < zzz);
        return bytes32(val);
    }
    
    function poke(uint128 val_)
        note
        auth
    {
        val = val_;
        if (zzz < uint32(-1)) {
            zzz = uint32(-1);
        }
        if (med > 0x0) {
            assert(med.call(bytes4(sha3("poke()"))));
        }
    }

    function prod(uint128 val_, uint32 zzz_)
        note
        auth
    {
        val = val_;
        zzz = zzz_;
        if (med > 0x0) {
            assert(med.call(bytes4(sha3("poke()"))));
        }
    }

    function void()
        note
        auth
    {
        zzz = uint32(0);
    }

}
