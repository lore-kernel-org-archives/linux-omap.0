From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap: Enable GPMC clock in gpmc_init
Date: Wed, 20 Jan 2010 17:24:56 -0800
Message-ID: <20100121012456.GH23467@atomide.com>
References: <20100120223929.GA10739@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63372 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751268Ab0AUBYu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 20 Jan 2010 20:24:50 -0500
Content-Disposition: inline
In-Reply-To: <20100120223929.GA10739@lixom.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: linux-omap@vger.kernel.org

* Olof Johansson <olof@lixom.net> [100120 14:36]:
> Don't assume that gpmc_l3_clk is on, enable it before touching
> configuration registers.

Seems like this is OK to do even though we do not disable it anywhere
currently since we're setting smart idle and L3 autogating also
in gpmc_init. So adding to omap-fixes.

Regards,

Tony

 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index e86f5ca..dea72f3 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -534,6 +534,8 @@ void __init gpmc_init(void)
>  		BUG();
>  	}
>  
> +	clk_enable(gpmc_l3_clk);
> +
>  	l = gpmc_read_reg(GPMC_REVISION);
>  	printk(KERN_INFO "GPMC revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
>  	/* Set smart idle mode and automatic L3 clock gating */
