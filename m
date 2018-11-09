From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Thu, 08 Nov 2018 20:32:57 -0800 (PST)
Message-ID: <20181108.203257.130600128161514091.davem@davemloft.net>
References: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181108202757.30110-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com, bjorn@mork.no
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu,  8 Nov 2018 22:27:53 +0200

> The cpsw holds separate mcast entires for vlan entries. At this moment
> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
> As result mcast for vlans doesn't work. It can be fixed by adding same
> mcast entries for every created vlan, but this patchseries uses more
> sophisticated way and allows to create mcast entries only for vlans
> that really require it. Generic functions from this series can be
> reused for fixing vlan and macvlan unicast.
> 
> Simple example of ALE table before and after this series, having same
> mcast entries as for vlan 100 as for real device (reserved vlan 2),
> and one mcast address only for vlan 100 - 01:1b:19:00:00:00.
 ...
> Based on net-next/master
> 
> v2..v1:
>   net: ethernet: ti: cpsw: fix vlan mcast
> 	- removed limit for legacy switch cpsw mode

Series applied.
