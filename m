From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [RFC] [PATCH 5/7] omap: usb: ehci: Initialize resources for omap4
Date: Thu, 19 Aug 2010 05:19:35 +0530
Message-ID: <1282175377-2784-6-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-3-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-4-git-send-email-keshava_mgowda@ti.com>
 <1282175377-2784-5-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1282175377-2784-5-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Update resources (IRQ number, base addresses) for EHCI on OMAP4.
This patch will be replaced when the driver is converted to
take advantage of hwmod (hardware mode).

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-ehci.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/usb-ehci.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-ehci.c
+++ linux-2.6/arch/arm/mach-omap2/usb-ehci.c
@@ -34,22 +34,15 @@
 
 static struct resource ehci_resources[] = {
 	{
-		.start	= OMAP34XX_EHCI_BASE,
-		.end	= OMAP34XX_EHCI_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= OMAP34XX_UHH_CONFIG_BASE,
-		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
-		.start	= OMAP34XX_USBTLL_BASE,
-		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{         /* general IRQ */
-		.start   = INT_34XX_EHCI_IRQ,
 		.flags   = IORESOURCE_IRQ,
 	}
 };
@@ -328,8 +321,25 @@ void __init usb_ehci_init(const struct e
 	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
 
 	/* Setup Pin IO MUX for EHCI */
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
+		ehci_resources[0].start	= OMAP34XX_EHCI_BASE;
+		ehci_resources[0].end	= OMAP34XX_EHCI_BASE + SZ_1K - 1;
+		ehci_resources[1].start	= OMAP34XX_UHH_CONFIG_BASE;
+		ehci_resources[1].end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
+		ehci_resources[2].start	= OMAP34XX_USBTLL_BASE;
+		ehci_resources[2].end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1;
+		ehci_resources[3].start = INT_34XX_EHCI_IRQ;
 		setup_ehci_io_mux(pdata->port_mode);
+	} else if (cpu_is_omap44xx()) {
+		ehci_resources[0].start	= OMAP44XX_HSUSB_EHCI_BASE;
+		ehci_resources[0].end	= OMAP44XX_HSUSB_EHCI_BASE + SZ_1K - 1;
+		ehci_resources[1].start	= OMAP44XX_UHH_CONFIG_BASE;
+		ehci_resources[1].end	= OMAP44XX_UHH_CONFIG_BASE + SZ_2K - 1;
+		ehci_resources[2].start	= OMAP44XX_USBTLL_BASE;
+		ehci_resources[2].end	= OMAP44XX_USBTLL_BASE + SZ_4K - 1;
+		ehci_resources[3].start = OMAP44XX_IRQ_EHCI;
+		setup_4430ehci_io_mux(pdata->port_mode);
+	}
 
 	if (platform_device_register(&ehci_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
