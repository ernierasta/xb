# xb

## VoidLinux XBPS primitive wrapper with bash-completion

Ahoy VoidLinux comrades!

This is just quick wrapper for XBPS, flatpak and runit. I think there are already some alternatives and this is probably the simplest wrapper. It provides simple interface inspired by Alpine Linux apk (similar to Debian's aptitude).

**There are actually tree functionalities:**

- package management,
- flatpak management,
- service management.

And I think best feature is ... **bash autocompletion**!

### Examples for people new to completion:

```shell
xb <TAB>         #for all actions
xb add abi<TAB>  #will complete to abiword
xb son <TAB>     #will list only disabled services
xb fadd <TAB>    #will list flatpak packages
```

### Installation:

```shell
$ git clone https://github.com/ernierasta/xb && cd xb
$ sudo cp xb /usr/local/bin/
$ sudo cp complete/xb /usr/share/bash-completion/completions/
```
Optionally you can make aliases, to use **x** as alias:
```shell
$ # command below will add alias to .bash_aliases if exist, otherwise to .bashrc
$ [ -f ~/.bash_aliases ] && echo -e "alias x='sudo xb'\n_completion_loader xb\ncomplete -o bashdefault -o default -o nospace -F _xb x" >> ~/.bash_aliases || echo -e "alias x='sudo xb'\n_completion_loader xb\ncomplete -o bashdefault -o default -o nospace -F _xb x" >> ~/.bashrc

```
Then open new terminal window.

### Usage:

```shell
$ xb add neovim mc
$ xb son sshd
$ xb frepoadd flathub
$ xb fadd blender.blender
```

For full help run:
```shell
$ xb
```

### Motivation:

I find XBPS multi-binary not very convenient. Also enabling services is tedious and error prone. Lets not speak about
flatpak interface ... ;-).

### Todo:

- add autoinstall script,

~~- add flatpak support (probably as separate set of commands, flatpak is slower then xbps),~~
~~- fix short flatpak names (for now skype is there as "client", because of: com.skype.Client), test it more.~~
- maybe add more commands if needed ...

### Alternatives:

- [vpm](https://github.com/netzverweigerer/vpm) - probably advanced, more powerful wrapper, with colors!
- [octoxbps](https://github.com/aarnt/octoxbps) - QT5 GUI for XBPS
