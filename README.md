# install-ceph-in-one-minute

## Usage

Before install ceph ,make sure your VM or Server can connet to Internet.

The `install.sh` script will install a **HAMMER** ceph cluster with **ONLY ONE OSD** under`/root/osd`,
this is used for quick installation in a clean envonriment.

> If you have a pre-installed newer version ceph, you need to uninstall it. See the [Unistall](#Uninstall).

## Install
```
git clone https://github.com/xuxiaopang/install-ceph-in-one-minute.git
cd install-ceph-in-one-minute
chmod +x *.sh
./install.sh                                                                                                                                                

```


## Clean up and Uninstall

This script will clean up your ceph environment without uninstall ceph packages.
This is very helpful when you get some problems when install ceph especially when you have an older unclean environmet,
it is always recommnented to **Clean Up** your env before install ceph.

### Clean up 
```
./cleanup.sh
```

### Uninstall 

When you want to install ceph from newer version to an older version, e.g. `10.2.3 to 0.94.9`, you need to uninstall the `10.2.3` ceph packages,
and then install the `0.94.9` version. This is quite simple:

```
# ceph -v
ceph version 10.2.2 (45107e21c568dd033c2f0a3107dec8f0b0e58374)

# rpm -qa | grep 10.2.2 | xargs -e --nodeps

``` 
