From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/5 v6] OMAP2+: musb: HWMOD adaptation for musb. registration
Date: Thu, 10 Feb 2011 19:38:00 +0530
Message-ID: <1297346881-13438-5-git-send-email-hemahk@ti.com>
References: <1297346881-13438-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297346881-13438-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>, "Cousson, Benoit" <b-cousson-l0cyMroinI0@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Using omap_device_build API instead of platform_device_register for
OMAP2430,OMAP34xx and OMAP4430 musb device registration.
The device specific resources defined in centralized
database will be used.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Cc: Cousson, Benoit <b-cousson-l0cyMroinI0@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/usb-musb.c |   76 +++++++++++++++++++++++++++++------------
 1 file changed, 55 insertions(+), 21 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-2.6/arch/arm/mach-omap2/usb-musb.c
@@ -31,9 +31,12 @@
 #include <mach/am35xx.h>
 #include <plat/usb.h>
 #include "control.h"
+#include <plat/omap_device.h>
 
 #if defined(CONFIG_USB_MUSB_OMAP2PLUS) || defined (CONFIG_USB_MUSB_AM35X)
 
+static const char name[] = "musb-omap2430";
+
 static void am35x_musb_reset(void)
 {
 	u32	regval;
@@ -170,7 +173,7 @@ static struct musb_hdrc_platform_data mu
 static u64 musb_dmamask = DMA_BIT_MASK(32);
 
 static struct platform_device musb_device = {
-	.name		= "musb-omap2430",
+	.name		= "musb-am35x",
 	.id		= -1,
 	.dev = {
 		.dma_mask		= &musb_dmamask,
@@ -181,26 +184,23 @@ static struct platform_device musb_devic
 	.resource	= musb_resources,
 };
 
+static struct omap_device_pm_latency omap_musb_latency[] = {
+	{
+		.deactivate_func = omap_device_idle_hwmods,
+		.activate_func   = omap_device_enable_hwmods,
+		.flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
 void __init usb_musb_init(struct omap_musb_board_data *board_data)
 {
-	if (cpu_is_omap243x()) {
-		musb_resources[0].start = OMAP243X_HS_BASE;
-	} else if (cpu_is_omap3517() || cpu_is_omap3505()) {
-		musb_device.name = "musb-am35x";
-		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
-		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
-		board_data->set_phy_power = am35x_musb_phy_power;
-		board_data->clear_irq = am35x_musb_clear_irq;
-		board_data->set_mode = am35x_musb_set_mode;
-		board_data->reset = am35x_musb_reset;
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
 
 	/*
 	 * REVISIT: This line can be removed once all the platforms using
@@ -212,8 +212,42 @@ void __init usb_musb_init(struct omap_mu
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (platform_device_register(&musb_device) < 0)
-		printk(KERN_ERR "Unable to register HS-USB (MUSB) device\n");
+	if (cpu_is_omap3517() || cpu_is_omap3505()) {
+		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
+		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
+		board_data->set_phy_power = am35x_musb_phy_power;
+		board_data->clear_irq = am35x_musb_clear_irq;
+		board_data->set_mode = am35x_musb_set_mode;
+		board_data->reset = am35x_musb_reset;
+		musb_resources[0].end = musb_resources[0].start + SZ_4K - 1;
+
+		if (platform_device_register(&musb_device) < 0)
+			printk(KERN_ERR "Unable to register HS-USB \
+					(MUSB) device\n");
+	} else {
+		oh = omap_hwmod_lookup(oh_name);
+		if (!oh) {
+			pr_err("Could not look up %s\n", oh_name);
+			return;
+		}
+
+		pdata = &musb_plat;
+		od = omap_device_build(name, bus_id, oh, pdata,
+				       sizeof(*pdata), omap_musb_latency,
+				       ARRAY_SIZE(omap_musb_latency), false);
+		if (IS_ERR(od)) {
+			pr_err("Could not build omap_device for %s %s\n",
+							name, oh_name);
+			return;
+		}
+
+		pdev = &od->pdev;
+		dev = &pdev->dev;
+		get_device(dev);
+		dev->dma_mask = &musb_dmamask;
+		dev->coherent_dma_mask = musb_dmamask;
+		put_device(dev);
+	}
 }
 
 #else
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
