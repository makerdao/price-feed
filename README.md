# Price-Feed

A price-feed contract is a ds-value like contract that stores its value as a wad, that is, a uint128 that is expected to be in 18 decimal fixed point notation. When read, it is read as a bytes32 to maintain compatibility with ds-value.

It implements `poke` but also `post` which in addition to updating its value, will `poke` a medianizer.
