From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 15/19] arm: omap: usb: usbhs core device initialization
Date: Tue,  1 Mar 2011 17:15:36 +0200
Message-ID: <1298992540-5984-16-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298992540-5984-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Anand Gadiyar <gadiyar-l0cyMroinI0@public.gmane.org>, Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>

A new usbhs platform device is defined;
this device will be the parent device of ehci and
ohci platform devices. the usbhs_init function
is defined which does the usbhs device initialization
and I/O mux of ehci and ohci.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/usb-host.c        |  195 ++++++++++++++++++++++++++++++---
 arch/arm/plat-omap/include/plat/usb.h |    2 +
 2 files changed, 183 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
index b04ce6f..ab06382 100644
--- a/arch/arm/mach-omap2/usb-host.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -6,6 +6,7 @@
  *
  * Copyright (C) 2007-2011 Texas Instruments
  * Author: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
+ * Author: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
  *
  * Generalization by:
  * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
@@ -19,7 +20,7 @@
 #include <linux/errno.h>
 #include <linux/delay.h>
 #include <linux/platform_device.h>
-#include <linux/clk.h>
+#include <linux/slab.h>
 #include <linux/dma-mapping.h>
 
 #include <asm/io.h>
@@ -30,7 +31,7 @@
 
 #include "mux.h"
 
-#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+#ifdef CONFIG_MFD_OMAP_USB_HOST
 
 static struct resource ehci_resources[] = {
 	{
@@ -361,17 +362,6 @@ void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
 	}
 }
 
-#else
-
-void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
-
-{
-}
-
-#endif /* CONFIG_USB_EHCI_HCD */
-
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-
 static struct resource ohci_resources[] = {
 	{
 		.name	= "ohci",
@@ -508,6 +498,77 @@ static void setup_ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
 	}
 }
 
+static void setup_4430ohci_io_mux(const enum usbhs_omap_port_mode *port_mode)
+{
+	switch (port_mode[0]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+		omap_mux_init_signal("usbb1_mm_rxdp",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_mm_rxdm",
+			OMAP_PIN_INPUT_PULLDOWN);
+
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+		omap_mux_init_signal("usbb1_mm_rxrcv",
+			OMAP_PIN_INPUT_PULLDOWN);
+
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+		omap_mux_init_signal("usbb1_mm_txen",
+			OMAP_PIN_INPUT_PULLDOWN);
+
+
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		omap_mux_init_signal("usbb1_mm_txdat",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb1_mm_txse0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		break;
+
+	case OMAP_USBHS_PORT_MODE_UNUSED:
+	default:
+		break;
+	}
+
+	switch (port_mode[1]) {
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM:
+		omap_mux_init_signal("usbb2_mm_rxdp",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_mm_rxdm",
+			OMAP_PIN_INPUT_PULLDOWN);
+
+	case OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM:
+	case OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM:
+		omap_mux_init_signal("usbb2_mm_rxrcv",
+			OMAP_PIN_INPUT_PULLDOWN);
+
+	case OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0:
+		omap_mux_init_signal("usbb2_mm_txen",
+			OMAP_PIN_INPUT_PULLDOWN);
+
+
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0:
+	case OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM:
+		omap_mux_init_signal("usbb2_mm_txdat",
+			OMAP_PIN_INPUT_PULLDOWN);
+		omap_mux_init_signal("usbb2_mm_txse0",
+			OMAP_PIN_INPUT_PULLDOWN);
+		break;
+
+	case OMAP_USBHS_PORT_MODE_UNUSED:
+	default:
+		break;
+	}
+}
+
 void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
 {
 	platform_device_add_data(&ohci_device, pdata, sizeof(*pdata));
@@ -522,10 +583,116 @@ void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
 	}
 }
 
+#define OMAP_USBHS_DEVICE	"usbhs-omap"
+
+static struct resource usbhs_resources[] = {
+	{
+		.name	= "uhh",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "tll",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "ehci",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "ehci-irq",
+		.flags	= IORESOURCE_IRQ,
+	},
+	{
+		.name	= "ohci",
+		.flags	= IORESOURCE_MEM,
+	},
+	{
+		.name	= "ohci-irq",
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static struct platform_device usbhs_device = {
+	.name		= OMAP_USBHS_DEVICE,
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(usbhs_resources),
+	.resource	= usbhs_resources,
+};
+
+static struct usbhs_omap_platform_data		usbhs_data;
+static struct ehci_hcd_omap_platform_data	ehci_data;
+static struct ohci_hcd_omap_platform_data	ohci_data;
+
+void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
+{
+	int	i;
+
+	for (i = 0; i < OMAP3_HS_USB_PORTS; i++) {
+		usbhs_data.port_mode[i] = pdata->port_mode[i];
+		ohci_data.port_mode[i] = pdata->port_mode[i];
+		ehci_data.port_mode[i] = pdata->port_mode[i];
+		ehci_data.reset_gpio_port[i] = pdata->reset_gpio_port[i];
+		ehci_data.regulator[i] = pdata->regulator[i];
+	}
+	ehci_data.phy_reset = pdata->phy_reset;
+	ohci_data.es2_compatibility = pdata->es2_compatibility;
+	usbhs_data.ehci_data = &ehci_data;
+	usbhs_data.ohci_data = &ohci_data;
+
+	if (cpu_is_omap34xx()) {
+		usbhs_resources[0].start = OMAP34XX_UHH_CONFIG_BASE;
+		usbhs_resources[0].end = OMAP34XX_UHH_CONFIG_BASE + SZ_1K - 1;
+		usbhs_resources[1].start = OMAP34XX_USBTLL_BASE;
+		usbhs_resources[1].end = OMAP34XX_USBTLL_BASE + SZ_4K - 1;
+		usbhs_resources[2].start	= OMAP34XX_EHCI_BASE;
+		usbhs_resources[2].end	= OMAP34XX_EHCI_BASE + SZ_1K - 1;
+		usbhs_resources[3].start = INT_34XX_EHCI_IRQ;
+		usbhs_resources[4].start	= OMAP34XX_OHCI_BASE;
+		usbhs_resources[4].end	= OMAP34XX_OHCI_BASE + SZ_1K - 1;
+		usbhs_resources[5].start = INT_34XX_OHCI_IRQ;
+		setup_ehci_io_mux(pdata->port_mode);
+		setup_ohci_io_mux(pdata->port_mode);
+	} else if (cpu_is_omap44xx()) {
+		usbhs_resources[0].start = OMAP44XX_UHH_CONFIG_BASE;
+		usbhs_resources[0].end = OMAP44XX_UHH_CONFIG_BASE + SZ_1K - 1;
+		usbhs_resources[1].start = OMAP44XX_USBTLL_BASE;
+		usbhs_resources[1].end = OMAP44XX_USBTLL_BASE + SZ_4K - 1;
+		usbhs_resources[2].start = OMAP44XX_HSUSB_EHCI_BASE;
+		usbhs_resources[2].end = OMAP44XX_HSUSB_EHCI_BASE + SZ_1K - 1;
+		usbhs_resources[3].start = OMAP44XX_IRQ_EHCI;
+		usbhs_resources[4].start = OMAP44XX_HSUSB_OHCI_BASE;
+		usbhs_resources[4].end = OMAP44XX_HSUSB_OHCI_BASE + SZ_1K - 1;
+		usbhs_resources[5].start = OMAP44XX_IRQ_OHCI;
+		setup_4430ehci_io_mux(pdata->port_mode);
+		setup_4430ohci_io_mux(pdata->port_mode);
+	}
+
+	if (platform_device_add_data(&usbhs_device,
+				&usbhs_data, sizeof(usbhs_data)) < 0) {
+		printk(KERN_ERR "USBHS platform_device_add_data failed\n");
+		goto init_end;
+	}
+
+	if (platform_device_register(&usbhs_device) < 0)
+		printk(KERN_ERR "USBHS platform_device_register failed\n");
+
+init_end:
+	return;
+}
+
 #else
 
+void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
+{
+}
+
 void __init usb_ohci_init(const struct usbhs_omap_board_data *pdata)
 {
 }
 
-#endif /* CONFIG_USB_OHCI_HCD */
+void __init usb_ehci_init(const struct usbhs_omap_board_data *pdata)
+{
+}
+#endif
+
+
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 5dd2776..4c8bdb8 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -102,6 +102,8 @@ extern void usb_ehci_init(const struct usbhs_omap_board_data *pdata);
 
 extern void usb_ohci_init(const struct usbhs_omap_board_data *pdata);
 
+extern void usbhs_init(const struct usbhs_omap_board_data *pdata);
+
 extern int omap_usbhs_enable(struct device *dev);
 extern void omap_usbhs_disable(struct device *dev);
 
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
