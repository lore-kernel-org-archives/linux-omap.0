From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with vdds_dsi
Date: Thu, 10 Jun 2010 21:11:26 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E85304E@dbde02.ent.ti.com>
References: <hvaibhav@ti.com>
 <1268997679-27869-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41289 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751685Ab0FJPll convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 10 Jun 2010 11:41:41 -0400
In-Reply-To: <1268997679-27869-1-git-send-email-hvaibhav@ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Hiremath, Vaibhav" <hvaibhav@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tomi.valkeinen@nokia.com" <tomi.valkeinen@nokia.com>, "tony@atomide.com" <tony@atomide.com>


> -----Original Message-----
> From: Hiremath, Vaibhav
> Sent: Friday, March 19, 2010 4:51 PM
> To: linux-omap@vger.kernel.org
> Cc: tomi.valkeinen@nokia.com; tony@atomide.com; Hiremath, Vaibhav
> Subject: [PATCH-V2] OMAP3EVM: Replace vdvi regulator supply with vdds_dsi
> 
> From: Vaibhav Hiremath <hvaibhav@ti.com>
> 
> With recent changes happened in OMAP2/3 DSS library for regulator interface,
> it
> is required to define DSI regulator supply, without this DSS (in turn Fbdev)
> fails to get regulator.
> 
[Hiremath, Vaibhav] Tony,

I have also completely missed about this patch, and today I realized that this patch is not merged.

Tony,

I have verified that this patch still gets applied cleanly ontop of linux-omap/master.

Can it be merged, without this Video Display won't work on EVM?

Thanks,
Vaibhav

> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Acked-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>
> ---
>  arch/arm/mach-omap2/board-omap3evm.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-
> omap2/board-omap3evm.c
> index 017bb2f..74bbdcb 100644
> --- a/arch/arm/mach-omap2/board-omap3evm.c
> +++ b/arch/arm/mach-omap2/board-omap3evm.c
> @@ -514,14 +514,11 @@ static struct regulator_init_data omap3_evm_vdac = {
>  };
> 
>  /* VPLL2 for digital video outputs */
> -static struct regulator_consumer_supply omap3_evm_vpll2_supply = {
> -	.supply		= "vdvi",
> -	.dev		= &omap3_evm_lcd_device.dev,
> -};
> +static struct regulator_consumer_supply omap3_evm_vpll2_supply =
> +	REGULATOR_SUPPLY("vdds_dsi", "omapdss");
> 
>  static struct regulator_init_data omap3_evm_vpll2 = {
>  	.constraints = {
> -		.name			= "VDVI",
>  		.min_uV			= 1800000,
>  		.max_uV			= 1800000,
>  		.apply_uV		= true,
> --
> 1.6.2.4

