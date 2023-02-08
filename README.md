# nft.aleo

## Build Guide

To compile this Aleo program, run:
```bash

leo run mint_private aleo10f7vqg5kjv55dvvml67d05c3vg0suuzplxrnudkf8h4hn7n3wcyq53yxat "{half1: 2u128, half2: 2u128}"
leo run transfer private "{
  owner: aleo10f7vqg5kjv55dvvml67d05c3vg0suuzplxrnudkf8h4hn7n3wcyq53yxat.private,
  gates: 0u64.private,
  data: {
    half1: 2u128.private,
    half2: 2u128.private
  },
  _nonce: 6492031523821407638452793268494938550458311991250882193634864418342811139417group.public
}" aleo12y8ke8xcfejg3kjapatr730rwxf6thdzcgxhhpmyvsnw5mfrzcfqktnp3l
```
