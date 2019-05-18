# PPA
Files to make `deb` packages for my Personal Package Archives (`ppa:thombashi/ppa`).


# Add PPA (for Ubuntu)
```sh
sudo add-apt-repository ppa:thombashi/ppa
sudo apt update
```


# Build a deb package for the PPA
```sh
git clone https://github.com/thombashi/PPA.git
./make_deb_package.sh <package name>
```
