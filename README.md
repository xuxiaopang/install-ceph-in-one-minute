# install-ceph-in-one-minute

## Usage

Before install ceph ,make sure your VM or Server can connet to Internet.

The `install.sh` script will install a **HAMMER** ceph cluster with **ONLY ONE OSD** under`/root/osd`,
this is used for quick installation.

```
git clone https://github.com/xuxiaopang/install-ceph-in-one-minute.git
cd install-ceph-in-one-minute
chmod +x *.sh
```

## Install

```
./install.sh
```

##Uninstall

```
./uninstall.sh
```
