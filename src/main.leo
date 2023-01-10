// The 'nft' program.
program nft.aleo {
    record Nft {
        owner: address,
        gates: u64,

        data: NftData,
    }

    struct NftData {
        half1: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
        half2: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
    }

    // Privately mints an NFT with 'data' for the reciever.
    transition mint_private(reciever: address, data: NftData) -> Nft {
        return Nft {
            owner: reciever,
            gates: 0u64,
            data: data
        };
    }

    // Transfers an NFT to a new owner privately.
    transition transfer_private(nft: Nft, receiver: address) -> Nft {
        return Nft {
            owner: receiver,
            gates: 0u64,
            data: nft.data
        };
    }
}

