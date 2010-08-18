From: Hema HK <hemahk@ti.com>
Subject: [PATCH 5/8 v2] usb: musb: Using omap_device_build for musb device registration
Date: Wed, 18 Aug 2010 19:39:42 +0530
Message-ID: <1282140582-29252-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49210 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753409Ab0HROJy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 18 Aug 2010 10:09:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@deeprootsystems.com>, "Cousson, Benoit" <b-cousson@ti.com>, Paul Walmsley <paul@pwsan.com>

Using omap_device_build api instead of platform_device_register for musb
device registration.The device specific resources defined in centralized
database will be used. So removed the resource definitions from the musb
platform file.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Cousson, Benoit <b-cousson@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/usb-musb.c |   74 ++++++++++++++++++++-------------------
 1 files changed, 38 insertions(+), 36 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 1b7aa70..c228cc0 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -29,24 +29,12 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
 
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
+static const char name[] = "musb_hdrc";
+#define MAX_OMAP_MUSB_HWMOD_NAME_LEN	16
 
 static struct musb_hdrc_config musb_config = {
 	.multipoint	= 1,
@@ -75,31 +63,30 @@ static struct musb_hdrc_platform_data musb_plat = {
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device musb_device = {
-	.name		= "musb_hdrc",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &musb_plat,
+static struct omap_device_pm_latency omap_musb_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
 	},
-	.num_resources	= ARRAY_SIZE(musb_resources),
-	.resource	= musb_resources,
 };
 
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
-	if (cpu_is_omap243x()) {
-		musb_resources[0].start = OMAP243X_HS_BASE;
-	} else if (cpu_is_omap34xx()) {
-		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
-	} else if (cpu_is_omap44xx()) {
-		musb_resources[0].start = OMAP44XX_HSUSB_OTG_BASE;
-		musb_resources[1].start = OMAP44XX_IRQ_HS_USB_MC_N;
-		musb_resources[2].start = OMAP44XX_IRQ_HS_USB_DMA_N;
-	}
-	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct platform_device *pdev;
+	struct device	*dev;
+	int bus_id = -1;
+	const char *oh_name = "usb_otg_hs";
+	struct musb_hdrc_platform_data *pdata;
 
+	oh = omap_hwmod_lookup(oh_name);
+
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
+	}
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
 	 * musb_core.c have been converted to use use clkdev.
@@ -109,9 +96,24 @@ void __init usb_musb_init(struct omap_musb_board_data *board_data)
 	musb_plat.power = board_data->power >> 1;
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
+	pdata = &musb_plat;
+
+	od = omap_device_build(name, bus_id, oh, pdata,
+			       sizeof(struct musb_hdrc_platform_data),
+						omap_musb_latency,
+			       ARRAY_SIZE(omap_musb_latency), false);
+	if (IS_ERR(od)) {
+		pr_err("Could not build omap_device for %s %s\n",
+						name, oh_name);
+		return;
+	}
+	pdev = &od->pdev;
+	dev = &pdev->dev;
+	get_device(dev);
+	dev->dma_mask = &musb_dmamask;
+	dev->coherent_dma_mask = musb_dmamask;
+	put_device(dev);
 
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
 }
 
 #else
-- 
1.7.0.4

