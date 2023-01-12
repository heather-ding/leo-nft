const COLLECTION_OWNER: address = aleo1ezamst4pjgj9zfxqq0fwfj8a4cjuqndmasgata3hggzqygggnyfq6kmyd4;

// The 'nft' program.
program nft.aleo {
    // Owner refers to the creator of the NFT.
    record NftOwnershipInstance {
        owner: address,
        gates: u64,
        data: NftData,
    }

    record NftReceipt {
        owner: address,
        gates: u64,
        nft_owner: address
    }

    struct NftData {
        half1: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
        half2: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature

        metadata: u128 // Arbitrary 128-bytes of metadata.
    }

    // Privately mints an NFT with 'data' for the reciever.
    transition mint_private(receiver: address, data: NftData) -> (NftOwnershipInstance, NftReceipt) {
        assert_eq(self.caller, COLLECTION_OWNER);

        let owner: NftOwnershipInstance = NftOwnershipInstance {
            owner: receiver,
            gates: 0u64,
            data: data
        };

        let creator: NftReceipt = NftReceipt {
            owner: COLLECTION_OWNER,
            gates: 0u64,
            nft_owner: receiver
        };

        return (owner, creator);
    }

    // Modifies an NFTs data
    transition modify_data(creator: NftReceipt, new_data: NftData) -> NftOwnershipInstance {
        return NftOwnershipInstance {
            owner: creator.nft_owner,
            gates: 0u64,
            data: new_data
        };
    }

    // Transfers an NFT to a new owner, where the new owner is not publically known.
    transition transfer_private(nft: NftOwnershipInstance, receiver: address) -> (NftOwnershipInstance, NftReceipt) {
        let owner: NftOwnershipInstance = NftOwnershipInstance {
            owner: nft.owner,
            gates: 0u64,
            data: nft.data
        };

        let creator: NftReceipt = NftReceipt {
            owner: COLLECTION_OWNER,
            gates: 0u64,
            nft_owner: receiver
        };

        return (owner, creator);
    }

    // Transfers an NFT to a new owner, where the new owner is publically known.
    transition transfer_public(public nft: NftOwnershipInstance, public receiver: address) {
    }

    // Converts a private NFT to a public NFT.
    transition convert_public_to_private(nft: NftOwnershipInstance) {
    }
}

