From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
Date: Thu, 09 Sep 2010 08:04:45 +0300 (EEST)
Message-ID: <20100909.080445.193715829.Hiroshi.DOYU@nokia.com>
References: <1283957481-16682-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mgw-sa02.nokia.com ([147.243.1.48]:25731 "EHLO
	mgw-sa02.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130Ab0IIFEu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 9 Sep 2010 01:04:50 -0400
In-Reply-To: <1283957481-16682-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: premi@ti.com
Cc: linux-omap@vger.kernel.org

Hi Sanjeev,

From: ext Sanjeev Premi <premi@ti.com>
Subject: [PATCH] omap: OMAP_IOMMU not visible in menuconfig
Date: Wed, 8 Sep 2010 16:51:21 +0200

> The menu option to select CONFIG_OMAP_IOMMU
> was not visible in the menuconfig due to missing
> description.

There's no point to make OMAP_IOMMU visible since this is a kind of
feature used by other device implicitly. OMAP_IOMMU on menu might confuse
users at kernel menuconfig. Instead this should be automatically
selected by its clients when it is selected. For exmaple, the case
that DSP or Tesla is selected. There was a discussion about this
before.

> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/plat-omap/Kconfig |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index e39a417..2a114a9 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -98,7 +98,7 @@ config OMAP_MBOX_KFIFO_SIZE
>  	  module parameter).
>  
>  config OMAP_IOMMU
> -	tristate
> +	tristate "OMAP IOMMU support"
>  
>  config OMAP_IOMMU_DEBUG
>         tristate "Export OMAP IOMMU internals in DebugFS"
> -- 
> 1.6.2.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
