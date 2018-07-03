From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V3] ARM: dts: omap3: Fix am3517 mdio and emac clock
 references
Date: Tue, 3 Jul 2018 00:39:44 -0700
Message-ID: <20180703073944.GR112168@atomide.com>
References: <20180625124133.21839-1-aford173@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180625124133.21839-1-aford173@gmail.com>
Sender: stable-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>
Cc: adam.ford@logicpd.com, woods.technical@gmail.com, linux-clk@vger.kernel.org, sboyd@codeaurora.org, mturquette@baylibre.com, linux-omap@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

* Adam Ford <aford173@gmail.com> [180625 05:44]:
> A previous patch removed OMAP clock aliases that were perceived
> to be unnecessary.  Unfortunately, it broke the ethernet on the
> am3517-evm.  This patch enables the MDIO clock and EMAC clock.
> 
> Fixes: 0ed266d7ae5e ("clk: ti: omap3: cleanup unnecessary clock aliases")
> Cc: stable@vger.kernel.org #4.16+
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V3:  Fix subject heading since we're no longer modifying the clk driver
> 
> V2:  Instead of modifying clk-3xxx.c, this patch modifie the device tree
>      to work like the original patch intended.

Thanks applying into omap-for-v4.18/fixes.

Tony
