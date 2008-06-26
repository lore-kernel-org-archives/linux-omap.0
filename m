From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: SmartReflex driver: enable in
	omap_3430sdp_defconfig
Date: Thu, 26 Jun 2008 16:26:35 +0300
Message-ID: <20080626132634.GG12992@atomide.com>
References: <1214289809-24098-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52455 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951AbYFZN0i (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Jun 2008 09:26:38 -0400
Content-Disposition: inline
In-Reply-To: <1214289809-24098-1-git-send-email-ext-kalle.jokiniemi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
Cc: linux-omap@vger.kernel.org

* Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [080624 09:43]:
> This patch enables the SmartReflex driver in omap_3430sdp_defconfig. Also removes
> obsolete options and adds new previously undefined options as "not set".

Pushing today.

Tony

> Signed-off-by: Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com>
> ---
>  arch/arm/configs/omap_3430sdp_defconfig |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/configs/omap_3430sdp_defconfig b/arch/arm/configs/omap_3430sdp_defconfig
> index 947c25f..df03af3 100644
> --- a/arch/arm/configs/omap_3430sdp_defconfig
> +++ b/arch/arm/configs/omap_3430sdp_defconfig
> @@ -1,7 +1,7 @@
>  #
>  # Automatically generated make config: don't edit
> -# Linux kernel version: 2.6.26-rc4-omap1
> -# Fri May 30 13:43:29 2008
> +# Linux kernel version: 2.6.26-rc7-omap1
> +# Tue Jun 24 08:42:24 2008
>  #
>  CONFIG_ARM=y
>  CONFIG_SYS_SUPPORTS_APM_EMULATION=y
> @@ -170,9 +170,10 @@ CONFIG_ARCH_OMAP3=y
>  #
>  # OMAP Feature Selections
>  #
> -CONFIG_OMAP_DEBUG_SRAM_PATCH=y
>  # CONFIG_OMAP_DEBUG_POWERDOMAIN is not set
>  # CONFIG_OMAP_DEBUG_CLOCKDOMAIN is not set
> +CONFIG_OMAP_SMARTREFLEX=y
> +# CONFIG_OMAP_SMARTREFLEX_TESTING is not set
>  CONFIG_OMAP_RESET_CLOCKS=y
>  CONFIG_OMAP_BOOT_TAG=y
>  CONFIG_OMAP_BOOT_REASON=y
> @@ -1017,6 +1018,7 @@ CONFIG_USB_MON=y
>  # CONFIG_USB_TRANCEVIBRATOR is not set
>  # CONFIG_USB_IOWARRIOR is not set
>  CONFIG_USB_TEST=y
> +# CONFIG_USB_ISIGHTFW is not set
>  CONFIG_USB_GADGET=y
>  CONFIG_USB_GADGET_DEBUG=y
>  CONFIG_USB_GADGET_DEBUG_FILES=y
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
