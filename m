From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 0/2] net: ethernet: ti: cpsw_switchdev: fix unmet
 direct dependencies detected for NET_SWITCHDEV
Date: Thu, 05 Dec 2019 14:39:44 -0800 (PST)
Message-ID: <20191205.143944.1644239054512253859.davem@davemloft.net>
References: <20191204174533.32207-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191204174533.32207-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: grygorii.strashko@ti.com
Cc: rdunlap@infradead.org, netdev@vger.kernel.org, tony@atomide.com, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>
Date: Wed, 4 Dec 2019 19:45:31 +0200

> This series fixes Kconfig warning with CONFIG_COMPILE_TEST=y reported by
> Randy Dunlap <rdunlap@infradead.org> [1]
> 
> [1] https://lkml.org/lkml/2019/12/3/1373

I applied patch #1 to the networking tree, the defconfig update has to be routed via
the appropriate architecture tree.

Thank you.
