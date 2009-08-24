From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] MUSB: Remove usb_musb_pm_init() call
Date: Mon, 24 Aug 2009 15:23:19 +0300
Message-ID: <87d46lqu2w.fsf@deeprootsystems.com>
References: <1251115597-23096-1-git-send-email-gadiyar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.158]:3926 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZHXMXV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Aug 2009 08:23:21 -0400
Received: by fg-out-1718.google.com with SMTP id e21so486614fga.17
        for <linux-omap@vger.kernel.org>; Mon, 24 Aug 2009 05:23:22 -0700 (PDT)
In-Reply-To: <1251115597-23096-1-git-send-email-gadiyar@ti.com> (Anand Gadiyar's message of "Mon\, 24 Aug 2009 17\:36\:37 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand Gadiyar <gadiyar@ti.com>
Cc: linux-omap@vger.kernel.org

Anand Gadiyar <gadiyar@ti.com> writes:

> MUSB: Remove usb_musb_pm_init() call
>
> In usb_musb_pm_init, we attempt to access an MUSB register
> when the i-clock may not be on, or the module is otherwise
> not accessible.
>
> We need to either:
> - enable the clock before this access, or
> - remove this code and move it to the bootloader, or
> - enable the clock in the bootloader
>
> If we enable the clock in the bootloader, we might as well
> add the workaround in the bootloader itself. This code will
> anyway be changed once hwmod is in place, so remove it for now
>
> This allows us to boot the kernel on certain OMAP3 boards with
> a bootloader that doesn't enable this clock. Without this, we
> will need to upgrade the bootloaders on these boards.
>
> Signed-off-by: Anand Gadiyar <gadiyar@ti.com>

NAK.

The PM branch already has a fix from Jon Hunter[1] for this which enables
the clock, and in the thread where we discussed this I mentioned I would
carry it in the PM branch until the hwmod for OTG is ready.

Kevin

[1] http://marc.info/?l=linux-omap&m=125020202601759&w=2


>  arch/arm/mach-omap2/usb-musb.c |   12 ------------
>  1 files changed, 12 deletions(-)
>
> Index: linux-2.6/arch/arm/mach-omap2/usb-musb.c
> ===================================================================
> --- linux-2.6.orig/arch/arm/mach-omap2/usb-musb.c
> +++ linux-2.6/arch/arm/mach-omap2/usb-musb.c
> @@ -31,15 +31,6 @@
>  #include <mach/mux.h>
>  #include <mach/usb.h>
>  
> -#define OTG_SYSCONFIG	(OMAP34XX_HSUSB_OTG_BASE + 0x404)
> -
> -static void __init usb_musb_pm_init(void)
> -{
> -	/* Ensure force-idle mode for OTG controller */
> -	if (cpu_is_omap34xx())
> -		omap_writel(0, OTG_SYSCONFIG);
> -}
> -
>  #ifdef CONFIG_USB_MUSB_SOC
>  
>  static struct resource musb_resources[] = {
> @@ -194,13 +185,10 @@ void __init usb_musb_init(void)
>  		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
>  		return;
>  	}
> -
> -	usb_musb_pm_init();
>  }
>  
>  #else
>  void __init usb_musb_init(void)
>  {
> -	usb_musb_pm_init();
>  }
>  #endif /* CONFIG_USB_MUSB_SOC */
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
