From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH V2 4/8]usb : musb:Using omap_device_build for musb device registration
Date: Fri,  6 Aug 2010 21:27:50 +0530
Message-ID: <1281110270-4185-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK  <hemahk-l0cyMroinI0@public.gmane.org>

Using omap_device_build api instead of platform_device_register for musb 
device registration.The device specific resources defined in centralized 
database will be used. So removed the resource definitions from the musb
platform file. 

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
---

 arch/arm/mach-omap2/usb-musb.c |  100 +++++++++++++++++++++--------------------
 1 file changed, 53 insertions(+), 47 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c	2010-08-06 09:01:25.526112352 -0400
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c	2010-08-06 09:01:43.786112839 -0400
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
@@ -75,43 +63,61 @@
 
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
-static struct platform_device musb_device = {
-	.name		= "musb_hdrc",
-	.id		= -1,
-	.dev = {
-		.dma_mask		= &musb_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &musb_plat,
-	},
-	.num_resources	= ARRAY_SIZE(musb_resources),
-	.resource	= musb_resources,
+static struct omap_device_pm_latency omap_musb_latency[] = {
+	  {
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	  },
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
+			"String buffer overflow in MUSB device setup\n");
+
+	oh = omap_hwmod_lookup(oh_name);
+
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+	} else {
+		/*
+		 * REVISIT: This line can be removed once all the platforms
+		 * using musb_core.c have been converted to use use clkdev.
+		 */
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
 	}
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
