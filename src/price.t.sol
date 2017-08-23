pragma solidity ^0.4.15;

import "ds-test/test.sol";

import "./price.sol";

contract DSPriceTest is DSTest {
    Medianizer m;
    DSPrice p1;
    DSPrice p2;
    DSPrice p3;

    function setUp() {
        m = new Medianizer();
        p1 = new DSPrice();
        p2 = new DSPrice();
        p3 = new DSPrice();
        m.set(p1);
        m.set(p2);
        m.set(p3);
        // p1.prod(1 ether, uint32(now) + 100);
        // p2.prod(2 ether, uint32(now) + 100);
        // p3.prod(3 ether, uint32(now) + 100);
        p1.poke(1 ether);
        p2.poke(2.5 ether);
        p3.setMed(m);
    }

    function testPoke() logs_gas {
        //p2.prod(3 ether, uint32(now) + 100);
        p3.poke(5 ether);
        var (val, has) = m.peek();
        assertEq(uint256(val), 2 ether);
        assert(has);
        assert(false);
    }

    // function testProd() logs_gas {
    //     p1.prod(1 ether, uint32(now) + 10);
    //     assert(false);
    // }
}