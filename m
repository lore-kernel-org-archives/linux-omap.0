From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH 6/6 v2] OMAP2PLUS: WDT: Conversion to runtime PM
Date: Wed, 11 Aug 2010 11:45:21 -0700
Message-ID: <87lj8d0z0e.fsf@deeprootsystems.com>
References: <1281521471-15802-1-git-send-email-charu@ti.com>
	<1281521471-15802-2-git-send-email-charu@ti.com>
	<1281521471-15802-3-git-send-email-charu@ti.com>
	<1281521471-15802-4-git-send-email-charu@ti.com>
	<1281521471-15802-5-git-send-email-charu@ti.com>
	<1281521471-15802-6-git-send-email-charu@ti.com>
	<1281521471-15802-7-git-send-email-charu@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60816 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab0HKSpY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 Aug 2010 14:45:24 -0400
Received: by pzk26 with SMTP id 26so159861pzk.19
        for <linux-omap@vger.kernel.org>; Wed, 11 Aug 2010 11:45:23 -0700 (PDT)
In-Reply-To: <1281521471-15802-7-git-send-email-charu@ti.com> (Charulatha V.'s
	message of "Wed, 11 Aug 2010 15:41:11 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Charulatha V <charu@ti.com>
Cc: linux-omap@vger.kernel.org, wim@iguana.be, paul@pwsan.com, b-cousson@ti.com, rnayak@ti.com, p-basak2@ti.com

Charulatha V <charu@ti.com> writes:

> This patch converts the OMAP Watchdog timer driver to
> get adapted to HWMOD FW and to use the runtime PM APIs.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Basak, Partha <p-basak2@ti.com>

This series looks good.  One minor comment below...

> ---
>  arch/arm/plat-omap/devices.c |   52 ++++++++++++++++++++++++++++++-----------
>  drivers/watchdog/omap_wdt.c  |   43 ++++++----------------------------
>  2 files changed, 46 insertions(+), 49 deletions(-)
>
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index d1920be..efe2aff 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -15,6 +15,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>
> +#include <linux/err.h>
>  
>  #include <mach/hardware.h>
>  #include <asm/mach-types.h>
> @@ -28,6 +29,8 @@
>  #include <plat/menelaus.h>
>  #include <plat/mcbsp.h>
>  #include <plat/omap44xx.h>
> +#include <plat/omap_hwmod.h>
> +#include <plat/omap_device.h>
>  
>  /*-------------------------------------------------------------------------*/
>  
> @@ -238,6 +241,8 @@ static inline void omap_init_uwire(void) {}
>  
>  static struct resource wdt_resources[] = {
>  	{
> +		.start		= 0xfffeb000,
> +		.end		= 0xfffeb07F,
>  		.flags		= IORESOURCE_MEM,
>  	},
>  };

This struct should probably be renamed with an omap1_ prefix.

> @@ -249,24 +254,43 @@ static struct platform_device omap_wdt_device = {
>  	.resource	= wdt_resources,
>  };

ditto

and they should be moved down just above omap_init_wdt()

> -static void omap_init_wdt(void)
> +struct omap_device_pm_latency omap_wdt_latency[] = {
> +	[0] = {
> +		.deactivate_func = omap_device_idle_hwmods,
> +		.activate_func   = omap_device_enable_hwmods,
> +		.flags		 = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
> +	},
> +};
> +
> +static void omap2_init_wdt()
>  {
> -	if (cpu_is_omap16xx())
> -		wdt_resources[0].start = 0xfffeb000;
> -	else if (cpu_is_omap2420())
> -		wdt_resources[0].start = 0x48022000; /* WDT2 */
> -	else if (cpu_is_omap2430())
> -		wdt_resources[0].start = 0x49016000; /* WDT2 */
> -	else if (cpu_is_omap343x())
> -		wdt_resources[0].start = 0x48314000; /* WDT2 */
> -	else if (cpu_is_omap44xx())
> -		wdt_resources[0].start = 0x4a314000;
> -	else
> +	int id = -1;
> +	struct omap_device *od;
> +	struct omap_hwmod *oh;
> +	char *oh_name = "wd_timer2";
> +	char *name = "omap_wdt";
> +
> +	oh = omap_hwmod_lookup(oh_name);
> +	if (!oh) {
> +		pr_err("Could not look up %s\n", oh_name);
>  		return;
> +	}

Kevin
