From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/9 v3] usb: musb: Using omap_device_build for musb device registration
Date: Wed, 22 Sep 2010 20:29:10 -0400
Message-ID: <1285201750-26438-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Using omap_device_build api instead of platform_device_register for musb
device registration.The device specific resources defined in centralized
database will be used. So removed the resource definitions from the musb
platform file.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>

---
 arch/arm/mach-omap2/usb-musb.c |   75 ++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 37 deletions(-)

Index: linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-omap-pm/arch/arm/mach-omap2/usb-musb.c
@@ -29,24 +29,11 @@
 #include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <plat/usb.h>
+#include <plat/omap_device.h>
 
 #ifdef CONFIG_USB_MUSB_SOC
-
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
@@ -75,31 +62,30 @@ static struct musb_hdrc_platform_data mu
 
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
+	struct omap_hwmod *oh;
+	struct omap_device *od;
+	struct platform_device *pdev;
+	struct device	*dev;
+	int bus_id = -1;
+	const char *oh_name = "usb_otg_hs";
+	struct musb_hdrc_platform_data *pdata;
+
+	oh = omap_hwmod_lookup(oh_name);
+
+	if (!oh) {
+		pr_err("Could not look up %s\n", oh_name);
+		return;
 	}
-	musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
-
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
 	 * musb_core.c have been converted to use use clkdev.
@@ -110,8 +96,23 @@ void __init usb_musb_init(struct omap_mu
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
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
 }
 
 #else
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
