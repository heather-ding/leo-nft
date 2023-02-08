# nft.aleo
Note: The most recent commit is waiting on mapping functionality to be approved.

## Implementation

In this, we implemented minting an NFT with hidden fields on the Aleo chain. NFTs with hidden attributes can be transfered to publically known addresses, they can also be transferred to hidden addresses.  


## Usage For Commit Hash 9cf6b4888139e6febaf72cbff416f6978eda79f7

To mint a new NFT with private fields, run:
```bash
leo run mint_private aleo10f7vqg5kjv55dvvml67d05c3vg0suuzplxrnudkf8h4hn7n3wcyq53yxat "{half1: 2u128, half2: 2u128}"
```

To transfer your NFT, run:
```bash
leo run transfer_private "{
  owner: aleo10f7vqg5kjv55dvvml67d05c3vg0suuzplxrnudkf8h4hn7n3wcyq53yxat.private,
  gates: 0u64.private,
  data: {
    half1: 2u128.private,
    half2: 2u128.private
  },
  _nonce: 6492031523821407638452793268494938550458311991250882193634864418342811139417group.public
}" aleo12y8ke8xcfejg3kjapatr730rwxf6thdzcgxhhpmyvsnw5mfrzcfqktnp3l
```
