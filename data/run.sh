#!/bin/bash


cd /aleo/snarkOS

if [ "${MINER_ADDRESS}" == "" ]
then
  snarkos experimental new_account 2>&1 | tee /aleo/data/new_account
  exit
fi

COMMAND="cargo run --release -- --miner ${MINER_ADDRESS} --trial --verbosity 2"

function exit_node()
{
    echo "Exiting..."
    kill $!
    exit
}

trap exit_node SIGINT

echo "Running miner node..."

while :
do
  echo "Checking for updates..."
  STATUS=$(git pull)

  killall snarkos
  /aleo/data/start &

  echo "Running the node..."
  
  if [ "$STATUS" != "Already up to date." ]; then
    cargo clean
  fi
  $COMMAND & sleep 1800; kill $!

  sleep 2;
done
