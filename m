From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] Combine dsi and sdi under the same vdds supply.
Date: Fri, 16 Jul 2010 17:21:58 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.1007161720010.19679@utopia.booyaka.com>
References: <1279224930.14213.12.camel@black>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:36657 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759459Ab0GPXV7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 16 Jul 2010 19:21:59 -0400
In-Reply-To: <1279224930.14213.12.camel@black>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>, Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Mathieu Poirier <mathieu.poirier@canonical.com>, tony@atomide.com, linux-omap@vger.kernel.org

Tomi, Koen,

On Thu, 15 Jul 2010, Mathieu Poirier wrote:

> >From b817304b25a0358f2897d39048adfada8d4126bc Mon Sep 17 00:00:00 2001
> From: Mathieu J. Poirier <mathieu.poirier@canonical.com>
> Date: Wed, 14 Jul 2010 15:31:46 -0600
> Subject: [PATCH] Combine dsi and sdi under the same vdds supply.
> 
> The omapfb driver can't locate its display sink because of an
> initialization error in the DSS subsystem.  This error is caused by a
> missing sdi entry in the board power regulator list.  Adding the missing
> sdi entry and combining dsi and sdi under the same vdds supply.
> 
> BugLink: https://bugs.launchpad.net/bugs/597904
> 
> Signed-off-by: <mathieu.poirier@canonical.com>

care to take a quick look at this one?


- Paul


> ---
>  arch/arm/mach-omap2/board-omap3beagle.c |   11 ++++++-----
>  1 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index 69b154c..32565dc 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -162,8 +162,10 @@ static struct platform_device beagle_dss_device = {
>  static struct regulator_consumer_supply beagle_vdac_supply =
>  	REGULATOR_SUPPLY("vdda_dac", "omapdss");
>  
> -static struct regulator_consumer_supply beagle_vdvi_supply =
> -	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
> +static struct regulator_consumer_supply beagle_vdds_supplies[] = {
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +	REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
> +};
>  
>  static void __init beagle_display_init(void)
>  {
> @@ -291,7 +293,6 @@ static struct regulator_init_data beagle_vdac = {
>  /* VPLL2 for digital video outputs */
>  static struct regulator_init_data beagle_vpll2 = {
>  	.constraints = {
> -		.name			= "VDVI",
>  		.min_uV			= 1800000,
>  		.max_uV			= 1800000,
>  		.valid_modes_mask	= REGULATOR_MODE_NORMAL
> @@ -299,8 +300,8 @@ static struct regulator_init_data beagle_vpll2 = {
>  		.valid_ops_mask		= REGULATOR_CHANGE_MODE
>  					| REGULATOR_CHANGE_STATUS,
>  	},
> -	.num_consumer_supplies	= 1,
> -	.consumer_supplies	= &beagle_vdvi_supply,
> +	.num_consumer_supplies  = ARRAY_SIZE(beagle_vdds_supplies),
> +	.consumer_supplies      = beagle_vdds_supplies,
>  };
>  
>  static struct twl4030_usb_data beagle_usb_data = {
> -- 
> 1.7.0.4
> 
> 
> 


