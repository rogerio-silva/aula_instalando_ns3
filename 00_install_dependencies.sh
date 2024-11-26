#!/bin/bash

# Function to display the correct usage of the script
function usage() {
    echo "Usage: $0 [--mpi] [--vm]"
    echo "  --mpi    Install support for MPI"
    echo "  --vm     Install support for virtual machines"
    exit 1
}

# Check arguments
INSTALL_MPI=false
INSTALL_VM=false

for arg in "$@"
do
    case $arg in
        --mpi)
        INSTALL_MPI=true
        shift
        ;;
        --vm)
        INSTALL_VM=true
        shift
        ;;
        *)
        usage
        ;;
    esac
done

# Update the system
sudo apt update && sudo apt upgrade -y

# Install minimal requirements for ns-3 (version 3.37 and later)
sudo apt install -y gcc g++ cmake ninja-build git ccache

# Install the latest version of Python and pip
sudo apt install -y python3 python3-pip

# Install additional minimal requirements for Python development
sudo apt install -y python3-setuptools

# Install requirements for Netanim animator
sudo apt install -y qtbase5-dev qtbase5-dev-tools

# Install debugging tools
sudo apt install -y gdb valgrind

# Install tools to read pcap packet traces
sudo apt install -y tcpdump

# Install database support for the statistics framework
sudo apt install -y sqlite3 libsqlite3-dev

# Install additional development requirements
sudo apt install -y liblapack3 libtbbmalloc2 libcliquer1 libopenblas-dev patchelf

# Install support for ZeroMQ and Protobuf
sudo apt install -y libzmq5 libzmq3-dev
sudo apt install -y libprotobuf-dev
sudo apt install -y protobuf-compiler
sudo apt install -y pkg-config

# Install support for MPI if requested
if [ "$INSTALL_MPI" = true ]; then
    echo "Installing MPI support..."
    sudo apt install -y openmpi-bin openmpi-common openmpi-doc libopenmpi-dev
fi

# Install support for virtual machines if requested
if [ "$INSTALL_VM" = true ]; then
    echo "Installing virtual machine support..."
    sudo apt install -y vtun lxc uml-utilities
fi

# Finish with a general system update
sudo apt update && sudo apt upgrade -y

# Confirm completion
echo "Dependencies have been installed successfully."

