From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMA2EVM: update defconfig
Date: Fri, 8 Aug 2008 10:49:46 +0300
Message-ID: <20080808074946.GL24923@atomide.com>
References: <dfeb90390808060424g51dbe39dvc0d8fce731c8d307@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:56394 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753022AbYHHHts (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Aug 2008 03:49:48 -0400
Content-Disposition: inline
In-Reply-To: <dfeb90390808060424g51dbe39dvc0d8fce731c8d307@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: linux-omap@vger.kernel.org

* Arun KS <arunks@mistralsolutions.com> [080806 14:25]:
> Update omap2evm defconfig
> 
> - Enable hsmmc support.

Pushing today.

Tony


> Signed-off-by: Arun KS <arunks@mistralsolutions.com>
> ---
>  arch/arm/configs/omap2_evm_defconfig |   22 +++++++++++++++++++---
>  1 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/omap2_evm_defconfig
> b/arch/arm/configs/omap2_evm_defconfig
> index 09383f9..9d5b30f 100644
> --- a/arch/arm/configs/omap2_evm_defconfig
> +++ b/arch/arm/configs/omap2_evm_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.26-rc7-omap1
> -# Tue Jun 24 17:29:35 2008
> +# Linux kernel version: 2.6.26-omap1
> +# Wed Aug  6 17:05:50 2008
>  #
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> @@ -803,7 +803,23 @@ CONFIG_HID=y
>  # CONFIG_HID_DEBUG is not set
>  # CONFIG_HIDRAW is not set
>  # CONFIG_USB_SUPPORT is not set
> -# CONFIG_MMC is not set
> +CONFIG_MMC=y
> +# CONFIG_MMC_DEBUG is not set
> +CONFIG_MMC_UNSAFE_RESUME=y
> +
> +#
> +# MMC/SD Card Drivers
> +#
> +CONFIG_MMC_BLOCK=y
> +CONFIG_MMC_BLOCK_BOUNCE=y
> +# CONFIG_SDIO_UART is not set
> +# CONFIG_MMC_TEST is not set
> +
> +#
> +# MMC/SD Host Controller Drivers
> +#
> +CONFIG_MMC_OMAP_HS=y
> +# CONFIG_MMC_SPI is not set
>  # CONFIG_NEW_LEDS is not set
>  CONFIG_RTC_LIB=y
>  # CONFIG_RTC_CLASS is not set
> -- 
> 1.5.3.4
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
