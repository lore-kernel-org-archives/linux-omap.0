From: Hema Kalliguddi <hemahk@ti.com>
Subject: RE: [PATCH 4/5 v5] OMAP2+: musb: HWMOD adaptation for musb.
Date: Thu, 3 Feb 2011 11:26:11 +0530
Message-ID: <65744cabec1215d1cd6c69ca83918aa9@mail.gmail.com>
References: <1291991739-21705-1-git-send-email-hemahk@ti.com> <1291991739-21705-5-git-send-email-hemahk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog103.obsmtp.com ([74.125.149.71]:48286 "EHLO
	na3sys009aog103.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751794Ab1BCGB4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Feb 2011 01:01:56 -0500
In-Reply-To: <1291991739-21705-5-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hema Kalliguddi <hemahk@ti.com>, linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, Benoit Cousson <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Hi,

>-----Original Message-----
>From: Hema HK [mailto:hemahk@ti.com]
>Sent: Friday, December 10, 2010 8:06 PM
>To: linux-usb@vger.kernel.org
>Cc: linux-omap@vger.kernel.org; Hema HK; Felipe Balbi; Tony
>Lindgren; Kevin Hilman; Cousson, Benoit; Paul Walmsley
>Subject: [PATCH 4/5 v5] OMAP2+: musb: HWMOD adaptation for musb.
>
>Using omap_device_build API instead of platform_device_register for
>OMAP2430,OMAP34xx and OMAP4430 musb device registration.
>The device specific resources defined in centralized
>database will be used.
>
>Signed-off-by: Hema HK <hemahk@ti.com>
>Cc: Felipe Balbi <balbi@ti.com>
>Cc: Tony Lindgren <tony@atomide.com>
>Cc: Kevin Hilman <khilman@deeprootsystems.com>
>Cc: Cousson, Benoit <b-cousson@ti.com>
>Cc: Paul Walmsley <paul@pwsan.com>
>---
> arch/arm/mach-omap2/usb-musb.c |   76
>+++++++++++++++++++++++++++++------------
> 1 file changed, 55 insertions(+), 21 deletions(-)
>
>Index: usb/arch/arm/mach-omap2/usb-musb.c
>===================================================================
>--- usb.orig/arch/arm/mach-omap2/usb-musb.c
>+++ usb/arch/arm/mach-omap2/usb-musb.c
>@@ -31,9 +31,12 @@
> #include <mach/am35xx.h>
> #include <plat/usb.h>
> #include "control.h"
>+#include <plat/omap_device.h>
>
> #if defined(CONFIG_USB_MUSB_OMAP2PLUS) || defined
>(CONFIG_USB_MUSB_AM35X)
>
>+static const char name[] = "musb-omap2430";
>+
> static void am35x_musb_reset(void)
> {
> 	u32	regval;
>@@ -170,7 +173,7 @@ static struct musb_hdrc_platform_data mu
> static u64 musb_dmamask = DMA_BIT_MASK(32);
>
> static struct platform_device musb_device = {
>-	.name		= "musb-omap2430",
>+	.name		= "musb-am35x",
> 	.id		= -1,
> 	.dev = {
> 		.dma_mask		= &musb_dmamask,
>@@ -181,26 +184,23 @@ static struct platform_device musb_devic
> 	.resource	= musb_resources,
> };
>
>+static struct omap_device_pm_latency omap_musb_latency[] = {
>+	{
>+		.deactivate_func = omap_device_idle_hwmods,
>+		.activate_func   = omap_device_enable_hwmods,
>+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
>+	},
>+};
>+
> void __init usb_musb_init(struct omap_musb_board_data *board_data)
> {
>-	if (cpu_is_omap243x()) {
>-		musb_resources[0].start = OMAP243X_HS_BASE;
>-	} else if (cpu_is_omap3517() || cpu_is_omap3505()) {
>-		musb_device.name = "musb-am35x";
>-		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
>-		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
>-		board_data->set_phy_power = am35x_musb_phy_power;
>-		board_data->clear_irq = am35x_musb_clear_irq;
>-		board_data->set_mode = am35x_musb_set_mode;
>-		board_data->reset = am35x_musb_reset;
>-	} else if (cpu_is_omap34xx()) {
>-		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
>-	} else if (cpu_is_omap44xx()) {
>-		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
>-		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
>-		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
>-	}
>-	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
>+	struct omap_hwmod *oh;
>+	struct omap_device *od;
>+	struct platform_device *pdev;
>+	struct device	*dev;
>+	int bus_id = -1;
>+	const char *oh_name = "usb_otg_hs";
>+	struct musb_hdrc_platform_data *pdata;
>
> 	/*
> 	 * REVISIT: This line can be removed once all the
>platforms using
>@@ -212,8 +212,42 @@ void __init usb_musb_init(struct omap_mu
> 	musb_plat.mode = board_data->mode;
> 	musb_plat.extvbus = board_data->extvbus;
>
>-	if (platform_device_register(&musb_device) < 0)
>-		printk(KERN_ERR "Unable to register HS-USB
>(MUSB) device\n");
>+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
>+		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
>+		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
>+		board_data->set_phy_power = am35x_musb_phy_power;
>+		board_data->clear_irq = am35x_musb_clear_irq;
>+		board_data->set_mode = am35x_musb_set_mode;
>+		board_data->reset = am35x_musb_reset;
>+		musb_resources[0].end = musb_resources[0].start
>+ SZ_4K - 1;
>+
>+		if (platform_device_register(&musb_device) < 0)
>+			printk(KERN_ERR "Unable to register HS-USB \
>+					(MUSB) device\n");
>+	} else {
>+		oh = omap_hwmod_lookup(oh_name);
>+		if (!oh) {
>+			pr_err("Could not look up %s\n", oh_name);
>+			return;
>+	 	}
>+
>+		pdata = &musb_plat;
>+		od = omap_device_build(name, bus_id, oh, pdata,
>+				       sizeof(*pdata),
>omap_musb_latency,
>+				
>ARRAY_SIZE(omap_musb_latency), false);
>+		if (IS_ERR(od)) {
>+			pr_err("Could not build omap_device for
>%s %s\n",
>+							name, oh_name);
>+			return;
>+		}
>+
>+		pdev = &od->pdev;
>+		dev = &pdev->dev;
>+		get_device(dev);
>+		dev->dma_mask = &musb_dmamask;
>+		dev->coherent_dma_mask = musb_dmamask;
>+		put_device(dev);
>+	}
> }
>
> #else
>

Any comments?

Regards,
Hema
