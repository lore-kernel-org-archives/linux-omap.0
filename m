From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH]Enable 4-bit in HSMMC1 and HSMMC2 platform data
Date: Wed, 10 Sep 2008 16:56:46 -0700
Message-ID: <20080910235646.GV21163@atomide.com>
References: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62086 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbYIJX4s (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 19:56:48 -0400
Content-Disposition: inline
In-Reply-To: <62710.192.168.10.89.1218608010.squirrel@dbdmail.itg.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: linux-omap@vger.kernel.org

* Madhusudhan Chikkature <madhu.cr@ti.com> [080812 23:13]:
> From: Madhusudhan Chikkature<madhu.cr@ti.com>
> 
> ARM: OMAP3: Enable 4-bit support for HSMMC.
> 
> This patch provides the fix to enable 4-bit support for HSMMC.

Pushing today.

Tony

> Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
> Signed-off-by: purushotam<purushotam@ti.com>
> ---
>  arch/arm/plat-omap/devices.c |    8 ++++++--
>  1 files changed, 6 insertions(+), 2 deletions(-)
> 
> Index: linux-omap-2.6/arch/arm/plat-omap/devices.c
> ===================================================================
> --- linux-omap-2.6.orig/arch/arm/plat-omap/devices.c	2008-08-07
> 15:56:52.000000000 +0530
> +++ linux-omap-2.6/arch/arm/plat-omap/devices.c	2008-08-11 10:57:37.000000000
> +0530
> @@ -289,13 +289,17 @@ static void __init omap_init_mmc(void)
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
> -		if (mmc->enabled)
> +		if (mmc->enabled) {
> +			mmc2_data.conf = *mmc;
>  			(void) platform_device_register(&mmc_omap_device2);
> +		}
>  #endif
> 
>  		return;
> 
> 
