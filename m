From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RFC] [PATCH 4/5] usb: ohci: omap: Initialize resources for OMAP4
Date: Fri, 20 Aug 2010 00:48:09 +0530
Message-ID: <1282245490-24339-5-git-send-email-keshava_mgowda@ti.com>
References: <1282245490-24339-1-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-2-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-3-git-send-email-keshava_mgowda@ti.com>
 <1282245490-24339-4-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55277 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752002Ab0HTHRf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Aug 2010 03:17:35 -0400
In-Reply-To: <1282245490-24339-4-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Update resources (IRQ number, base addresses) for OHCI on OMAP4.
This patch should be replaced when the driver is converted to
take advantage of hwmod (hardware mode).

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/usb-ehci.c |   26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/usb-ehci.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-ehci.c
+++ linux-2.6/arch/arm/mach-omap2/usb-ehci.c
@@ -360,22 +360,15 @@ void __init usb_ehci_init(const struct e
 
 static struct resource ohci_resources[] = {
 	{
-		.start	= OMAP34XX_OHCI_BASE,
-		.end	= OMAP34XX_OHCI_BASE + SZ_1K - 1,
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
 	{	/* general IRQ */
-		.start	= INT_34XX_OHCI_IRQ,
 		.flags	= IORESOURCE_IRQ,
 	}
 };
@@ -580,8 +573,25 @@ void __init usb_ohci_init(const struct o
 	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
 
 	/* Setup Pin IO MUX for OHCI */
-	if (cpu_is_omap34xx())
+	if (cpu_is_omap34xx()) {
+		ohci_resources[0].start	= OMAP34XX_OHCI_BASE;
+		ohci_resources[0].end	= OMAP34XX_OHCI_BASE + SZ_1K - 1;
+		ohci_resources[1].start	= OMAP34XX_UHH_CONFIG_BASE;
+		ohci_resources[1].end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
+		ohci_resources[2].start	= OMAP34XX_USBTLL_BASE;
+		ohci_resources[2].end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1;
+		ohci_resources[3].start = INT_34XX_OHCI_IRQ;
 		setup_ohci_io_mux(pdata->port_mode);
+	} else if (cpu_is_omap44xx()) {
+		ohci_resources[0].start	= OMAP44XX_HSUSB_OHCI_BASE;
+		ohci_resources[0].end	= OMAP44XX_HSUSB_OHCI_BASE + SZ_1K - 1;
+		ohci_resources[1].start	= OMAP44XX_UHH_CONFIG_BASE;
+		ohci_resources[1].end	= OMAP44XX_UHH_CONFIG_BASE + SZ_1K - 1;
+		ohci_resources[2].start	= OMAP44XX_USBTLL_BASE;
+		ohci_resources[2].end	= OMAP44XX_USBTLL_BASE + SZ_4K - 1;
+		ohci_resources[3].start = OMAP44XX_IRQ_OHCI;
+		setup_4430ohci_io_mux(pdata->port_mode);
+	}
 
 	if (platform_device_register(&ohci_device) < 0) {
 		pr_err("Unable to register FS-USB (OHCI) device\n");
