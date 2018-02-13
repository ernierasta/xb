# x

## VoidLinux XBPS primitive wrapper with bash-completion

Ahoy VoidLinux comrades!

This is just quick wrapper for XBPS and runit. I think there are already some alternatives and this is probably the simplest wrapper. It provides simple interface inspired by Alpine Linux apk (similar to Debian's aptitude).

**There are actually two functionalities:**

- package management,
- service management.

And I think best feature is ... **bash autocompletion**!

### Examples for people new to completion:

```shell
x <TAB>         #for all actions
x add abi<TAB>  #will complete to abiword
x son <TAB>     #will list only disabled services
```

### Installation:

```shell
$ git clone https://github.com/ernierasta/x && cd x
$ sudo cp x /usr/local/bin/
$ sudo cp complete/x /usr/share/bash-completion/completions/
```
Then open new terminal window.

### Usage:

```shell
$ x add neovim mc
$ x son sshd
```

For full help run:
```shell
$ x
```

### Motivation:

I find XBPS multi-binary not very convenient. Also enabling services is tedious and error prone.

### Todo:

- add autoinstall script,
- add flatpak support (probably as separate set of commands, flatpack is slower then xbps),
- maybe add more commands if needed ...

### Alternatives:

- [vpm](https://github.com/netzverweigerer/vpm) - probably advanced, more powerful wrapper, with colors!
- [octoxbps](https://github.com/aarnt/octoxbps) - QT5 GUI for XBPS
