From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/2] net: ethernet: cpsw-phy-sel: prefer phandle for
 phy sel
Date: Sun, 02 Sep 2018 13:52:51 -0700 (PDT)
Message-ID: <20180902.135251.1636829495138774363.davem@davemloft.net>
References: <20180829150024.43210-1-tony@atomide.com>
        <20180829150024.43210-2-tony@atomide.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180829150024.43210-2-tony@atomide.com>
Sender: netdev-owner@vger.kernel.org
To: tony@atomide.com
Cc: netdev@vger.kernel.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, andrew@lunn.ch, grygorii.strashko@ti.com, ivan.khoronzhuk@linaro.org, mark.rutland@arm.com, m-karicheri2@ti.com, robh+dt@kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>
Date: Wed, 29 Aug 2018 08:00:24 -0700

> The cpsw-phy-sel device is not a child of the cpsw interconnect target
> module. It lives in the system control module.
> 
> Let's fix this issue by trying to use cpsw-phy-sel phandle first if it
> exists and if not fall back to current usage of trying to find the
> cpsw-phy-sel child. That way the phy sel driver can be a child of the
> system control module where it belongs in the device tree.
> 
> Without this fix, we cannot have a proper interconnect target module
> hierarchy in device tree for things like genpd.
> 
> Note that deferred probe is mostly not supported by cpsw and this patch
> does not attempt to fix that. In case deferred probe support is needed,
> this could be added to cpsw_slave_open() and phy_connect() so they start
> handling and returning errors.
> 
> For documenting it, looks like the cpsw-phy-sel is used for all cpsw device
> tree nodes. It's missing the related binding documentation, so let's also
> update the binding documentation accordingly.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied.
