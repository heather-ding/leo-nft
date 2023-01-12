const COLLECTION_OWNER: address = aleo1ezamst4pjgj9zfxqq0fwfj8a4cjuqndmasgata3hggzqygggnyfq6kmyd4;

// The 'nft' program.
program nft.aleo {
    // Owner refers to the creator of the NFT.
    record NftOwnershipInstance {
        owner: address,
        gates: u64,
        id: u32,
        data: NftPrivateData,
    }

    record NftReceipt {
        owner: address,
        gates: u64,
        id: u32,
        nft_owner: address
    }

    struct NftPrivateData {
        half1: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
        half2: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature

        metadata: u128 // Arbitrary 128-bytes of metadata.
    }

    struct NftPublicData {
        metadata: u128
    }

    // IDs => owner
    mapping nft_owners: u32 => address;
    mapping nft_public_data: u32 => NftPublicData;

    // Privately mints an NFT with 'data' for the reciever.
    // To update data, a collection owner would issue a new NFT to the owner of the prior NFT.
    transition mint_private(
        id: u32,
        receiver: address,
        private_data: NftPrivateData,
        public public_data: NftPublicData) -> (NftOwnershipInstance, NftReceipt) {
        assert_eq(self.caller, COLLECTION_OWNER);

        let owner: NftOwnershipInstance = NftOwnershipInstance {
            owner: receiver,
            gates: 0u64,
            id: id,
            data: data
        };

        let creator: NftReceipt = NftReceipt {
            owner: COLLECTION_OWNER,
            gates: 0u64,
            id: id,
            nft_owner: receiver
        };

        return (owner, creator) then finalize(id, COLLECTION_OWNER, public_data);
    } 

    finalize mint_private(
        public id: u32,
        public receiver: address,
        public public_data: NftPublicData
    ) {
        nft_owners[id] = receiver;
        nft_public_data[id] = public_data;
    }

    // Transfers a private NFT to a new owner, where the new owner is not publically known.
    transition transfer_private(nft: NftOwnershipInstance, receiver: address) -> (NftOwnershipInstance, NftReceipt) {
        let owner: NftOwnershipInstance = NftOwnershipInstance {
            owner: receiver,
            gates: 0u64,
            id: nft.id,
            data: nft.data
        };

        let creator: NftReceipt = NftReceipt {
            owner: COLLECTION_OWNER,
            gates: 0u64,
            id: nft.id,
            nft_owner: receiver
        };

        return (owner, creator) then finalize(nft.id);
    }

    finalize transfer_private(id: u32) {
        nft_owners[id] = COLLECTION_OWNER;
    }

    // Transfers an NFT to a new owner, where the new owner is publically known.
    transition transfer_public(nft: NftOwnershipInstance, public receiver: address) -> (NftOwnershipInstance, NftReceipt) {
        let owner: NftOwnershipInstance = NftOwnershipInstance {
            owner: receiver,
            gates: 0u64,
            id: nft.id,
            data: nft.data
        };

        let creator: NftReceipt = NftReceipt {
            owner: COLLECTION_OWNER,
            gates: 0u64,
            id: nft.id,
            nft_owner: receiver
        };

        return (owner, creator) then finalize(nft.id, receiver);
    }

    finalize transfer_public(id: u32, receiver: address) {
        nft_owners[id] = receiver;
    }
}

