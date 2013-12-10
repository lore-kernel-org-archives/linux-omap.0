From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] phy: omap_usb2: fix module dependency
Date: Tue, 10 Dec 2013 12:40:56 -0800
Message-ID: <20131210204056.GV13171@atomide.com>
References: <1386707097-25650-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50653 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab3LJUk7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Dec 2013 15:40:59 -0500
Content-Disposition: inline
In-Reply-To: <1386707097-25650-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>

* Felipe Balbi <balbi@ti.com> [131210 12:26]:
> Due to over-use of select statements, we could
> fall into a situation where CONFIG_USB_PHY would
> be enabled while CONFIG_USB_SUPPORT wouldn't.
> 
> This would generate a situation where usb_bind_phy()
> would not be defined and kernel build for some
> OMAP2PLUS platforms would fail.
> 
> Fix this by replacing a 'select' with a more proper
> 'depends on'.

Do we also need to update omap2plus_defconfig to select
OMAP_CONTROL_USB in this patch?

Regards,

Tony
 
> Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> ---
>  drivers/phy/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
> index a344f3d..d8b1a9a 100644
> --- a/drivers/phy/Kconfig
> +++ b/drivers/phy/Kconfig
> @@ -24,9 +24,9 @@ config PHY_EXYNOS_MIPI_VIDEO
>  config OMAP_USB2
>  	tristate "OMAP USB2 PHY Driver"
>  	depends on ARCH_OMAP2PLUS
> +	depends on OMAP_CONTROL_USB
>  	select GENERIC_PHY
>  	select USB_PHY
> -	select OMAP_CONTROL_USB
>  	help
>  	  Enable this to support the transceiver that is part of SOC. This
>  	  driver takes care of all the PHY functionality apart from comparator.
> -- 
> 1.8.4.GIT
> 
