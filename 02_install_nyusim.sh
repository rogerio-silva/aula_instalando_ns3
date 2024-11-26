#!/bin/bash

# Clone NYUSIM repository
git clone git@github.com:rogerio-silva/NYUSIM_in_ns3.git ~/NYUSIM_in_ns3

# Checkout the branch ns-3.42
cd ~/NYUSIM_in_ns3
git checkout ns3-3.42

# Copy NYUSIM files to NS-3 directories
cp -r ~/NYUSIM_in_ns3/propagation/model/* ~/ns-allinone-3.42/ns-3.42/src/propagation/model/
cp -r ~/NYUSIM_in_ns3/propagation/example/* ~/ns-allinone-3.42/ns-3.42/src/propagation/examples/
cp -r ~/NYUSIM_in_ns3/spectrum/model/* ~/ns-allinone-3.42/ns-3.42/src/spectrum/model/
cp -r ~/NYUSIM_in_ns3/spectrum/example/* ~/ns-allinone-3.42/ns-3.42/src/spectrum/examples/

# Update CMakeLists.txt for propagation module
sed -i '/^[[:space:]]*SOURCE_FILES/a \    model/nyu-channel-condition-model.cc\n    model/nyu-propagation-loss-model.cc' ~/ns-allinone-3.42/ns-3.42/src/propagation/CMakeLists.txt

sed -i '/^[[:space:]]*HEADER_FILES/a \    model/nyu-channel-condition-model.h\n    model/nyu-propagation-loss-model.h' ~/ns-allinone-3.42/ns-3.42/src/propagation/CMakeLists.txt

# Update CMakeLists.txt for spectrum module
sed -i '/^set *(source_files/a \    model/nyu-channel-model.cc\n    model/nyu-spectrum-propagation-loss-model.cc' ~/ns-allinone-3.42/ns-3.42/src/spectrum/CMakeLists.txt

sed -i '/^set *(header_files/a \    model/nyu-channel-model.h\n    model/nyu-spectrum-propagation-loss-model.h' ~/ns-allinone-3.42/ns-3.42/src/spectrum/CMakeLists.txt

# Run NYUSIM example
cd ~/ns-allinone-3.42/ns-3.42/
./ns3 run src/spectrum/examples/nyu-channel-example