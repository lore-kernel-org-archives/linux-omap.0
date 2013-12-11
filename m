From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH] phy: omap_usb2: fix module dependency
Date: Wed, 11 Dec 2013 11:14:45 +0530
Message-ID: <52A7FBCD.4030101@ti.com>
References: <1386707097-25650-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:59201 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750719Ab3LKFpM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Dec 2013 00:45:12 -0500
In-Reply-To: <1386707097-25650-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

Hi Felipe,

On Wednesday 11 December 2013 01:54 AM, Felipe Balbi wrote:
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

last week I sent a patch changing it to depends on USB_PHY and Greg has merged
it yesterday so it should come in -rc4. Do you think this patch will also be
needed?

Thanks
Kishon

> 
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
> 

