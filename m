From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [PATCH] Enable CONFIG_GPIO_TWL4030=y
Date: Fri, 10 Oct 2008 14:20:29 +0300
Message-ID: <20081010112029.GF29131@gandalf.research.nokia.com>
References: <1223636826-10107-1-git-send-email-premi@ti.com>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:26923 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750904AbYJJLU7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 10 Oct 2008 07:20:59 -0400
Content-Disposition: inline
In-Reply-To: <1223636826-10107-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

On Fri, Oct 10, 2008 at 04:37:06PM +0530, ext Sanjeev Premi wrote:
> Without this option, kernel builds would fail, with
> errors similar to:
> 
> hsmmc.c:50: undefined reference to `twl4030_get_gpio_datain'
> hsmmc.c:82: undefined reference to `twl4030_free_gpio'
> hsmmc.c:63: undefined reference to `twl4030_request_gpio'
> hsmmc.c:67: undefined reference to `twl4030_set_gpio_debounce'

Can you 2430sdp defconfig.

> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> ---
>  arch/arm/configs/omap2_evm_defconfig    |    1 +
>  arch/arm/configs/omap3_beagle_defconfig |    1 +
>  arch/arm/configs/omap3_evm_defconfig    |    1 +
>  arch/arm/configs/omap_3430sdp_defconfig |    1 +
>  arch/arm/configs/omap_ldp_defconfig     |    1 +
>  5 files changed, 5 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2_evm_defconfig b/arch/arm/configs/omap2_evm_defconfig
> index 61f0965..b52426a 100644
> --- a/arch/arm/configs/omap2_evm_defconfig
> +++ b/arch/arm/configs/omap2_evm_defconfig
> @@ -795,6 +795,7 @@ CONFIG_GPIOLIB=y
>  # CONFIG_GPIO_MAX732X is not set
>  # CONFIG_GPIO_PCA953X is not set
>  # CONFIG_GPIO_PCF857X is not set
> +CONFIG_GPIO_TWL4030=y
>  
>  #
>  # PCI GPIO expanders:
> diff --git a/arch/arm/configs/omap3_beagle_defconfig b/arch/arm/configs/omap3_beagle_defconfig
> index 7805995..0d2f770 100644
> --- a/arch/arm/configs/omap3_beagle_defconfig
> +++ b/arch/arm/configs/omap3_beagle_defconfig
> @@ -709,6 +709,7 @@ CONFIG_HAVE_GPIO_LIB=y
>  #
>  # CONFIG_GPIO_PCA953X is not set
>  # CONFIG_GPIO_PCF857X is not set
> +CONFIG_GPIO_TWL4030=y
>  
>  #
>  # SPI GPIO expanders:
> diff --git a/arch/arm/configs/omap3_evm_defconfig b/arch/arm/configs/omap3_evm_defconfig
> index ebeaef3..507a689 100644
> --- a/arch/arm/configs/omap3_evm_defconfig
> +++ b/arch/arm/configs/omap3_evm_defconfig
> @@ -779,6 +779,7 @@ CONFIG_HAVE_GPIO_LIB=y
>  #
>  # CONFIG_GPIO_PCA953X is not set
>  # CONFIG_GPIO_PCF857X is not set
> +CONFIG_GPIO_TWL4030=y
>  
>  #
>  # SPI GPIO expanders:
> diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
> index 11c0cf7..bd6006c 100644
> --- a/arch/arm/configs/omap_3430sdp_defconfig
> +++ b/arch/arm/configs/omap_3430sdp_defconfig
> @@ -790,6 +790,7 @@ CONFIG_HAVE_GPIO_LIB=y
>  #
>  # CONFIG_GPIO_PCA953X is not set
>  # CONFIG_GPIO_PCF857X is not set
> +CONFIG_GPIO_TWL4030=y
>  
>  #
>  # SPI GPIO expanders:
> diff --git a/arch/arm/configs/omap_ldp_defconfig b/arch/arm/configs/omap_ldp_defconfig
> index 9a90975..fd34367 100644
> --- a/arch/arm/configs/omap_ldp_defconfig
> +++ b/arch/arm/configs/omap_ldp_defconfig
> @@ -549,6 +549,7 @@ CONFIG_HAVE_GPIO_LIB=y
>  #
>  # CONFIG_GPIO_PCA953X is not set
>  # CONFIG_GPIO_PCF857X is not set
> +CONFIG_GPIO_TWL4030=y
>  
>  #
>  # SPI GPIO expanders:
> -- 
> 1.5.6
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
