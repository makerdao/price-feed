pragma solidity ^0.4.15;

import 'ds-thing/thing.sol';

contract DSPrice is DSThing {

    uint128 public val;
    uint32 public zzz;
    bool has;
    address med;

    function setMed(address med_)
        note
        auth
    {
        med = med_;
    }

    function poke(uint128 val_)
        note
        auth
    {
        val = val_;
        zzz = uint32(-1);
        has = true;
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
        has = true;
        if (med > 0x0) {
            assert(med.call(bytes4(sha3("poke()"))));
        }
    }

    function void()
        note
        auth
    {
        has = false;
    }

    function peek()
        constant
        returns (uint128,bool)
    {
        return (val, has && now < zzz);
    }

    function read()
        constant
        returns (uint128)
    {
        assert(has && now < zzz);
        return val;
    }
}

contract Medianizer is DSThing {
    mapping (bytes12 => address) public values;
    mapping (address => bytes12) public indexes;
    bytes12 public next = 0x1;
    uint96 public min = 0x1;

    uint128 public val;
    bool has;

    function set(address wat) auth {
        bytes12 nextId = bytes12(uint96(next) + 1);
        assert(nextId != 0x0);
        this.set(next, wat);
        next = nextId;
    }

    function set(bytes12 pos, address wat) note auth {
        require(pos != 0x0);
        require(wat == 0 || indexes[wat] == 0);

        indexes[values[pos]] = 0x0; // Making sure to remove a possible existing address in that position

        if (wat != 0) {
            indexes[wat] = pos;
        }

        values[pos] = wat;
    }

    function setMin(uint96 min_) note auth {
        require(min_ != 0x0);
        min = min_;
    }

    function setNext(bytes12 next_) note auth {
        require(next_ != 0x0);
        next = next_;
    }

    function unset(bytes12 pos) auth {
        this.set(pos, 0);
    }

    function unset(address wat) auth {
        this.set(indexes[wat], 0);
    }

    function poke() {
        (val, has) = compute();
        this.poke(val);
    }

    function poke(uint128) note {}

    function peek()
        constant
        returns (uint128,bool)
    {
        return (val, has);
    }

    function read()
        constant
        returns (uint128)
    {
        assert(has);
        return val;
    }

    function compute() constant returns (uint128, bool) {
        uint128[] memory wuts = new uint128[](uint96(next) - 1);
        uint96 ctr = 0;
        for (uint96 i = 1; i < uint96(next); i++) {
            if (values[bytes12(i)] != 0) {
                var (wut, wuz) = DSPrice(values[bytes12(i)]).peek();
                if (wuz) {
                    if (ctr == 0 || wut >= wuts[ctr - 1]) {
                        wuts[ctr] = wut;
                    } else {
                        uint96 j = 0;
                        while (wut >= wuts[j]) {
                            j++;
                        }
                        for (uint96 k = ctr; k > j; k--) {
                            wuts[k] = wuts[k - 1];
                        }
                        wuts[j] = wut;
                    }
                    ctr++;
                }
            }
        }

        if (ctr < min) {
            return (val, false);
        }

        uint128 value;
        if (ctr % 2 == 0) {
            uint128 val1 = wuts[(ctr / 2) - 1];
            uint128 val2 = wuts[ctr / 2];
            value = wdiv(hadd(val1, val2), 2 ether);
        } else {
            value = wuts[(ctr - 1) / 2];
        }

        return (value, true);
    }

}

