// The 'nft' program.
program nft.aleo {
    record Nft {
        owner: address,
        gates: u64,
        data1: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
        data2: u128, // Part 2 of Arweave Transaction ID, a SHA-256 signature
    }

    struct NftData {
        half1: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
        half2: u128, // Part 1 of Arweave Transaction ID, a SHA-256 signature
    }

    mapping nft_totals: public field => u8;
    mapping nft_owner_data1: public address => u128;
    mapping nft_owner_data2: public address => u128;

    
    /* Initialization */
    transition initialize (half1:u128, half2:u128) {
    }
    finalize initialize (public hash: field) {
        return;
    }

    /* Mint */
    transition mint (reciever: address, half1:u128, half2:u128) {
    }
    finalize mint (public hash: field) {
        return;
    }

    /* Transfer */
    transition transfer_public(public receiver: address, public sender: address, half1: u128, half2: u128) {
        // Transfer the Nft publicly, by invoking the computation on-chain.
    }
    finalize transfer_public(public receiver: address, public sender: address, half1: u128, half2: u128) {
        return;
    }

    transition transfer_private(nft: Nft, receiver: address) -> (Nft) {
        if nft.owner == self.caller {
            // Produce an nft record for the specified receiver.
            let transferred: Nft = Nft {
                owner: receiver,
                gates: 0u64,
                data1: nft.data1,
                data2: nft.data2,
            };
        } 
        return (transfered);
    }

    transition convert_private_to_public(nft: Nft) {
    }
    finalize convert_private_to_public(owner: address, d1: u128, d2: u128) {
        return;
    }

    transition convert_public_to_private(d1: u128, d2: u128) {
    }
    finalize convert_public_to_private(owner: address, d1: u128, d2: u128) {
        return;
    }
}

