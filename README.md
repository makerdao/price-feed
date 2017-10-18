Price-Feed

A price-feed contract is basically a ds-cache that stores its value as a wad, that is, a uint128 that is expected to be in 18 decimal fixed point notation. When read, it is read as a bytes32 to maintaing compatibility with ds-value and ds-cache.

It also