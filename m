From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [RFC][PATCH 3/3]ARM:OMAP4 iommu:provide build support for
 omap4 iommu
Date: Fri, 24 Jul 2009 21:17:15 +0300 (EEST)
Message-ID: <20090724.211715.71123038.Hiroshi.DOYU@nokia.com>
References: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42672 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943AbZGXSRd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 24 Jul 2009 14:17:33 -0400
In-Reply-To: <8F7AF80515AF0D4D93307E594F3CB40E3A8CAD46@dlee03.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: h-kanigeri2@ti.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, grgupta@ti.com, rmk@arm.linux.org.uk, vpasam@ti.com

From: "ext Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: [RFC][PATCH 3/3]ARM:OMAP4 iommu:provide build support for omap4 iommu
Date: Fri, 24 Jul 2009 19:22:56 +0200

> This patch provides build support to build OMAP4
> IOMMU module. This also adds the changes to Kconfig
> file to make iommu option visible in menuconfig.
> 
> Signed-off-by: Hari Kanigeri <h-kanigeri2@ti.com>
> ---
>  arch/arm/mach-omap2/Makefile |    2 +-
>  arch/arm/plat-omap/Kconfig   |    8 ++++++--
>  2 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 735bae5..59e0865 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -41,7 +41,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= clock34xx.o
>  
>  iommu-y					+= iommu2.o
>  iommu-$(CONFIG_ARCH_OMAP3)		+= omap3-iommu.o
> -
> +iommu-$(CONFIG_ARCH_OMAP4)              += omap4-iommu.o
>  obj-$(CONFIG_OMAP_IOMMU)		+= $(iommu-y)
>  
>  # Specific board support
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index efe85d0..00d7a1e 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -118,8 +118,12 @@ config OMAP_MBOX_FWK
>  	  DSP, IVA1.0 and IVA2 in OMAP1/2/3.
>  
>  config OMAP_IOMMU
> -	tristate
> -
> +	tristate "iommu"
> +        depends on ARCH_OMAP

Is the above dependecy necessary?

> +	default y
> +	help
> +	  Select this option if you want to use IOMMU support for the
> +	  Camera in OMAP3, and for Ducati processor in OMAP4.

So here, it goes visible because iommu will be an independent character device, right?


>  choice
>          prompt "System timer"
>  	default OMAP_MPU_TIMER
> -- 
> 1.5.4.3
> 
> 
> Thank you,
> Best regards,
> Hari
> 
