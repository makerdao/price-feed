pragma solidity ^0.4.15;

import "ds-thing/thing.sol";

contract DSPrice is DSThing {

    uint128 val;
    uint32 public zzz;

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

    function post(uint128 val_, uint32 zzz_, address med_)
        note
        auth
    {
        val = val_;
        zzz = zzz_;
        med_.call(bytes4(sha3("poke()")));
    }

    function void()
        note
        auth
    {
        zzz = 0;
    }

}
