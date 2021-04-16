#!/bin/bash
docker run -ti --rm --gpus all nvidia/cuda:11.2-base -v $(pwd)/project:/usr/project martellato/mltoolbox:arch-latest