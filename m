From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 01/10] arm: omap: usb: host: add names to resources
Date: Sat, 26 Feb 2011 04:36:29 +0530
Message-ID: <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41151 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932869Ab1BYXHI (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 18:07:08 -0500
In-Reply-To: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

From: Felipe Balbi <balbi@ti.com>

add names to EHCI and OHCI resources. That will help us
identify the resource correctly when moving to a setup
where OHCI and EHCI play well together.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/usb-ehci.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-ehci.c
index 25eeada..2c74fa1 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-ehci.c
@@ -350,6 +350,11 @@ void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 		setup_4430ehci_io_mux(pdata->port_mode);
 	}
 
+	ehci_resources[0].name	= "ehci";
+	ehci_resources[1].name	= "uhh";
+	ehci_resources[2].name	= "tll";
+	ehci_resources[3].name	= "irq";
+
 	if (platform_device_register(&ehci_device) < 0) {
 		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
 		return;
@@ -369,21 +374,25 @@ void __init usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata)
 
 static struct resource ohci_resources[] = {
 	{
+		.name	= "ohci",
 		.start	= OMAP34XX_OHCI_BASE,
 		.end	= OMAP34XX_OHCI_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "uhh",
 		.start	= OMAP34XX_UHH_CONFIG_BASE,
 		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "tll",
 		.start	= OMAP34XX_USBTLL_BASE,
 		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
 		.flags	= IORESOURCE_MEM,
 	},
 	{	/* general IRQ */
+		.name	= "irq",
 		.start	= INT_34XX_OHCI_IRQ,
 		.flags	= IORESOURCE_IRQ,
 	}
-- 
1.6.0.4

