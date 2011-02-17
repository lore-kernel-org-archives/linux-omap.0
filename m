From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 7/7] OMAP2+: musb: hwmod adaptation for musb registration
Date: Thu, 17 Feb 2011 14:41:06 +0200
Message-ID: <1297946466-9565-8-git-send-email-balbi@ti.com>
References: <1297946466-9565-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:46303 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756183Ab1BQMlk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 07:41:40 -0500
Received: by bwz10 with SMTP id 10so2672204bwz.20
        for <linux-omap@vger.kernel.org>; Thu, 17 Feb 2011 04:41:37 -0800 (PST)
In-Reply-To: <1297946466-9565-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Hema HK <hemahk@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

Using omap_device_build API instead of platform_device_register for
OMAP2430,OMAP3xxx, OMAP4430 and AM35x musb device registration.
The device specific resources defined in centralized
database will be used.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/usb-musb.c |   84 +++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 5a82b43..b089ea4 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -30,6 +30,7 @@
 #include <mach/irqs.h>
 #include <mach/am35xx.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
 #include "control.h"
 #include "mux.h"
 
@@ -127,22 +128,6 @@ static void am35x_musb_set_mode(u8 musb_mode)
 	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
 }
 
-static struct resource musb_resources[] = {
-	[0] = { /* start and end set dynamically */
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {	/* general IRQ */
-		.start	= INT_243X_HS_USB_MC,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "mc",
-	},
-	[2] = {	/* DMA IRQ */
-		.start	= INT_243X_HS_USB_DMA,
-		.flags	= IORESOURCE_IRQ,
-		.name	= "dma",
-	},
-};
-
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
 	.dyn_fifo	= 1,
@@ -170,16 +155,12 @@ static struct musb_hdrc_platform_data musb_plat = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device musb_device = {
-	.name		= "musb-omap2430",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &musb_plat,
+static struct omap_device_pm_latency omap_musb_latency[] = {
+	{
+		.deactivate_func	= omap_device_idle_hwmods,
+		.activate_func		= omap_device_enable_hwmods,
+		.flags			= OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
-	.num_resources	= ARRAY_SIZE(musb_resources),
-	.resource	= musb_resources,
 };
 
 static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
@@ -219,28 +200,24 @@ static void usb_musb_mux_init(struct omap_musb_board_data *board_data)
 		break;
 	}
 }
+
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
-	if (cpu_is_omap243x()) {
-		musb_resources[0].start = OMAP243X_HS_BASE;
-	} else if (cpu_is_omap3517() || cpu_is_omap3505()) {
-		musb_device.name = "musb-am35x";
-		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
-		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
+	struct omap_hwmod		*oh;
+	struct omap_device		*od;
+	struct platform_device		*pdev;
+	struct device			*dev;
+	int				bus_id = -1;
+	const char			*oh_name, *name;
+
+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
 		board_data->set_phy_power = am35x_musb_phy_power;
 		board_data->clear_irq = am35x_musb_clear_irq;
 		board_data->set_mode = am35x_musb_set_mode;
 		board_data->reset = am35x_musb_reset;
-	} else if (cpu_is_omap34xx()) {
-		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	} else if (cpu_is_omap44xx()) {
-		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
-		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
-		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
-
 		usb_musb_mux_init(board_data);
 	}
-	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
 
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
@@ -252,8 +229,35 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
+		oh_name = "am35x_otg_hs";
+		name = "musb-am35x";
+	} else {
+		oh_name = "usb_otg_hs";
+		name = "musb-omap2430";
+	}
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
+	}
+
+	od = omap_device_build(name, bus_id, oh, &musb_plat,
+			       sizeof(musb_plat), omap_musb_latency,
+			       ARRAY_SIZE(omap_musb_latency), false);
+	if (IS_ERR(od)) {
+		pr_err("Could not build omap_device for %s %s\n",
+						name, oh_name);
+		return;
+	}
+
+	pdev = &od->pdev;
+	dev = &pdev->dev;
+	get_device(dev);
+	dev->dma_mask = &musb_dmamask;
+	dev->coherent_dma_mask = musb_dmamask;
+	put_device(dev);
 }
 
 #else
-- 
1.7.4.rc2

