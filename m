From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix omap_wdt driver failure on 2420 when
	running multi-omap config
Date: Sat, 23 Aug 2008 16:18:52 -0700
Message-ID: <20080823231852.GK4713@atomide.com>
References: <1219306810-12232-1-git-send-email-jarkko.nikula@nokia.com> <1219306810-12232-3-git-send-email-jarkko.nikula@nokia.com> <20080821123238.0d205e16.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56706 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752684AbYHWXSy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 19:18:54 -0400
Content-Disposition: inline
In-Reply-To: <20080821123238.0d205e16.jarkko.nikula@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@nokia.com>
Cc: linux-omap@vger.kernel.org

* Jarkko Nikula <jarkko.nikula@nokia.com> [080821 02:34]:
> Signed-off line was missing...
> 
> ----------------------------->
> 
> omap_wdt driver will do unhandled fault on 2420 if support for 2430 is
> compiled in since wrong base address is defined in that case. Assign
> omap_wdt base address runtime depending on cpu type.

Pushing today.

Tony


> Signed-off-by: Jarkko Nikula <jarkko.nikula@nokia.com>
> ---
>  arch/arm/plat-omap/devices.c |   30 +++++++++++++-----------------
>  1 files changed, 13 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index f22ccbb..3bd1da2 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -454,25 +454,8 @@ static inline void omap_init_uwire(void) {}
>  
>  #if	defined(CONFIG_OMAP_WATCHDOG) || defined(CONFIG_OMAP_WATCHDOG_MODULE)
>  
> -#if defined(CONFIG_ARCH_OMAP34XX)
> -#define	OMAP_WDT_BASE		0x48314000
> -#elif defined(CONFIG_ARCH_OMAP24XX)
> -
> -#ifdef CONFIG_ARCH_OMAP2430
> -/* WDT2 */
> -#define	OMAP_WDT_BASE		0x49016000
> -#else
> -#define	OMAP_WDT_BASE		0x48022000
> -#endif
> -
> -#else
> -#define	OMAP_WDT_BASE		0xfffeb000
> -#endif
> -
>  static struct resource wdt_resources[] = {
>  	{
> -		.start		= OMAP_WDT_BASE,
> -		.end		= OMAP_WDT_BASE + 0x4f,
>  		.flags		= IORESOURCE_MEM,
>  	},
>  };
> @@ -486,6 +469,19 @@ static struct platform_device omap_wdt_device = {
>  
>  static void omap_init_wdt(void)
>  {
> +	if (cpu_is_omap16xx())
> +		wdt_resources[0].start = 0xfffeb000;
> +	else if (cpu_is_omap2420())
> +		wdt_resources[0].start = 0x48022000; /* WDT2 */
> +	else if (cpu_is_omap2430())
> +		wdt_resources[0].start = 0x49016000; /* WDT2 */
> +	else if (cpu_is_omap343x())
> +		wdt_resources[0].start = 0x48314000; /* WDT2 */
> +	else
> +		return;
> +
> +	wdt_resources[0].end = wdt_resources[0].start + 0x4f;
> +
>  	(void) platform_device_register(&omap_wdt_device);
>  }
>  #else
> -- 
> 1.5.6.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
