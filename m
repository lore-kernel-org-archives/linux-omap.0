From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [RFC PATCH net-next 0/5] net: allow hw addresses for virtual devices
Date: Mon,  3 Dec 2018 20:40:18 +0200
Message-ID: <20181203184023.3430-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, jiri@mellanox.com, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

One of the reasons of this proposition is safety and performance -
host should not receive traffic which is not designated for it.

Some network devices can hold separate address tables for vlans and
real device, but for some reason there is no possibility to apply it
with generic net addressing scheme easily. At this moment the fastest
solution is to add mcast/ucast entries for every created vlan
including real device. But it also adds holes in the filtering and
thus wastes cpus cycles.

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
possible at least for ETH_P_8021Q, but can be easily extended for ab.
Thus end real device can setup separate tables for virtual devices
just retrieving VID from the address. A device address space can
maintain addresses and references on them separately for each virtual
device if it needs so, or only addresses for real device (and all its
vlans) it holds usually.

A vlan device can be in any place of device chain upper real device,
say smth like rdevice/bonding/vlan or even rdevice/macvlan/vlan.
Similar approach can be used for passing additional information for
virtual devices as allmulti flag or/and promisc flag and do this per
vlan, but this is separate story and could be added as a continuation.

I was biased by try to add exclusive mcast and ucast support for vlans
and now have same with small generic correction and mostly locally in
the cpsw driver:
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=ucast_vlan_fix
https://git.linaro.org/people/ivan.khoronzhuk/tsn_kernel.git/log/?h=mcast_vlan
and can say it looks better with generic changes provided by this patchset,
that's why this RFC. Above links can be used as fallback.

This series is verified on TI am572x EVM that can hold separate tables
for vlans. Potentially it can be easily extended to netcp driver for
keystone 2 boards (including k2g) and also new am6 chipsets. As a
simple test case, different combinations of vlan+macvlan, macvlan+vlan
were used and tested as with unicast as multicast addresses.

Based on net-next/master

Ivan Khoronzhuk (5):
  net: core: dev_addr_lists: add VID to device address space
  net: 8021q: vlan_dev: add vid tag for uc and mc address lists
  net: 8021q: vlan_dev: add vid tag for vlan device mac address
  net: ethernet: add default vid len for all ehternet kind devices
  net: ethernet: ti: cpsw: update mc vlan and add uc vlan support based
    on addr vids

 drivers/net/ethernet/ti/cpsw.c |  86 +++++++++++++++++++----
 include/linux/if_vlan.h        |   1 +
 include/linux/netdevice.h      |   7 ++
 net/8021q/vlan.c               |   3 +
 net/8021q/vlan_core.c          |  10 +++
 net/8021q/vlan_dev.c           | 103 ++++++++++++++++++++++-----
 net/core/dev_addr_lists.c      | 124 +++++++++++++++++++++++++++------
 net/ethernet/eth.c             |  15 +++-
 8 files changed, 290 insertions(+), 59 deletions(-)

-- 
2.17.1
