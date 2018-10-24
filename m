From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Thu, 25 Oct 2018 01:10:55 +0300
Message-ID: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com, bjorn@mork.no, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
List-Id: linux-omap@vger.kernel.org

The cpsw holds separate mcast entires for vlan entries. At this moment
driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
As result mcast for vlans doesn't work. It can be fixed by adding same
mcast entries for every created vlan, but this patchseries uses more
sophisticated way and allows to create mcast entries only for vlans
that really require it. Generic functions from this series can be
reused for fixing vlan and macvlan unicast.

Simple example of ALE table before and after this series, having same
mcast entries as for vlan 100 as for real device (reserved vlan 2),
and one mcast address only for vlan 100 - 01:1b:19:00:00:00.

<---- Before this patchset ---->
vlan , vid = 2, untag_force = 0x5, reg_mcast = 0x5, mem_list = 0x5
mcast, vid = 2, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 2, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
vlan , vid = 0, untag_force = 0x7, reg_mcast = 0x0, mem_list = 0x7
mcast, vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:00:5e:00:00:01, port_mask = 0x1
vlan , vid = 1, untag_force = 0x3, reg_mcast = 0x3, mem_list = 0x3
mcast, vid = 1, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 1, addr = 74:da:ea:47:7d:9c, persistant, port_num = 0x0
mcast, vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 2, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 1, addr = 33:33:ff:47:7d:9c, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:fb, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:fc, port_mask = 0x1
vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x5, mem_list = 0x5
ucast, vid = 100, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
mcast, vid = 100, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
mcast, vid = 2, addr = 01:1b:19:00:00:00, port_mask = 0x1
			 ^^^
 Here mcast entry (ptpl2), has to be added only for vlan 100
 but added for reserved vlan 2...that's not enough.

<---- After this patchset ---->
vlan , vid = 2, untag_force = 0x5, reg_mcast = 0x5, mem_list = 0x5
mcast, vid = 2, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 2, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
vlan , vid = 0, untag_force = 0x7, reg_mcast = 0x0, mem_list = 0x7
mcast, vid = 2, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:00:5e:00:00:01, port_mask = 0x1
vlan , vid = 1, untag_force = 0x3, reg_mcast = 0x3, mem_list = 0x3
mcast, vid = 1, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
ucast, vid = 1, addr = 74:da:ea:47:7d:9c, persistant, port_num = 0x0
mcast, vid = 1, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 1, addr = 01:00:5e:00:00:01, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 2, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 1, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 2, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
mcast, vid = 1, addr = 33:33:ff:47:7d:9c, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 2, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 1, addr = 33:33:00:01:00:03, port_mask = 0x1
vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x5, mem_list = 0x5
ucast, vid = 100, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
mcast, vid = 100, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
mcast, vid = 100, addr = 33:33:00:00:00:01, port_mask = 0x1
mcast, vid = 100, addr = 01:00:5e:00:00:01, port_mask = 0x1
mcast, vid = 100, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
mcast, vid = 100, addr = 01:80:c2:00:00:00, port_mask = 0x1
mcast, vid = 100, addr = 01:80:c2:00:00:03, port_mask = 0x1
mcast, vid = 100, addr = 01:80:c2:00:00:0e, port_mask = 0x1
mcast, vid = 100, addr = 33:33:00:00:00:fb, port_mask = 0x1
mcast, vid = 100, addr = 33:33:00:01:00:03, port_mask = 0x1
mcast, vid = 100, addr = 01:1b:19:00:00:00, port_mask = 0x1
			 ^^^
    Here mcast entry (ptpl2), is added only for vlan 100
    as it should be.

Based on net-next/master

Ivan Khoronzhuk (4):
  net: core: dev_addr_lists: add auxiliary func to handle reference
    address updates
  net: 8021q: vlan_core: allow use list of vlans for real device
  net: ethernet: ti: cpsw: fix vlan mcast
  net: ethernet: ti: cpsw: fix vlan configuration while down/up

 drivers/net/ethernet/ti/cpsw.c | 212 ++++++++++++++++++++++++++++-----
 include/linux/if_vlan.h        |  11 ++
 include/linux/netdevice.h      |  10 ++
 net/8021q/vlan_core.c          |  27 +++++
 net/core/dev_addr_lists.c      |  97 +++++++++++++++
 5 files changed, 326 insertions(+), 31 deletions(-)

-- 
2.17.1
