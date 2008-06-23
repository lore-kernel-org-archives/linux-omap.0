From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3:devices.c: Enabling 4-bit for SD card
Date: Mon, 23 Jun 2008 15:47:04 +0300
Message-ID: <20080623124703.GW7741@atomide.com>
References: <200806161302.m5GD2Xg4007641@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from [63.208.196.178] ([63.208.196.178]:58887 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1753407AbYFWMql (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 23 Jun 2008 08:46:41 -0400
Content-Disposition: inline
In-Reply-To: <200806161302.m5GD2Xg4007641@india.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Purushotam Kumar <a0876542@india.ti.com>
Cc: linux-omap@vger.kernel.org, anantgole@ti.com

* Purushotam Kumar <a0876542@india.ti.com> [080616 16:03]:
> OMAP3:devices.c:Enabling 4-bit for SD card
> 
> SD card was working in 1-bit mode.This patch will configure SD card in 
> 4-bit mode and hence performance  will increase.
> 
> Signed-off-by: Purushotam Kumar <purushotam@ti.com>
> Acked-by: Madhusudhan Chikkature Rajashekar <madhu.cr@ti.com>
> ---
>  arch/arm/plat-omap/devices.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c
> +++ linux-omap-2.6/arch/arm/plat-omap/devices.c
> @@ -292,8 +292,10 @@ static void __init omap_init_mmc(void)
>  	mmc = &mmc_conf->mmc[0];
>  
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> -		if (mmc->enabled)
> +		if (mmc->enabled) {
> +			mmc1_data.conf = *mmc;
>  			(void) platform_device_register(&mmc_omap_device1);
> +		}
>  
>  #if defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP34XX)
>  		mmc = &mmc_conf->mmc[1];

I guess this should be also done for mmc2_data.conf?

Tony
