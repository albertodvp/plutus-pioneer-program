#!/bin/bash

txin="$1"
collateral="$2"
key="/app/code/keys/alice"

# Get protocol parameters
cardano-cli query protocol-parameters \
            --testnet-magic 2 \
            --out-file "assets/protocol-parameters.json"

# Build the transaction
cardano-cli transaction build \
            --babbage-era \
            --testnet-magic 2 \
            --script-invalid \
            --tx-in "$1" \
            --tx-in-script-file "assets/homework2.plutus" \
            --tx-in-inline-datum-present \
            --tx-in-redeemer-file "assets/homework2InvalidRedeemer.json" \
            --tx-in-collateral  "$2" \
            --change-address "$(cardano-cli address build --testnet-magic 2 --payment-verification-key-file $key.vkey)" \
            --protocol-params-file "assets/protocol-parameters.json" \
            --out-file "assets/homework2getBad.txbody"

# Sign the transaction
cardano-cli transaction sign \
            --testnet-magic 2 \
            --tx-body-file "assets/homework2getBad.txbody" \
            --signing-key-file "$key.skey" \
            --out-file "assets/homework2getBad.tx"

# This will burn collateral
cardano-cli transaction submit \
            --testnet-magic 2 \
            --tx-file  "assets/homework2getBad.tx"

# Get txid
echo $(cardano-cli transaction txid --tx-file "assets/homework2getBad.tx")




            


