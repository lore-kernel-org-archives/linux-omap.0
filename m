From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v4 11/12] ARM: OMAP1: DMTIMER: fix broken timer clock
 source selection
Date: Tue, 17 Apr 2012 14:48:03 -0700
Message-ID: <20120417214802.GH21106@atomide.com>
References: <20120411003454.27059.37500.stgit@dusk>
 <20120411003559.27059.1315.stgit@dusk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:20597 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101Ab2DQVsH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 17 Apr 2012 17:48:07 -0400
Content-Disposition: inline
In-Reply-To: <20120411003559.27059.1315.stgit@dusk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tarun Kanti DebBarma <tarun.kanti@ti.com>

* Paul Walmsley <paul@pwsan.com> [120410 17:41]:
> DMTIMER source selection on OMAP1 is broken.  omap1_dm_timer_set_src()
> tries to use __raw_{read,write}l() to read from and write to physical
> addresses, but those functions take virtual addresses.
> 
> sparse caught this:
> 
> arch/arm/mach-omap1/timer.c:50:13: warning: incorrect type in argument 1 (different base types)
> arch/arm/mach-omap1/timer.c:50:13:    expected void const volatile [noderef] <asn:2>*<noident>
> arch/arm/mach-omap1/timer.c:50:13:    got unsigned int
> arch/arm/mach-omap1/timer.c:52:9: warning: incorrect type in argument 1 (different base types)
> arch/arm/mach-omap1/timer.c:52:9:    expected void const volatile [noderef] <asn:2>*<noident>
> arch/arm/mach-omap1/timer.c:52:9:    got unsigned int
> 
> Fix by using omap_{read,writel}(), just like the other users of the
> MOD_CONF_CTRL_1 register in the OMAP1 codebase.  Of course, in the long term,
> removing omap_{read,write}l() is the appropriate thing to do; but
> this will take some work to do this cleanly.
> 
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Tarun Kanti DebBarma <tarun.kanti@ti.com>

Uhh looks like this was caused by commit 97933d6 (ARM: OMAP1: dmtimer: conversion
to platform devices) moving code and changing it :(

I'll pick this to fixes.

Tony

> ---
>  arch/arm/mach-omap1/timer.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
> index 5536e04..64c65bc 100644
> --- a/arch/arm/mach-omap1/timer.c
> +++ b/arch/arm/mach-omap1/timer.c
> @@ -47,9 +47,9 @@ static int omap1_dm_timer_set_src(struct platform_device *pdev,
>  	int n = (pdev->id - 1) << 1;
>  	u32 l;
>  
> -	l = __raw_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
> +	l = omap_readl(MOD_CONF_CTRL_1) & ~(0x03 << n);
>  	l |= source << n;
> -	__raw_writel(l, MOD_CONF_CTRL_1);
> +	omap_writel(l, MOD_CONF_CTRL_1);
>  
>  	return 0;
>  }
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
