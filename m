From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: enable TWL4030_USB in omap2plus_defconfig
Date: Fri, 6 Mar 2015 09:49:34 -0800
Message-ID: <20150306174933.GX13520@atomide.com>
References: <1424984849-13083-1-git-send-email-aaro.koskinen@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta1.delivery4.ore.mailhop.org ([54.191.151.194]:44142 "EHLO
	pmta1.delivery4.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932079AbbCFRy5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 6 Mar 2015 12:54:57 -0500
Received: from smtp6.ore.mailhop.org (172.31.36.112) by pmta1.delivery1.ore.mailhop.org id hv7ktq20r84f for <linux-omap@vger.kernel.org>; Fri, 6 Mar 2015 17:54:36 +0000 (envelope-from <tony@atomide.com>)
Content-Disposition: inline
In-Reply-To: <1424984849-13083-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [150226 13:11]:
> Enable TWL4030_USB which is used at least on Nokia N900/N950/N9 (OMAP3).
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>  arch/arm/configs/omap2plus_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index b738652..8c93aa9 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -375,6 +375,7 @@ CONFIG_PWM_TWL=m
>  CONFIG_PWM_TWL_LED=m
>  CONFIG_OMAP_USB2=m
>  CONFIG_TI_PIPE3=m
> +CONFIG_TWL4030_USB=m
>  CONFIG_EXT2_FS=y
>  CONFIG_EXT3_FS=y
>  # CONFIG_EXT3_FS_XATTR is not set

Thanks I noticed the same on beagle-xm too, applying into
omap-for-v4.0/fixes.

Tony
