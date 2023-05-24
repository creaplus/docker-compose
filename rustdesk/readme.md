# rustdesk

> 自建rustdesk远程服务器节点

* 使用网络使用host模式 
* 使用root权限


## 帮助文档
> hbbs
```shell
root@fceb3512199d:~# hbbs -h
hbbs 1.1.4
CarrieZ Studio<info@rustdesk.com>
RustDesk ID/Rendezvous Server

USAGE:
    hbbs [OPTIONS]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -C, --change-id <BOOL(default=Y)>     Sets if support to change id
    -c, --config <FILE>                   Sets a custom config file
    -m, --email <EMAIL>                   Sets your email address registered with RustDesk
    -k, --key <KEY>                       Only allow the client with the same key
    -p, --port <NUMBER(default=21116)>    Sets the listening port
    -r, --relay-servers <HOST>            Sets the default relay servers, seperated by colon
    -R, --rendezvous-servers <HOSTS>      Sets rendezvous servers, seperated by colon
    -s, --serial <NUMBER(default=0)>      Sets configure update serial number
    -u, --software-url <URL>              Sets download url of RustDesk software of newest version
```
> hbbr
```shell
root@d0838c200ded:~# hbbr -h
hbbr 1.1.4
CarrieZ Studio<info@rustdesk.com>
RustDesk Relay Server

USAGE:
    hbbr [OPTIONS]

FLAGS:
    -h, --help       Prints help information
    -V, --version    Prints version information

OPTIONS:
    -m, --email <EMAIL>                   Sets your email address registered with RustDesk
    -k, --key <KEY>                       Only allow the client with the same key
    -p, --port <NUMBER(default=21117)>    Sets the listening port
```