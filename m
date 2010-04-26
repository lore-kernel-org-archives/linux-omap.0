From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 01/10] OMAP1 clock: fix section mismatch on clk_init
Date: Mon, 26 Apr 2010 11:11:57 -0700
Message-ID: <20100426181157.GF7225@atomide.com>
References: <20100426070217.9743.92728.stgit@localhost.localdomain>
 <20100426070420.9743.33754.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:53550 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753078Ab0DZSL7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 14:11:59 -0400
Content-Disposition: inline
In-Reply-To: <20100426070420.9743.33754.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Felipe Balbi <felipe.balbi@nokia.com>

* Paul Walmsley <paul@pwsan.com> [100426 00:03]:
> From: Felipe Balbi <felipe.balbi@nokia.com>
> 
> remove the section annotation from omap1_clk_disable_unused()
> to kill the section mismatch warning.

In the long term this should be fixed properly.

The disable_unused is only called once with a late_initcall.
I'd rather not waste that memory keeping an __init function
around.

Regards,

Tony


> Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> ---
>  arch/arm/mach-omap1/clock.c |    2 +-
>  arch/arm/mach-omap1/clock.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index e0aec10..6bbb1b8 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -578,7 +578,7 @@ int omap1_clk_set_rate(struct clk *clk, unsigned long rate)
>  
>  #ifdef CONFIG_OMAP_RESET_CLOCKS
>  
> -void __init omap1_clk_disable_unused(struct clk *clk)
> +void omap1_clk_disable_unused(struct clk *clk)
>  {
>  	__u32 regval32;
>  
> diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
> index a4190af..75d0d7d 100644
> --- a/arch/arm/mach-omap1/clock.h
> +++ b/arch/arm/mach-omap1/clock.h
> @@ -39,7 +39,7 @@ extern long omap1_clk_round_rate_ckctl_arm(struct clk *clk, unsigned long rate);
>  extern unsigned long omap1_watchdog_recalc(struct clk *clk);
>  
>  #ifdef CONFIG_OMAP_RESET_CLOCKS
> -extern void __init omap1_clk_disable_unused(struct clk *clk);
> +extern void omap1_clk_disable_unused(struct clk *clk);
>  #else
>  #define omap1_clk_disable_unused	NULL
>  #endif
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
