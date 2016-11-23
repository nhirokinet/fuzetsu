- You need to install lxc.
- Installing this package makes it difficult to use lxc on the host for different purpose.

## Installation

Install from source
```
sudo apt install make lxc
sudo make install
sudo make lxc
```

Build dpkg file
```
sudo apt install make lxc

sudo make lxc-tar
make dpkg
```

Install dpkg file
```
sudo apt install make lxc
dpkg -i fuzetsu_0.0.1_amd64.deb
```

## Notes

- Developed and tested under Ubuntu 16.04. Installing on Ubuntu 14.04 may lead to some problem.
- License for this repository itself is BSD license, but you must note that this code download Ubuntu LXC image, and built package contains them. Currently, actual package is not distributed by nhirokinet. If you wish to distribute the package choose the correct license. 
