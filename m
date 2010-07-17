From: <Tomi.Valkeinen@nokia.com>
Subject: RE: [PATCH] Combine dsi and sdi under the same vdds supply.
Date: Sat, 17 Jul 2010 08:18:08 +0200
Message-ID: <3647DBDA80551C4696E9E4506F0BE08E2B422EC9EE@NOK-EUMSG-02.mgdnok.nokia.com>
References: <1279224930.14213.12.camel@black>,<alpine.DEB.2.00.1007161720010.19679@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:64689 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab0GQGU0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 Jul 2010 02:20:26 -0400
In-Reply-To: <alpine.DEB.2.00.1007161720010.19679@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, koen@dominion.thruhere.net, mathieu.poirier@canonical.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org

Hi,

Sorry for top posting, using MS outlook web access.

I don't think this patch is needed. SDI output requires vdds_sdi to work, but beagle board doesn't use SDI. I believe you have for some reason enabled SDI in kernel config. Disabling it should fix the boot problem.

The DSS driver should probably only try to get the regulator if SDI interface is actually being used, as the current way makes it impossible to use the same kernel for different boards...

 Tomi
________________________________________
From: linux-omap-owner@vger.kernel.org [linux-omap-owner@vger.kernel.org] On Behalf Of ext Paul Walmsley [paul@pwsan.com]
Sent: Saturday, July 17, 2010 02:21
To: Koen Kooi; Valkeinen Tomi (Nokia-MS/Helsinki)
Cc: Mathieu Poirier; tony@atomide.com; linux-omap@vger.kernel.org
Subject: Re: [PATCH] Combine dsi and sdi under the same vdds supply.

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
>       REGULATOR_SUPPLY("vdda_dac", "omapdss");
>
> -static struct regulator_consumer_supply beagle_vdvi_supply =
> -     REGULATOR_SUPPLY("vdds_dsi", "omapdss");
> +static struct regulator_consumer_supply beagle_vdds_supplies[] = {
> +     REGULATOR_SUPPLY("vdds_dsi", "omapdss"),
> +     REGULATOR_SUPPLY("vdds_sdi", "omapdss"),
> +};
>
>  static void __init beagle_display_init(void)
>  {
> @@ -291,7 +293,6 @@ static struct regulator_init_data beagle_vdac = {
>  /* VPLL2 for digital video outputs */
>  static struct regulator_init_data beagle_vpll2 = {
>       .constraints = {
> -             .name                   = "VDVI",
>               .min_uV                 = 1800000,
>               .max_uV                 = 1800000,
>               .valid_modes_mask       = REGULATOR_MODE_NORMAL
> @@ -299,8 +300,8 @@ static struct regulator_init_data beagle_vpll2 = {
>               .valid_ops_mask         = REGULATOR_CHANGE_MODE
>                                       | REGULATOR_CHANGE_STATUS,
>       },
> -     .num_consumer_supplies  = 1,
> -     .consumer_supplies      = &beagle_vdvi_supply,
> +     .num_consumer_supplies  = ARRAY_SIZE(beagle_vdds_supplies),
> +     .consumer_supplies      = beagle_vdds_supplies,
>  };
>
>  static struct twl4030_usb_data beagle_usb_data = {
> --
> 1.7.0.4
>
>
>


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html