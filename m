From: Hema HK <hemahk@ti.com>
Subject: [PATCH 4/4]usb : musb:USB driver using omap_device_build for device registration.
Date: Mon, 28 Jun 2010 17:47:07 +0530
Message-ID: <1277727427-6144-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59471 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006Ab0F1MRQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Jun 2010 08:17:16 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Hema HK <hemahk@ti.com>, Felipe Balbi <felipe.balbi@nokia.com>, tony@atomide.com

From: Hema HK  <hemahk@ti.com>

Changed the musb driver to use omap_build_device api instead of 
platform_device_registration.The device specific resources defined in 
centralized database will be used. So removed the resource definitions from
the driver file. 

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <felipe.balbi@nokia.com>,tony@atomide.com
---
Based off  pm-wip/hwmods-omap4.

 arch/arm/mach-omap2/clock44xx_data.c       |    2 
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    2 
 arch/arm/mach-omap2/usb-musb.c             |   94 ++++++++++++++---------------
 3 files changed, 49 insertions(+), 49 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/clock44xx_data.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/clock44xx_data.c
+++ linux-omap-pm/arch/arm/mach-omap2/clock44xx_data.c
@@ -2296,7 +2296,7 @@ static struct clk usb_host_fs_fck = {
 };
 
 static struct clk usb_otg_ick = {
-	.name		= "usb_otg_ick",
+	.name		= "usb_otg_hs_ick",
 	.ops		= &clkops_omap2_dflt,
 	.enable_reg	= OMAP4430_CM_L3INIT_USB_OTG_CLKCTRL,
 	.enable_bit	= OMAP4430_MODULEMODE_HWCTRL,
Index: linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ linux-omap-pm/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4884,7 +4884,7 @@ static __initdata struct omap_hwmod *oma
 	/* usb_host_hs class */
 /*	&omap44xx_usb_host_hs_hwmod, */
 	/* usb_otg_hs class */
-/*	&omap44xx_usb_otg_hs_hwmod, */
+	&omap44xx_usb_otg_hs_hwmod,
 	/* usb_tll_hs class */
 /*	&omap44xx_usb_tll_hs_hwmod, */
 	/* wd_timer class */
Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
@@ -30,24 +30,12 @@
 #include <mach/irqs.h>
 #include <plat/mux.h>
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
@@ -76,43 +64,55 @@ static struct musb_hdrc_platform_data mu
 
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
+		.activate_func	 = omap_device_enable_hwmods,
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
-
-	/*
-	 * REVISIT: This line can be removed once all the platforms using
-	 * musb_core.c have been converted to use use clkdev.
-	 */
-	musb_plat.clock = "ick";
-	musb_plat.board_data = board_data;
-	musb_plat.power = board_data->power >> 1;
-	musb_plat.mode = board_data->mode;
-	musb_plat.extvbus = board_data->extvbus;
-
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+	char oh_name[MAX_OMAP_MUSB_HWMOD_NAME_LEN];
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct platform_device *pdev;
+	struct device	*dev;
+	int l, bus_id = -1;
+	struct musb_hdrc_platform_data *pdata;
+
+	l = snprintf(oh_name, MAX_OMAP_MUSB_HWMOD_NAME_LEN,
+						"usb_otg_hs");
+	WARN(l >= MAX_OMAP_MUSB_HWMOD_NAME_LEN,
+	"String buffer overflow in MUSB device setup\n");
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+	} else {
+		musb_plat.clock = "ick";
+		musb_plat.board_data = board_data;
+		musb_plat.power = board_data->power >> 1;
+		musb_plat.mode = board_data->mode;
+		pdata = &musb_plat;
+
+		od = omap_device_build(name, bus_id, oh, pdata,
+				       sizeof(struct musb_hdrc_platform_data),
+							omap_musb_latency,
+				       ARRAY_SIZE(omap_musb_latency), false);
+		if (IS_ERR(od)) {
+			pr_err("Could not build omap_device for %s %s\n",
+						name, oh_name);
+		} else {
+
+			pdev = &od->pdev;
+			dev = &pdev->dev;
+			get_device(dev);
+			dev->dma_mask = &musb_dmamask;
+			dev->coherent_dma_mask = musb_dmamask;
+			put_device(dev);
+		}
+ 	}
 }
 
 #else
