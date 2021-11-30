#!/bin/bash

docker stop aleo && docker rm aleo
docker run -it --name aleo -v ~/aleo/data:/aleo/data -p 4132:4132 -p 3032:3032 -e MINER_ADDRESS=#MINER_ADDRESS# qsobad/aleo
