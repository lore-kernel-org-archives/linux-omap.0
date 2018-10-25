From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next 0/4] net: ethernet: ti: cpsw: fix vlan mcast
Date: Thu, 25 Oct 2018 11:34:41 -0700 (PDT)
Message-ID: <20181025.113441.567599603045046210.davem@davemloft.net>
References: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181024221059.21834-1-ivan.khoronzhuk@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ivan.khoronzhuk@linaro.org
Cc: grygorii.strashko@ti.com, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@intel.com, bjorn@mork.no
List-Id: linux-omap@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Thu, 25 Oct 2018 01:10:55 +0300

> The cpsw holds separate mcast entires for vlan entries. At this moment
> driver adds only not vlan mcast addresses, omitting vlan/mcast entries.
> As result mcast for vlans doesn't work. It can be fixed by adding same
> mcast entries for every created vlan, but this patchseries uses more
> sophisticated way and allows to create mcast entries only for vlans
> that really require it. Generic functions from this series can be
> reused for fixing vlan and macvlan unicast.

This is a bug fix but targetted at net-next, and indeed it is quite
invasive as it adds new core infrastructure and converts the generic
vlan code over to using it.

Unfortunately net-next is closed.

So if you want this bug fixed in mainline you will have to come up
with a less invasive fix, and resubmit this net-next approach when the
net-next tree opens back up.

Thank you.
