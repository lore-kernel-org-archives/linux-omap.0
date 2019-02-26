From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/6] net: add individual virtual device filtering
Date: Tue, 26 Feb 2019 20:45:50 +0200
Message-ID: <20190226184556.16082-1-ivan.khoronzhuk@linaro.org>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, f.fainelli@gmail.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, ilias.apalodimas@linaro.org, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

One of the reasons of this proposition is safety and performance -
host should not receive traffic which is not designated for it.

Some network devices can hold separate address tables for vlans and
real device, but for some reason there is no possibility to apply it
with generic net addressing scheme easily. At this moment the fastest
solution is to add mcast/ucast entries for every created vlan
including real device. But it not only consumes forwarding table but
also adds holes in the filtering and thus wastes cpus cycles.

This patchseries tries to correct core to assign mcast and ucast
addresses only for vlans that really require it and as result an end
driver can exclusively and simply set its rx filters. As an example
it's implemented on cpsw TI driver, but generic changes provided by
this series can be reused by other ethernet drivers having similar
rx filter address possibilities.

An address+vid is considered as separate address. The reserved device
address length is 32 Bytes, for ethernet devices it's additional
opportunity to pass auxiliary address info, like virtual ID
identifying a device the address belongs to. This series makes it
possible at least for ETH_P_8021Q.

Thus end real device can setup separate tables for virtual devices
just retrieving VID from the address. A device address space can
maintain addresses and references on them separately for each virtual
device if it needs so, or only addresses for real device (and all its
vlans) it holds usually.

A vlan device can be in any place of device chain upper real device,
say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.

This series is verified on TI am572x EVM that can hold separate tables
for vlans. Potentially it can be easily extended to netcp driver for
keystone 2 boards (including k2g) and also new am6 chipsets. As a
simple test case, different combinations of vlan+macvlan, macvlan+vlan
were used and tested as with unicast as multicast addresses.

Based on net-next/master

It's continuation of RFC:

[RFC PATCH net-next 0/5] net: allow hw addresses for virtual device
https://lkml.org/lkml/2018/12/3/817

Ivan Khoronzhuk (6):
  net: core: dev_addr_lists: add VID to device address
  net: 8021q: vlan_dev: add vid tag to addresses of uc and mc lists
  net: 8021q: vlan_dev: add vid tag for vlan device own address
  ethernet: eth: add default vid len for all ehternet kind devices
  net: ethernet: ti: cpsw: update mc filtering to use IVDF
  net: ethernet: ti: cpsw: add macvlan and ucast/vlan filtering support

 drivers/net/ethernet/ti/Kconfig |   1 +
 drivers/net/ethernet/ti/cpsw.c  | 139 ++++++++++++--------------------
 include/linux/if_vlan.h         |   2 +
 include/linux/netdevice.h       |   4 +
 net/8021q/Kconfig               |  12 +++
 net/8021q/vlan.c                |   3 +
 net/8021q/vlan.h                |   2 +
 net/8021q/vlan_core.c           |  25 ++++++
 net/8021q/vlan_dev.c            | 103 ++++++++++++++++++-----
 net/core/dev_addr_lists.c       | 124 ++++++++++++++++++++++------
 net/ethernet/eth.c              |  10 ++-
 11 files changed, 292 insertions(+), 133 deletions(-)

-- 
2.17.1
