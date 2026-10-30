# OS-NERDICON

This is a very small library with no dependencies. It aims to provide a simple way of retrieving a [Nerdfont](https://www.nerdfonts.com) icon for the installed operating system distribution.

## Prerequisites

This library only works on Linux based operating system distributions that provide either the `/etc/os-release` symlink or the `/usr/lib/os-release` file. If neither of these files are available or the distribution is unknown, the library will fall back on the default Linux icon. To properly display the icons the target system also needs to have any current version of [Nerdfont](https://www.nerdfonts.com/) installed and applied.

If you want to build this library from source you also need to have Version `0.15.2` of the Zig compiler, any version of GCC, as well as any version of GNU Make installed.

## Usage

Releases can be found on the [GitHub page](https://www.github.com/lennart-luttmann/os-nerdicon) of this project.

To install this library, use the `install.sh` script provided with both the repository and the release files. Running the install script requires root privileges. You may need to use chmod to make the script executable fist.

```
chmod +x install.sh && sudo ./install.sh
```

Installing this library also places an uninstall script at `/usr/share/osnerdicon/uninstall.sh`.

## Icons

The library current supports 32 different icons.

| Name                     | ID            | Icon |
| ------------------------ | ------------- | ---- |
| Alma Linux OS            | almalinux     | ` ` |
| Alpine Linux             | alpine        | ` ` |
| Arch Linux               | arch          | ` ` |
| Archcraft                | archcraft     | ` ` |
| Artix                    | artix         | ` ` |
| Cachy OS                 | cachyos       | ` ` |
| Centos                   | centos        | ` ` |
| Debian                   | debian        | ` ` |
| Deepin OS                | deepin        | ` ` |
| Elementary OS            | elementary    | ` ` |
| Endeavour OS             | endeavour     | ` ` |
| Fedora                   | fedora        | ` ` |
| Garuda Linux             | garuda        | ` ` |
| Gentoo                   | gentoo        | ` ` |
| Kali Linux               | kali          | ` ` |
| Linux Mint               | linuxmint     | ` ` |
| Manjaro                  | manjaro       | ` ` |
| Nix OS                   | nixos         | ` ` |
| Open Suse Leap           | opensuse-leap | ` ` |
| POP! OS                  | pop           | ` ` |
| Qubes OS                 | qubes         | ` ` |
| Raspberry Pi OS          | raspbian      | ` ` |
| Red Hat Enterprise Linux | rhel          | ` ` |
| Rocky OS                 | rocky         | ` ` |
| Solus OS                 | solus         | ` ` |
| Steam OS                 | steamos       | ` ` |
| Tails OS                 | tails         | ` ` |
| Open Suse Tumbleweed     | tumbleweed    | ` ` |
| Ubuntu                   | ubuntu        | ` ` |
| Void Linux               | void          | ` ` |
| Zorin OS                 | zorin         | ` ` |

And the default icon for unknown distributions or errors: ``

## Contribution

I am a solo developer and a relative novice in Zig. Should you find room for improvement, feel free to create a pull request.

This library has not been tested on every listed distribution. Should it not work on your distribution of choice, let me know via issue or create a pr.

Should your distribution of choice not be supported but you feel like it should be, feel free to create an issue. However, please first make sure that a corresponding icon is available, a list can be found [here](https://www.nerdfonts.com/cheat-sheet).

## Releases

There are no current plans to release this project to any core or community repository. You can download the latest release for your target architecture form the GitHub page [here](https://www.github.com/lennart-luttmann/os-nerdicon).
