# tentacool
[![Build Status](https://drone.io/github.com/optiflows/tentacool/status.png)](https://drone.io/github.com/optiflows/tentacool/latest)
[![Go Walker](https://img.shields.io/badge/GoWalker-Doc-blue.svg?style=flat)](https://gowalker.org/github.com/optiflows/tentacool)
[![Go report](http://goreportcard.com/badge/optiflows/tentacool)](http://goreportcard.com/report/optiflows/tentacool)
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Foptiflows%2Ftentacool.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Foptiflows%2Ftentacool?ref=badge_shield)


## Description

`tentacool` is a Go server controlled via RESTful API through a Unix Domain Socket.

## Goal

Main goal is to manage all under the hood services for a simple "box".
All done with a auditable, fast and bulletproof software.

So many software do frontend, backend and system... And finally run in `root` by easiness.

## To build

Be sure to set the correct GOPATH and GOROOT environment variables.
You can make use of [godeb](https://github.com/niemeyer/godeb) which set you up with the version of Go you want. (Tentacool is using >= 1.2)

Build Tentacool using [gb](https://getgb.io/).

An automatic of the executable from master branch can also be found [on drone.io](https://drone.io/github.com/optiflows/tentacool/files).

### How-to `GB`

```bash
# Get GB
go get github.com/constabulary/gb/...
# Fetch dependencies
gb vendor restore
# Build tentacool
gb build
./bin/tentacool -help
```

## Configuration

Recommended `/etc/network/interfaces` config for your default interface (for instance `eth0`):
```
auto eth0
iface eth0 inet manual
  pre-up ifconfig $IFACE up
  post-down ifconfig $IFACE down
```

## API

### addresses

#### <a name="address"></a>address object

* `link`: interface to manage
* `ip`: ip to add ([CIDR](http://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) format)
* `id`

#### `GET /addresses`

List all current addresses

##### Response

* Array
  * [address](#address)


#### `GET /addresses/:id`

##### Response

* [address](#address)

#### `POST /addresses`

Add a new address to manage.

##### parameters

* [address](#address)
`id` optional

##### Response

* [address](#address)
* headers
  * `X-Error`: if address is stored in BD but fail to by apply.

##### Example

* without id
```json
==>
{
  "link":"eth0",
  "ip":"192.168.32.11/32",
}
```
```json
<==
{
  "id":"1",
  "link":"eth0",
  "ip":"192.168.32.11/32",
}
```
* with id
```json
==>
{
  "id":"foo",
  "link":"eth0",
  "ip":"192.168.32.12/32",
}
```
```json
<==
{
  "id":"foo",
  "link":"eth0",
  "ip":"192.168.32.12/32",
}
```

#### `PUT /addresses/:id`

Modify an existing address

##### parameters

* [address](#address)
`id` ignored

##### Response

* [address](#address)
* headers
  * `X-Error`: if address is stored in BD but fail to by apply.


### dhcp

#### `GET /dhcp`

Checks if DHCP is running on the default interface.

##### Response

`{'active': true|false}`

#### `POST /dhcp`

Activate/deactive DHCP for default interface.

##### parameters

* active `true` or `false`


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Foptiflows%2Ftentacool.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Foptiflows%2Ftentacool?ref=badge_large)