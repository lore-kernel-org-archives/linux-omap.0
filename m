From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v3 1/3] omap3: add platform init code for OHCI driver
Date: Mon, 26 Apr 2010 10:04:47 +0530
Message-ID: <1272256489-3389-2-git-send-email-gadiyar@ti.com>
References: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50140 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab0DZEfK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 26 Apr 2010 00:35:10 -0400
In-Reply-To: <1272256489-3389-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, Greg KH <gregkh@suse.de>
Cc: Anand Gadiyar <gadiyar@ti.com>, David Brownell <dbrownell@users.sourceforge.net>

Add platform init code for the OMAP3 OHCI driver.

Also, configure padconf settings for OMAP3 depending
on which port mode is used.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---
v3: Remove extra semicolon on one line.

v2:
- Fix review comments from Felipe and Sergio
- Cover all combinations for mux-mode

 arch/arm/mach-omap2/usb-ehci.c        |  155 ++++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h |   23 +++++
 2 files changed, 178 insertions(+)

Index: linux-2.6/arch/arm/mach-omap2/usb-ehci.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-ehci.c
+++ linux-2.6/arch/arm/mach-omap2/usb-ehci.c
@@ -236,3 +236,158 @@ void __init usb_ehci_init(const struct e
 
 #endif /* CONFIG_USB_EHCI_HCD */
 
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+
+static struct resource ohci_resources[] = {
+	{
+		.start	= OMAP34XX_OHCI_BASE,
+		.end	= OMAP34XX_OHCI_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP34XX_UHH_CONFIG_BASE,
+		.end	= OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.start	= OMAP34XX_USBTLL_BASE,
+		.end	= OMAP34XX_USBTLL_BASE + SZ_4K - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	{	/* general IRQ */
+		.start	= INT_34XX_OHCI_IRQ,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 ohci_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device ohci_device = {
+	.name		= "ohci-omap3",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &ohci_dmamask,
+		.coherent_dma_mask	= 0xffffffff,
+	},
+	.num_resources	= ARRAY_SIZE(ohci_resources),
+	.resource	= ohci_resources,
+};
+
+static void setup_ohci_io_mux(const enum ohci_omap3_port_mode *port_mode)
+{
+	switch (port_mode[0]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+		omap_mux_init_signal("mm1_rxdp",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("mm1_rxdm",
+			OMAP_PIN_INPUT_PULLDOWN);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+		omap_mux_init_signal("mm1_rxrcv",
+			OMAP_PIN_INPUT_PULLDOWN);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+		omap_mux_init_signal("mm1_txen_n", OMAP_PIN_OUTPUT);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		omap_mux_init_signal("mm1_txse0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("mm1_txdat",
+			OMAP_PIN_INPUT_PULLDOWN);
+		break;
+	case OMAP_OHCI_PORT_MODE_UNUSED:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+	switch (port_mode[1]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+		omap_mux_init_signal("mm2_rxdp",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("mm2_rxdm",
+			OMAP_PIN_INPUT_PULLDOWN);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+		omap_mux_init_signal("mm2_rxrcv",
+			OMAP_PIN_INPUT_PULLDOWN);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+		omap_mux_init_signal("mm2_txen_n", OMAP_PIN_OUTPUT);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		omap_mux_init_signal("mm2_txse0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("mm2_txdat",
+			OMAP_PIN_INPUT_PULLDOWN);
+		break;
+	case OMAP_OHCI_PORT_MODE_UNUSED:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+	switch (port_mode[2]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+		omap_mux_init_signal("mm3_rxdp",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("mm3_rxdm",
+			OMAP_PIN_INPUT_PULLDOWN);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+		omap_mux_init_signal("mm3_rxrcv",
+			OMAP_PIN_INPUT_PULLDOWN);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+		omap_mux_init_signal("mm3_txen_n", OMAP_PIN_OUTPUT);
+		/* FALLTHROUGH */
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		omap_mux_init_signal("mm3_txse0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("mm3_txdat",
+			OMAP_PIN_INPUT_PULLDOWN);
+		break;
+	case OMAP_OHCI_PORT_MODE_UNUSED:
+		/* FALLTHROUGH */
+	default:
+		break;
+	}
+}
+
+void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata)
+{
+	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
+
+	/* Setup Pin IO MUX for OHCI */
+	if (cpu_is_omap34xx())
+		setup_ohci_io_mux(pdata->port_mode);
+
+	if (platform_device_register(&ohci_device) < 0) {
+		pr_err("Unable to register FS-USB (OHCI) device\n");
+		return;
+	}
+}
+
+#else
+
+void __init usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata)
+{
+}
+
+#endif /* CONFIG_USB_OHCI_HCD */
Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
@@ -13,6 +13,20 @@ enum ehci_hcd_omap_mode {
 	EHCI_HCD_OMAP_MODE_TLL,
 };
 
+enum ohci_omap3_port_mode {
+	OMAP_OHCI_PORT_MODE_UNUSED,
+	OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0,
+	OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM,
+	OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0,
+	OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM,
+	OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0,
+	OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM,
+	OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0,
+	OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM,
+	OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0,
+	OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM,
+};
+
 struct ehci_hcd_omap_platform_data {
 	enum ehci_hcd_omap_mode		port_mode[OMAP3_HS_USB_PORTS];
 	unsigned			phy_reset:1;
@@ -21,6 +35,13 @@ struct ehci_hcd_omap_platform_data {
 	int	reset_gpio_port[OMAP3_HS_USB_PORTS];
 };
 
+struct ohci_hcd_omap_platform_data {
+	enum ohci_omap3_port_mode	port_mode[OMAP3_HS_USB_PORTS];
+
+	/* Set this to true for ES2.x silicon */
+	unsigned			es2_compatibility:1;
+};
+
 /*-------------------------------------------------------------------------*/
 
 #define OMAP1_OTG_BASE			0xfffb0400
@@ -55,6 +76,8 @@ extern void usb_musb_init(struct omap_mu
 
 extern void usb_ehci_init(const struct ehci_hcd_omap_platform_data *pdata);
 
+extern void usb_ohci_init(const struct ohci_hcd_omap_platform_data *pdata);
+
 #endif
 
 void omap_usb_init(struct omap_usb_config *pdata);
