From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [RFC PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Tue, 16 Oct 2018 14:38:33 -0500
Message-ID: <92ab4728-109f-01cc-09db-3da4d8c8e92e@ti.com>
References: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181016182035.18234-1-ivan.khoronzhuk@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, davem@davemloft.net
Cc: linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com
List-Id: linux-omap@vger.kernel.org



On 10/16/2018 01:20 PM, Ivan Khoronzhuk wrote:
> The cpsw holds separate mcast entires for vlan entries. At this moment
> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
> As result mcast for vlans doesn't work. It can be fixed by adding same
> mcast entries for every created vlan, but this patchseries uses more
> sophisticated way and allows to create mcast entries only for vlans
> that really require it. Generic functions from this series can be
> reused for fixing vlan and macvlan unicast.

I assume this is first of all for dual_mac mode.

> 
> Simple example of ALE table before and after this series, having same
> mcast entries as for vlan 100 as for real device (reserved vlan 2),
> and one mcast address only for vlan 100 - 01:1b:19:00:00:00.
> 
[...]

> vlan , vid = 100, untag_force = 0x0, reg_mcast = 0x5, mem_list = 0x5
> ucast, vid = 100, addr = 74:da:ea:47:7d:9d, persistant, port_num = 0x0
> mcast, vid = 100, addr = ff:ff:ff:ff:ff:ff, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:00:00:00:01, port_mask = 0x1
> mcast, vid = 100, addr = 01:00:5e:00:00:01, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:ff:47:7d:9d, port_mask = 0x1
> mcast, vid = 100, addr = 01:80:c2:00:00:00, port_mask = 0x1
> mcast, vid = 100, addr = 01:80:c2:00:00:03, port_mask = 0x1
> mcast, vid = 100, addr = 01:80:c2:00:00:0e, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:00:00:00:fb, port_mask = 0x1
> mcast, vid = 100, addr = 33:33:00:01:00:03, port_mask = 0x1
> mcast, vid = 100, addr = 01:1b:19:00:00:00, port_mask = 0x1
> 			 ^^^
>      Here mcast entry (ptpl2), is added only for vlan 100
>      as it should be.
> 
> Based on net-next/master

Thank you.
For patches 2-4
Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

For patch 1 - I'm not sure, so it'd good to get more comments.

> 
> Ivan Khoronzhuk (4):
>    net: core: dev_addr_lists: add auxiliary func to handle reference
>      address updates
>    net: 8021q: vlan_core: allow use list of vlans for real device
>    net: ethernet: ti: cpsw: fix vlan mcast
>    net: ethernet: ti: cpsw: fix vlan configuration while down/up
> 
>   drivers/net/ethernet/ti/cpsw.c | 189 +++++++++++++++++++++++++++------
>   include/linux/if_vlan.h        |  10 ++
>   include/linux/netdevice.h      |  10 ++
>   net/8021q/vlan_core.c          |  27 +++++
>   net/core/dev_addr_lists.c      |  97 +++++++++++++++++
>   5 files changed, 303 insertions(+), 30 deletions(-)
> 

-- 
regards,
-grygorii
