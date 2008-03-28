From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP: MMU_FWK: Changed Kconfig entry from tristate to
	bool.
Date: Fri, 28 Mar 2008 12:41:28 +0200
Message-ID: <20080328104128.GY24896@atomide.com>
References: <1206542887-12321-1-git-send-email-edubezval@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:61359 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbYC1Kla (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 Mar 2008 06:41:30 -0400
Content-Disposition: inline
In-Reply-To: <1206542887-12321-1-git-send-email-edubezval@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: linux-omap@vger.kernel.org, Eduardo Valentin <eduardo.valentin@indt.org.br>

* Eduardo Valentin <edubezval@gmail.com> [080326 16:49]:
> From: Eduardo Valentin <eduardo.valentin@indt.org.br>
> 
> As this code uses unexported symbols, it must be always
> built-in. For this reason, a better type of its Kconfig entry
> is bool.
> 
> Fixed also defconfig which sets this entry as module.
> 
> Compile test only.

Pushing today.

Tony

> Signed-off-by: Eduardo Valentin <eduardo.valentin@indt.org.br>
> ---
>  arch/arm/configs/ams_delta_defconfig |    2 +-
>  arch/arm/plat-omap/Kconfig           |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/configs/ams_delta_defconfig b/arch/arm/configs/ams_delta_defconfig
> index a6b77ab..2c4aa11 100644
> --- a/arch/arm/configs/ams_delta_defconfig
> +++ b/arch/arm/configs/ams_delta_defconfig
> @@ -164,7 +164,7 @@ CONFIG_OMAP_MUX=y
>  # CONFIG_OMAP_MUX_DEBUG is not set
>  CONFIG_OMAP_MUX_WARNINGS=y
>  CONFIG_OMAP_MCBSP=y
> -CONFIG_OMAP_MMU_FWK=m
> +CONFIG_OMAP_MMU_FWK=y
>  CONFIG_OMAP_MBOX_FWK=m
>  CONFIG_OMAP_MPU_TIMER=y
>  # CONFIG_OMAP_32K_TIMER is not set
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index 50291ed..536f8aa 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -122,7 +122,7 @@ config OMAP_MCBSP
>  	  Buffered Serial Port.
>  
>  config OMAP_MMU_FWK
> -	tristate "MMU framework support"
> +	bool "MMU framework support"
>  	depends on ARCH_OMAP
>  	default n
>  	help
> -- 
> 1.5.4.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
