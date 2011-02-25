From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 08/10] arm: omap: usb: cleanup ehci and ohci devices
Date: Sat, 26 Feb 2011 04:36:36 +0530
Message-ID: <1298675198-14214-9-git-send-email-keshava_mgowda@ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-3-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-4-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-5-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-6-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-7-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-8-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41157 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933061Ab1BYXHK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 18:07:10 -0500
In-Reply-To: <1298675198-14214-8-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

The prototype and defination of functions usb_ehci_init and
usb_ohci_init are removed. The ehci and ohci devices are
removed since usbhs device contains both ehci and ohci details.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
---
 arch/arm/mach-omap2/usb-host.c        |  166 ++++-----------------------------
 arch/arm/plat-omap/include/plat/usb.h |    4 -
 2 files changed, 20 insertions(+), 150 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index da4c0d3..403fd89 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -33,33 +33,38 @@
 
 #ifdef CONFIG_MFD_OMAP_USB_HOST
 
-static struct resource ehci_resources[] = {
+#define OMAP_USBHS_DEVICE	"usbhs-omap"
+
+static struct resource usbhs_resources[] = {
 	{
+		.name	= "uhh",
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "tll",
 		.flags	= IORESOURCE_MEM,
 	},
 	{
+		.name	= "ehci",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "ehci-irq",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "ohci",
 		.flags	= IORESOURCE_MEM,
 	},
-	{         /* general IRQ */
-		.flags   = IORESOURCE_IRQ,
+	{
+		.name	= "ohci-irq",
+		.flags	= IORESOURCE_IRQ,
 	}
 };
 
-static u64 ehci_dmamask = ~(u32)0;
-static struct platform_device ehci_device = {
-	.name           = "ehci-omap",
-	.id             = 0,
-	.dev = {
-		.dma_mask               = &ehci_dmamask,
-		.coherent_dma_mask      = 0xffffffff,
-		.platform_data          = NULL,
-	},
-	.num_resources  = ARRAY_SIZE(ehci_resources),
-	.resource       = ehci_resources,
-};
+static struct usbhs_omap_platform_data		usbhs_data;
+static struct ehci_hcd_omap_platform_data	ehci_data;
+static struct ohci_hcd_omap_platform_data	ohci_data;
 
 /* MUX settings for EHCI pins */
 /*
@@ -326,81 +331,6 @@ static void setup_4430ehci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	}
 }
 
-void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
-{
-	platform_device_add_data(&ehci_device, pdata, sizeof(*pdata));
-
-	/* Setup Pin IO MUX for EHCI */
-	if (cpu_is_omap34xx()) {
-		ehci_resources[0].start	= OMAP34XX_EHCI_BASE;
-		ehci_resources[0].end	= OMAP34XX_EHCI_BASE + SZ_1K - 1;
-		ehci_resources[1].start	= OMAP34XX_UHH_CONFIG_BASE;
-		ehci_resources[1].end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
-		ehci_resources[2].start	= OMAP34XX_USBTLL_BASE;
-		ehci_resources[2].end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1;
-		ehci_resources[3].start = INT_34XX_EHCI_IRQ;
-		setup_ehci_io_mux(pdata->port_mode);
-	} else if (cpu_is_omap44xx()) {
-		ehci_resources[0].start	= OMAP44XX_HSUSB_EHCI_BASE;
-		ehci_resources[0].end	= OMAP44XX_HSUSB_EHCI_BASE + SZ_1K - 1;
-		ehci_resources[1].start	= OMAP44XX_UHH_CONFIG_BASE;
-		ehci_resources[1].end	= OMAP44XX_UHH_CONFIG_BASE + SZ_2K - 1;
-		ehci_resources[2].start	= OMAP44XX_USBTLL_BASE;
-		ehci_resources[2].end	= OMAP44XX_USBTLL_BASE + SZ_4K - 1;
-		ehci_resources[3].start = OMAP44XX_IRQ_EHCI;
-		setup_4430ehci_io_mux(pdata->port_mode);
-	}
-
-	ehci_resources[0].name	= "ehci";
-	ehci_resources[1].name	= "uhh";
-	ehci_resources[2].name	= "tll";
-	ehci_resources[3].name	= "irq";
-
-	if (platform_device_register(&ehci_device) < 0) {
-		printk(KERN_ERR "Unable to register HS-USB (EHCI) device\n");
-		return;
-	}
-}
-
-static struct resource ohci_resources[] = {
-	{
-		.name	= "ohci",
-		.start	= OMAP34XX_OHCI_BASE,
-		.end	= OMAP34XX_OHCI_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "uhh",
-		.start	= OMAP34XX_UHH_CONFIG_BASE,
-		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "tll",
-		.start	= OMAP34XX_USBTLL_BASE,
-		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	{	/* general IRQ */
-		.name	= "irq",
-		.start	= INT_34XX_OHCI_IRQ,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 ohci_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device ohci_device = {
-	.name		= "ohci-omap3",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &ohci_dmamask,
-		.coherent_dma_mask	= 0xffffffff,
-	},
-	.num_resources	= ARRAY_SIZE(ohci_resources),
-	.resource	= ohci_resources,
-};
-
 static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 {
 	switch (port_mode[0]) {
@@ -569,54 +499,6 @@ static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	}
 }
 
-void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
-{
-	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
-
-	/* Setup Pin IO MUX for OHCI */
-	if (cpu_is_omap34xx())
-		setup_ohci_io_mux(pdata->port_mode);
-
-	if (platform_device_register(&ohci_device) < 0) {
-		pr_err("Unable to register FS-USB (OHCI) device\n");
-		return;
-	}
-}
-
-
-#define OMAP_USBHS_DEVICE	"usbhs-omap"
-
-static struct resource usbhs_resources[] = {
-	{
-		.name	= "uhh",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "tll",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "ehci",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "ehci-irq",
-		.flags	= IORESOURCE_IRQ,
-	},
-	{
-		.name	= "ohci",
-		.flags	= IORESOURCE_MEM,
-	},
-	{
-		.name	= "ohci-irq",
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static struct usbhs_omap_platform_data		usbhs_data;
-static struct ehci_hcd_omap_platform_data	ehci_data;
-static struct ohci_hcd_omap_platform_data	ohci_data;
-
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
 	struct platform_device	*pdev;
@@ -684,14 +566,6 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
 {
 }
-
-void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
-{
-}
-
-void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
-{
-}
 #endif
 
 
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index aab707a..398032a 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -98,10 +98,6 @@ enum musb_interface    {MUSB_INTERFACE_ULPI, MUSB_INTERFACE_UTMI};
 
 extern void usb_musb_init(struct omap_musb_board_data *board_data);
 
-extern void usb_ehci_init(const struct usbhs_omap_board_data *pdata);
-
-extern void usb_ohci_init(const struct usbhs_omap_board_data *pdata);
-
 extern void usbhs_init(const struct usbhs_omap_board_data *pdata);
 
 extern int omap_usbhs_enable(struct device *dev);
-- 
1.6.0.4

