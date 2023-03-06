#!/bin/bash

txin="$1"
key="/app/code/keys/alice"

# Get script address
cardano-cli address build \
            --payment-script-file "assets/homework2.plutus" \
            --testnet-magic 2 \
            --out-file "assets/homework2.addr"

# Build the transaction (amount)
cardano-cli transaction build \
            --testnet-magic 2 \
            --babbage-era \
            --tx-in "$txin" \
            --tx-out "$(cat assets/homework2.addr) + 42424242 lovelace" \
            --tx-out-inline-datum-file "assets/unit.json" \
            --change-address "$(cardano-cli address build --testnet-magic 2 --payment-verification-key-file $key.vkey)" \
            --out-file "assets/homework2.txbody"

# Sign the transaction
cardano-cli transaction sign \
            --testnet-magic 2 \
            --tx-body-file "assets/homework2.txbody" \
            --signing-key-file  "$key.skey"\
            --out-file "assets/homework2.tx"

# Submit transactino
cardano-cli transaction submit \
            --testnet-magic 2 \
            --tx-file "assets/homework2.tx"

# Get txid
echo $(cardano-cli transaction txid --tx-file "assets/homework2.tx")

