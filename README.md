```
██╗  ██╗███████╗██████╗       ███╗   ███╗     ██╗██████╗  ██████╗ 
██║ ██╔╝██╔════╝██╔══██╗      ████╗ ████║     ██║██╔══██╗██╔═══██╗
█████╔╝ ███████╗██║  ██║█████╗██╔████╔██║     ██║██████╔╝██║   ██║
██╔═██╗ ╚════██║██║  ██║╚════╝██║╚██╔╝██║██   ██║██╔══██╗██║   ██║
██║  ██╗███████║██████╔╝      ██║ ╚═╝ ██║╚█████╔╝██║  ██║╚██████╔╝
╚═╝  ╚═╝╚══════╝╚═════╝       ╚═╝     ╚═╝ ╚════╝ ╚═╝  ╚═╝ ╚═════╝ 
```


---


Lightweight and KISSed manjaro-linux profile using manjaro-tools.


#### Installation:
```
git clone https://github.com/demysteriismundi/kissed-manjaro
cd kissed-manjaro
./install.sh && buildiso -p kissed
```

Now your ISO stored in `/var/cache/manjaro-tools/iso/community/kissed` and You can make bootable USB-drive by any utilities. For example:

```
dd if=/var/cache/manjaro-tools/iso/community/kissed/19.0.1/manjaro-kissed-19.0.1-stable-x86_64.iso of=/dev/sdb bs=4096 status=progress
```

#### Dependencies
To make the ISO You need to install [manjaro-tools](https://gitlab.manjaro.org/tools/development-tools/manjaro-tools). Also this utility contains in [AUR](https://aur.archlinux.org/).
