From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ARM: l2x0: Errata fix for flush by Way operation
	can cause data corruption
Date: Sun, 27 Feb 2011 12:00:21 +0000
Message-ID: <20110227120021.GA15314@n2100.arm.linux.org.uk>
References: <1298032525-21115-1-git-send-email-santosh.shilimkar@ti.com> <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:57433 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab1B0MAu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 27 Feb 2011 07:00:50 -0500
Content-Disposition: inline
In-Reply-To: <1298032525-21115-2-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, tony@atomide.com, catalin.marinas@arm.com, linux-omap@vger.kernel.org

On Fri, Feb 18, 2011 at 06:05:24PM +0530, Santosh Shilimkar wrote:
> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
> index 170c9bb..a8caee4 100644
> --- a/arch/arm/mm/cache-l2x0.c
> +++ b/arch/arm/mm/cache-l2x0.c
> @@ -67,18 +67,22 @@ static inline void l2x0_inv_line(unsigned long addr)
>  	writel_relaxed(addr, base + L2X0_INV_LINE_PA);
>  }
>  
> -#ifdef CONFIG_PL310_ERRATA_588369
> +#if defined(CONFIG_PL310_ERRATA_588369) || defined(CONFIG_PL310_ERRATA_727915)
>  static void debug_writel(unsigned long val)
>  {
> -	extern void omap_smc1(u32 fn, u32 arg);
> -
> -	/*
> -	 * Texas Instrument secure monitor api to modify the
> -	 * PL310 Debug Control Register.
> -	 */
> -	omap_smc1(0x100, val);
> +	if (outer_cache.set_debug)
> +		outer_cache.set_debug(val);
> +	else
> +		writel(val, l2x0_base + L2X0_DEBUG_CTRL);
> +}

I think changing this to:

#define debug_writel(val)	outer_cache.set_debug(val)

static void l2x0_set_debug(unsigned long val)
{
	writel(val, l2x0_base + L2X0_DEBUG_CTRL);
}

> +#else
> +/* Optimised out for non-errata case */
> +static inline void debug_writel(unsigned long val)
> +{
>  }

#define l2x0_set_debug	NULL

> +#endif

> @@ -329,6 +330,7 @@ void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>  	outer_cache.flush_all = l2x0_flush_all;
>  	outer_cache.inv_all = l2x0_inv_all;
>  	outer_cache.disable = l2x0_disable;
> +	outer_cache.set_debug = NULL;

	outer_cache.set_debug = l2x0_set_debug;

may result in more efficient code as we're avoiding having to test the
value of outer_cache.set_debug each time we want to call it and branch
appropriately.
