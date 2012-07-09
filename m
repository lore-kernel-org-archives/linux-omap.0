From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2+: omap2plus_defconfig: EHCI driver is not
 stable, disable it
Date: Mon, 9 Jul 2012 01:40:33 -0700
Message-ID: <20120709084032.GZ1122@atomide.com>
References: <1341598828-31410-1-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12966 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861Ab2GIIkg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Jul 2012 04:40:36 -0400
Content-Disposition: inline
In-Reply-To: <1341598828-31410-1-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Felipe Balbi <balbi@ti.com>, Keshava Munegowda <keshava_mgowda@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Kevin Hilman <khilman@ti.com> [120706 11:25]:
> The EHCI driver is not stable enough to be enabled by default.  In v3.5,
> it has at least the following problems:
> 
> - warning dump during bootup
> - hang during suspend
> - prevents CORE powerdomain from entering retention during idle (even
>   when no USB devices connected.)
> 
> This demonstrates that this driver has not been thoroughly tested and
> therfore should not be enabled in the default defconfig.
> 
> In addition, the problems above cause new PM regressions which need be
> addressed before this driver should be enabled in the default
> defconfig.
> 
> Signed-off-by: Kevin Hilman <khilman@ti.com>
> ---
> Tony, this applies to your current fixes branch.   Please queue up for v3.5-rc
> so this PM regression is fixed in v3.5.  Thanks.

OK adding, although I don't like the idea of having to disable drivers
in the defconfig to fix issues :( The hang during suspend case would
be potentially hit by many people.. Should the driver/usb/host/ehci-omap.c
be patched to disable suspend or at least warn about it?

Regards,

Tony
 
>  arch/arm/configs/omap2plus_defconfig |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> index 9854ff4..11828e6 100644
> --- a/arch/arm/configs/omap2plus_defconfig
> +++ b/arch/arm/configs/omap2plus_defconfig
> @@ -176,7 +176,6 @@ CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
>  CONFIG_USB_DEVICEFS=y
>  CONFIG_USB_SUSPEND=y
>  CONFIG_USB_MON=y
> -CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_WDM=y
>  CONFIG_USB_STORAGE=y
>  CONFIG_USB_LIBUSUAL=y
> -- 
> 1.7.9.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
