#!/bin/sh

set -e
set -x

os=`uname`
TRAVIS_ROOT="$1"

case "$os" in
    Darwin)
        echo "Mac"
        brew update
        brew upgrade cmake || brew install cmake
        brew list cmake
        ;;

    Linux)
        echo "Linux"
        if [ ! -d "$TRAVIS_ROOT/cmake" ]; then
            mkdir -p $TRAVIS_ROOT/cmake
            # DEBUG
            ls -l $TRAVIS_ROOT
            ls -l $TRAVIS_ROOT/cmake
            # from source
            #wget --no-check-certificate -q https://cmake.org/files/v3.4/cmake-3.4.1.tar.gz
            #tar -C $TRAVIS_ROOT -xzf cmake-3.4.1.tar.gz
            #cd ~/cmake-3.4.1
            #mkdir build && cd build
            #cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$TRAVIS_ROOT/cmake
            #make -j4 && make install
            # from binary
            cd $TRAVIS_ROOT
            wget --no-check-certificate -q https://cmake.org/files/v3.4/cmake-3.4.1-Linux-x86_64.sh
            sh ./cmake-3.4.1-Linux-x86_64.sh --prefix=$TRAVIS_ROOT/cmake --skip-license --exclude-subdir
        else
            echo "CMake installed..."
            find $TRAVIS_ROOT/cmake -name cmake
        fi
        ;;
esac
