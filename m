From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP35x: Add support for 720MHz part
Date: Tue, 13 Oct 2009 12:14:20 -0700
Message-ID: <874oq3ksxf.fsf@deeprootsystems.com>
References: <1255351453-9023-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:47296 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761049AbZJMTPe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 15:15:34 -0400
Received: by pxi10 with SMTP id 10so162618pxi.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 12:14:22 -0700 (PDT)
In-Reply-To: <1255351453-9023-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Mon\, 12 Oct 2009 18\:14\:09 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> This patch adds support for ARM running at 720MHz part.
>
> The 720MHz capability can be probed run-time by reading the
> PRODID.SKUID[3:0] at 0x4830A20C.
>
>   [1] http://focus.ti.com/lit/ug/spruff1d/spruff1d.pdf
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>
>
> ---
>  arch/arm/mach-omap2/clock34xx.c           |    6 ++++++
>  arch/arm/mach-omap2/id.c                  |   11 +++++++++++
>  arch/arm/plat-omap/include/mach/control.h |    7 +++++++
>  arch/arm/plat-omap/include/mach/cpu.h     |    2 ++
>  4 files changed, 26 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
> index 489556e..9b56af3 100644
> --- a/arch/arm/mach-omap2/clock34xx.c
> +++ b/arch/arm/mach-omap2/clock34xx.c
> @@ -1096,6 +1096,12 @@ static int __init omap2_clk_arch_init(void)
>  	if (!mpurate)
>  		return -EINVAL;
>  
> +	if ((mpurate == 720000000) && !omap3_has_720mhz()) {
> +		printk(KERN_ERR "*** Silicon doesn't support 720MHz\n");
> +
> +		mpurate = 600000000;  /* Set to highest supported */
> +	}
> +

This is very platform specific check here.  We're not checking for any
other valid mpurate values here. I think we should leave it to the
(forthcoming) OPP layer to to validate the frequency etc. 

I recommend just dropping the clock34xx.c changes and posting a patch
which just adds the new speed as a feature.

>  	/* REVISIT: not yet ready for 343x */
>  	if (clk_set_rate(&dpll1_ck, mpurate))
>  		printk(KERN_ERR "*** Unable to set MPU rate\n");
> diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
> index d4d563b..e0b427a 100644
> --- a/arch/arm/mach-omap2/id.c
> +++ b/arch/arm/mach-omap2/id.c
> @@ -79,6 +79,7 @@ EXPORT_SYMBOL(omap_type);
>  #define OMAP_TAP_DIE_ID_2	0x0220
>  #define OMAP_TAP_DIE_ID_3	0x0224
>  
> +

stray whitespace change

>  #define read_tap_reg(reg)	__raw_readl(tap_base  + (reg))
>  
>  struct omap_id {
> @@ -180,6 +181,15 @@ void __init omap3_check_features(void)
>  	 * TODO: Get additional info (where applicable)
>  	 *       e.g. Size of L2 cache.
>  	 */
> +
> +	/*
> +	 * Does it support 720MHz?
> +	 */
> +	status = (OMAP3_SKUID_MASK & read_tap_reg(OMAP3_PRODID));
> +

Some comment here that the runtime detection of this feature is only
available on 35xx parts would be useful too.

Kevin
