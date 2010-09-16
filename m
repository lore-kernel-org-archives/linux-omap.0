From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 04/11] OMAP: mach-omap2: Fix miscellaneous sparse
 warnings
Date: Thu, 16 Sep 2010 12:27:58 -0700
Message-ID: <20100916192758.GL29610@atomide.com>
References: <1282856209-15645-1-git-send-email-manjugk@ti.com>
 <1282856209-15645-5-git-send-email-manjugk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52753 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752309Ab0IPT2E (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 16 Sep 2010 15:28:04 -0400
Content-Disposition: inline
In-Reply-To: <1282856209-15645-5-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "G, Manjunath Kondaiah" <manjugk@ti.com>
Cc: linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>

* G, Manjunath Kondaiah <manjugk@ti.com> [100826 13:50]:
> From: Manjunatha GK <manjugk@ti.com>
> 
> This patch fixes miscellaneous sparse warnings in mach-omap2.
> 
> arch/arm/mach-omap2/board-am3517evm.c:141:17: warning: Initializer entry defined twice
> arch/arm/mach-omap2/board-am3517evm.c:142:18:   also defined here
> 
> arch/arm/mach-omap2/irq.c:50:35: warning: Using plain integer as NULL pointer
> 
> Signed-off-by: Manjunatha GK <manjugk@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/board-am3517evm.c |    1 -
>  arch/arm/mach-omap2/irq.c             |    2 +-
>  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
> index ae22ea8..b091741 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -139,7 +139,6 @@ static void am3517_evm_ethernet_init(struct emac_platform_data *pdata)
>  static struct i2c_board_info __initdata am3517evm_i2c1_boardinfo[] = {
>  	{
>  		I2C_BOARD_INFO("s35390a", 0x30),
> -		.type		= "s35390a",
>  	},
>  };

OK, I2C_BOARD_INFO sets it too.
  
> diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
> index 26aeef5..02fd942 100644
> --- a/arch/arm/mach-omap2/irq.c
> +++ b/arch/arm/mach-omap2/irq.c
> @@ -47,7 +47,7 @@ static struct omap_irq_bank {
>  } __attribute__ ((aligned(4))) irq_banks[] = {
>  	{
>  		/* MPU INTC */
> -		.base_reg	= 0,
> +		.base_reg	= (void __iomem *)0,
>  		.nr_irqs	= 96,
>  	},
>  };

The base_reg line you can remove, the static data area gets zeroed
during init.

Regards,

Tony
