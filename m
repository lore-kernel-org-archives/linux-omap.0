From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH v2] ARM: OMAP3: Check for L2 cache enabled
Date: Sat, 10 May 2008 23:48:39 +0300
Message-ID: <20080510204838.GA5553@kedavra.cpe.vivax.com.br>
References: <4825EC4B.1020903@googlemail.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:48553 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758254AbYEJUrk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 10 May 2008 16:47:40 -0400
Content-Disposition: inline
In-Reply-To: <4825EC4B.1020903@googlemail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap@vger.kernel.org

On Sat, May 10, 2008 at 08:41:15PM +0200, Dirk Behme wrote:
>
> Enabling L2 cache of Cortex-A8 based OMAP3 has to be done by bootloader. 
> Check if this is done and warn if not.
>
> Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
>
> ----
>
> Changes in v2: Fix a typo.

> Index: linux-beagle/arch/arm/mach-omap2/id.c
> ===================================================================
> --- linux-beagle.orig/arch/arm/mach-omap2/id.c
> +++ linux-beagle/arch/arm/mach-omap2/id.c
> @@ -267,3 +267,26 @@ void __init omap2_check_revision(void)
>  
>  }
>  
> +#ifdef CONFIG_ARCH_OMAP3
> +/*
> + * OMAP3 has L2 cache which has to be enabled by bootloader.
> + */
> +static int __init omap3_check_l2cache(void)
> +{
> +	u32 val;
> +
> +	/* Get CP15 AUX register, bit 1 enabled indicates L2 cache is on */
> +	asm volatile("mrc p15, 0, %0, c1, c0, 1":"=r" (val));
> +
> +	if ((val & 0x2) == 0) {

The {} are unneeded here.

> +		printk(KERN_WARNING "Warning: L2 cache not enabled. Check "
> +		       "your bootloader. L2 off results in performance loss\n");
> +	} else {

same here.

> +		pr_info("OMAP3 L2 cache enabled");
> +	}
> +
> +	return 0;
> +}
> +
> +arch_initcall(omap3_check_l2cache);
> +#endif /* CONFIG_ARCH_OMAP3 */


-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
