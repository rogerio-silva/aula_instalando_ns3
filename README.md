# Mobile Networks Practical Class
## NS-3 simulator, LoRaWAN, NYUSIM, and ns3Gym modules
---
# Table of Contents
- [Summary](#summary)
- [Structure of the Repository](#structure-of-the-repository)
- [Simulation Environment](#simulation-environment)
  - [Install NS-3 3.42](#install-ns-3-342)
  - [Add LoRaWAN module](#add-lorawan-module)
  - [Add NYUSIM module](#add-nyusim-module)
  - [Add ns3Gym module](#add-ns3gym-module)
- [How to cite](#how-to-cite)

# Summary
This is the ns-3 and modules Installation Guide. 

The repository contains the necessary steps to install the ns-3 simulator and the LoRaWAN, NYUSIM, and ns3Gym modules.
The ns-3 simulator is a discrete-event network simulator for Internet systems, targeted primarily for research and educational use. The simulator is written in C++ and provides a simulation environment for networking research. The simulator is widely used in academia, industry, and government research labs.
The LoRaWAN module is an extension of the ns-3 simulator that provides a simulation environment for LoRaWAN networks. The module is written in C++. 
The NYUSIM module is an extension of the ns-3 simulator that provides a simulation environment for NYUSIM channel models. The module is written in C++.
The ns3Gym module is an extension of the ns-3 simulator that provides a simulation environment for reinforcement learning. The module is written in Python.

# Structure of the Repository
## Simulation Environment
### Install NS-3 3.42
*Adapted from [NS-3 website](https://www.nsnam.org/docs/release/3.42/tutorial/html/getting-started.html).
1. Get the NS-3.42 source code from the [NS-3 website](https://www.nsnam.org/releases/ns-allinone-3.42.tar.bz2) or run the following command to download it
   ```bash
   wget https://www.nsnam.org/release/ns-allinone-3.42.tar.bz2
   ```
   
2. Make sure that your system has these prerequisites. If not, install them using the following commands:

   * As an alternative to install all the requirements for ns-3, you can run the `00_install_dependencies.sh` script. 
   Script usage:
     * To install all dependencies except for MPI and Virtual Machines module support, run: `./00_install_dependencies.sh`
     * To install with MPI support, run: `./00_install_dependencies.sh --mpi`
     * To install with Virtual Machines support, run: `./00_install_dependencies.sh --vm`
     * To install with support for both, run: `./00_install_dependencies.sh --mpi --vm`
   * If you prefer to install the dependencies manually, run the following commands:
   ```bash
      ## Minimal requirements for ns-3
     # update the system
     sudo apt update && sudo apt upgrade -y
     # minimal requirements for release 3.37 and later
     sudo apt install g++ python3 cmake bzip2 ninja-build git ccache
     
     ## Extras (select as needed)
     # Additional minimal requirements for Python (development): 
     sudo apt install python3-setuptools 
     # Requirements for Netanim animator 
     sudo apt install -y qtbase5-dev qtbase5-dev-tools
     # Support for MPI-based distributed emulation
     sudo apt install openmpi-bin openmpi-common openmpi-doc libopenmpi-dev
     # Debugging:
     sudo apt install gdb valgrind 
     # To read pcap packet traces
     sudo apt install tcpdump
     # Database support for statistics framework
     sudo apt install sqlite3 libsqlite3-dev
     # To experiment with virtual machines and ns-3
     sudo apt install vtun lxc uml-utilities
   ```

4. Move the downloaded file to the desired directory and extract it. To this example, we will move it to the ```~/``` directory.
   ```bash
   #### Extract NS-3.42
   tar xjf ns-allinone-3.42.tar.bz2
   mv ns-allinone-3.42 ~/
   cd ~/ns-allinone-3.42/
   ``` 

4. To build NS-3.41, go to the directory where you extracted the tarball and run the following commands:
   ```bash
   ./build.py --enable-examples --enable-tests
   ```
   ☕ wait until the build process is completed. ☕  
   This process may take a while.

### Add LoRaWAN module
*Adapted from [Signetlab](https://github.com/signetlabdei/lorawan). 

1. To add the LoRaWAN module to the NS-3.42, run the following commands:
   ```bash
   git clone https://github.com/signetlabdei/lorawan ~/ns-allinone-3.42/ns-3.42/src/lorawan
   ```
2. To rebuild the NS-3.42 with the LoRaWAN module, run the following commands:
   ```bash
   cd ~/ns-allinone-3.42/ns-3.42/
   ./ns3 configure --enable-tests --enable-examples
   ./ns3 build
   ```
   ☕ wait until the build process is completed. ☕  
   This process may take a while.
   
3. Finally, ensure tests run smoothly with:
   ```bash
   ./test.py
   ``` 
   You can proceed if the script reports that all tests passed or that just three-gpp-propagation-loss-model failed.   
   If other tests fail or crash, consider filing an [issue](https://github.com/signetlabdei/lorawan/issues).

### Add NYUSIM module 
(*Adapted from [hiteshPoddar](https://github.com/hiteshPoddar/NYUSIM_in_ns3).)

**Steps to install NYUSIM in ns-3 3.42:**

_NYUSIM files have been thoroughly tested on NS-3 version 3.42, so it is highly advisable to use the same version for optimal compatibility._

As an alternative to the following steps, you can run the `01_install_nyusim.sh` script.

1. Download the NYUSIM files from the repository with our version [**rogerio-silva/NYUSIM_in_ns3**](https://github.com/rogerio-silva/NYUSIM_in_ns3.git), adapted from [[hiteshPoddar/NYUSIM_in_ns3]](https://github.com/hiteshPoddar/NYUSIM_in_ns3) to run on NS3-3.42 version.

   This repository contains the files needed to run the NYUSIM channel model within the ns-3 simulator. The following temporary directories, (1) propagation/model, (2) propagation/example, (3) spectrum/model, and (4) spectrum/example, provide the NYUSIM files.
   You can download these files to a temporary directory and then copy them sequentially to the ns-3 directory by running the following commands:
       
      ```bash
       git clone git@github.com:rogerio-silva/NYUSIM_in_ns3.git ~/NYUSIM_in_ns3
      ```

2. Checkout the branch `ns-3.42`
   ```bash
   cd ~/NYUSIM_in_ns3
   git checkout ns3-3.42
   ```
 
3. Copy all the files from the current repository present in the directory propagation/model to ns-3 mainline src/propagation/model

    ```bash
       cp -r ~/NYUSIM_in_ns3/propagation/model/* ~/ns-allinone-3.42/ns-3.42/src/propagation/model/
    ```
4. Copy all the files from the current repository present in the directory propagation/example to ns-3 mainline src/propagation/examples

    ```bash
       cp -r ~/NYUSIM_in_ns3/propagation/example/* ~/ns-allinone-3.42/ns-3.42/src/propagation/examples/
    ```
5. On ns-3 mainline in the directory src/propagation add the following lines to the CMakeLists.txt file under:
   
    ```bash
       nano ~/ns-allinone-3.42/ns-3.42/src/propagation/CMakeLists.txt
   ```   
  
   Add the following lines to the CMakeLists.txt after the last line in the section SOURCE_FILES:
    ```bash
       model/nyu-channel-condition-model.cc
       model/nyu-propagation-loss-model.cc
    ```
   Add the following lines to the CMakeLists.txt after the last line in the section HEADER_FILES:
    ```bash
       model/nyu-channel-condition-model.h
       model/nyu-propagation-loss-model.h
    ```
6. Copy all the files from the current repository present in the directory spectrum/model to ns-3 mainline src/spectrum/model

    ```bash
       cp -r ~/NYUSIM_in_ns3/spectrum/model/* ~/ns-allinone-3.42/ns-3.42/src/spectrum/model/
    ```
7. Copy all the files from the current repository present in the directory spectrum/example to ns-3 mainline src/spectrum/examples

    ```bash
       cp -r ~/NYUSIM_in_ns3/spectrum/example/* ~/ns-allinone-3.42/ns-3.42/src/spectrum/examples/
    ```

8. On ns-3 mainline in the directory src/spectrum add the following lines to the CMakeLists.txt file under:

    ```bash
       nano ~/ns-allinone-3.42/ns-3.42/src/spectrum/CMakeLists.txt
   ```   
   Add the following lines to the CMakeLists.txt after the last line in the section SOURCE_FILES:
    ```bash
       model/nyu-channel-model.cc
       model/nyu-spectrum-propagation-loss-model.cc
    ```
   Add the following lines to the CMakeLists.txt after the last line in the section HEADER_FILES:
      ```bash
          model/nyu-channel-model.h
          model/nyu-spectrum-propagation-loss-model.h
      ```
9. You can run the example files from Step 3 or Step 6 to see the usage of NYUSIM channel model from the ns-3-dev folder using:
   ```bash 
   ./ns3 run src/spectrum/examples/nyu-channel-example
   ```
### Add ns3Gym module
* Using [rogerio-silva/ns3-gym](https://github.com/rogerio-silva/ns3-gym), forked and adapted from [tkn-tub/ns3-gym](https://github.com/tkn -tub/ns3-gym).

To install the ns3Gym, run the following commands.

1. Install ZMQ, Protocol Buffers and pkg-config libs _(only if you have not run the `00_install_dependencies.sh` script)_:
   ```bash
   sudo apt update && sudo apt upgrade -y
   sudo apt install libzmq5 libzmq3-dev
   sudo apt install libprotobuf-dev
   sudo apt install protobuf-compiler
   sudo apt install pkg-config
   ```
   
2. Clone ns3-gym repository in to `contrib` directory and change the branch:
   ```bash
   cd ~/ns-allinone-3.42/ns-3.42/contrib
   git clone https://github.com/rogerio-silva/ns3-gym.git ./opengym
   cd opengym/
   git checkout app-ns-3.42
   ```
   Check [working with cmake](https://www.nsnam.org/docs/manual/html/working-with-cmake.html)

   It is important to use the `opengym` as the name of the ns3-gym app directory. 

3. Configure and build ns-3 project (again):
   ```bash
   cd ~/ns-allinone-3.42/ns-3.42/
   ./ns3 configure --enable-examples --enable-tests
   ./ns3 build  
   ```
   Note: Opengym Protocol Buffer messages (C++ and Python) are build during configure.

   4. Install ns3gym located in `model/ns3gym` (Python3 required)
      ```bash
        cd ~/ns-allinone-3.42/ns-3.42/contrib/opengym
        pip install --user ./model/ns3gym
      ```

5. (Optional) Install all libraries required by your agent (like tensorflow, keras, etc.).

6. Run example:
   Open two terminals and run the following commands:
   On the first terminal:
   ```bash
    cd ~/ns-allinone-3.42/ns-3.42
    ./ns3 run opengym 
   ```
   On the second terminal:
   ```bash
      cd ~/ns-allinone-3.42/ns-3.42/contrib/opengym/examples/opengym
      python3 test.py --start=0
   ```
   
Enjoy the ns-3!