From: Hema HK <hemahk@ti.com>
Subject: [PATCH]: usb: musb: AM35x: moving internal phy functions out of usb_musb.c file
Date: Wed, 16 Feb 2011 17:34:40 +0530
Message-ID: <1297857880-27638-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50561 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758974Ab1BPMEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Feb 2011 07:04:47 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

Moved all the board specific internal PHY functions out of usb_musb.c file
as this file is shared between the OMAP2+ and AM35xx platforms.
There exists a file which has the functions specific to internal PHY
used for OMAP4 platform. Moved all phy specific functions to this file
and passing these functions through board data in the board file.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tony Lindgren <tony@atomide.com>

Index: linux-2.6/arch/arm/mach-omap2/board-am3517evm.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-am3517evm.c
+++ linux-2.6/arch/arm/mach-omap2/board-am3517evm.c
@@ -409,6 +409,10 @@ static struct omap_musb_board_data musb_
 	.interface_type         = MUSB_INTERFACE_ULPI,
 	.mode                   = MUSB_OTG,
 	.power                  = 500,
+	.set_phy_power		= am35x_musb_phy_power,
+	.clear_irq		= am35x_musb_clear_irq,
+	.set_mode		= am35x_musb_set_mode,
+	.reset			= am35x_musb_reset,
 };
 
 static __init void am3517_evm_musb_init(void)
Index: linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_phy_internal.c
+++ linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
@@ -29,6 +29,7 @@
 #include <linux/usb.h>
 
 #include <plat/usb.h>
+#include "control.h"
 
 /* OMAP control module register for UTMI PHY */
 #define CONTROL_DEV_CONF		0x300
@@ -147,3 +148,95 @@ int omap4430_phy_exit(struct device *dev
 
 	return 0;
 }
+
+void am35x_musb_reset(void)
+{
+	u32	regval;
+
+	/* Reset the musb interface */
+	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
+
+	regval |= AM35XX_USBOTGSS_SW_RST;
+	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
+
+	regval &= ~AM35XX_USBOTGSS_SW_RST;
+	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
+}
+
+void am35x_musb_phy_power(u8 on)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(100);
+	u32 devconf2;
+
+	if (on) {
+		/*
+		 * Start the on-chip PHY and its PLL.
+		 */
+		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+		devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN);
+		devconf2 |= CONF2_PHY_PLLON;
+
+		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+
+		pr_info(KERN_INFO "Waiting for PHY clock good...\n");
+		while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
+				& CONF2_PHYCLKGD)) {
+			cpu_relax();
+
+			if (time_after(jiffies, timeout)) {
+				pr_err(KERN_ERR "musb PHY clock good timed out\n");
+				break;
+			}
+		}
+	} else {
+		/*
+		 * Power down the on-chip PHY.
+		 */
+		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+		devconf2 &= ~CONF2_PHY_PLLON;
+		devconf2 |=  CONF2_PHYPWRDN | CONF2_OTGPWRDN;
+		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+	}
+}
+
+void am35x_musb_clear_irq(void)
+{
+	u32 regval;
+
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval |= AM35XX_USBOTGSS_INT_CLR;
+	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
+	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
+}
+
+void am35x_musb_set_mode(u8 musb_mode)
+{
+	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
+
+	devconf2 &= ~CONF2_OTGMODE;
+	switch (musb_mode) {
+#ifdef	CONFIG_USB_MUSB_HDRC_HCD
+	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
+		devconf2 |= CONF2_FORCE_HOST;
+		break;
+#endif
+#ifdef	CONFIG_USB_GADGET_MUSB_HDRC
+	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
+		devconf2 |= CONF2_FORCE_DEVICE;
+		break;
+#endif
+#ifdef	CONFIG_USB_MUSB_OTG
+	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
+		devconf2 |= CONF2_NO_OVERRIDE;
+		break;
+#endif
+	default:
+		pr_info(KERN_INFO "Unsupported mode %u\n", musb_mode);
+	}
+
+	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
+}
Index: linux-2.6/arch/arm/mach-omap2/usb-musb.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/usb-musb.c
+++ linux-2.6/arch/arm/mach-omap2/usb-musb.c
@@ -30,102 +30,9 @@
 #include <mach/irqs.h>
 #include <mach/am35xx.h>
 #include <plat/usb.h>
-#include "control.h"
 
 #if defined(CONFIG_USB_MUSB_OMAP2PLUS) || defined (CONFIG_USB_MUSB_AM35X)
 
-static void am35x_musb_reset(void)
-{
-	u32	regval;
-
-	/* Reset the musb interface */
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-
-	regval |= AM35XX_USBOTGSS_SW_RST;
-	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-
-	regval &= ~AM35XX_USBOTGSS_SW_RST;
-	omap_ctrl_writel(regval, AM35XX_CONTROL_IP_SW_RESET);
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_IP_SW_RESET);
-}
-
-static void am35x_musb_phy_power(u8 on)
-{
-	unsigned long timeout = jiffies + msecs_to_jiffies(100);
-	u32 devconf2;
-
-	if (on) {
-		/*
-		 * Start the on-chip PHY and its PLL.
-		 */
-		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-		devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN);
-		devconf2 |= CONF2_PHY_PLLON;
-
-		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-
-		pr_info(KERN_INFO "Waiting for PHY clock good...\n");
-		while (!(omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2)
-				& CONF2_PHYCLKGD)) {
-			cpu_relax();
-
-			if (time_after(jiffies, timeout)) {
-				pr_err(KERN_ERR "musb PHY clock good timed out\n");
-				break;
-			}
-		}
-	} else {
-		/*
-		 * Power down the on-chip PHY.
-		 */
-		devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-		devconf2 &= ~CONF2_PHY_PLLON;
-		devconf2 |=  CONF2_PHYPWRDN | CONF2_OTGPWRDN;
-		omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-	}
-}
-
-static void am35x_musb_clear_irq(void)
-{
-	u32 regval;
-
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval |= AM35XX_USBOTGSS_INT_CLR;
-	omap_ctrl_writel(regval, AM35XX_CONTROL_LVL_INTR_CLEAR);
-	regval = omap_ctrl_readl(AM35XX_CONTROL_LVL_INTR_CLEAR);
-}
-
-static void am35x_musb_set_mode(u8 musb_mode)
-{
-	u32 devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
-
-	devconf2 &= ~CONF2_OTGMODE;
-	switch (musb_mode) {
-#ifdef	CONFIG_USB_MUSB_HDRC_HCD
-	case MUSB_HOST:		/* Force VBUS valid, ID = 0 */
-		devconf2 |= CONF2_FORCE_HOST;
-		break;
-#endif
-#ifdef	CONFIG_USB_GADGET_MUSB_HDRC
-	case MUSB_PERIPHERAL:	/* Force VBUS valid, ID = 1 */
-		devconf2 |= CONF2_FORCE_DEVICE;
-		break;
-#endif
-#ifdef	CONFIG_USB_MUSB_OTG
-	case MUSB_OTG:		/* Don't override the VBUS/ID comparators */
-		devconf2 |= CONF2_NO_OVERRIDE;
-		break;
-#endif
-	default:
-		pr_info(KERN_INFO "Unsupported mode %u\n", musb_mode);
-	}
-
-	omap_ctrl_writel(devconf2, AM35XX_CONTROL_DEVCONF2);
-}
-
 static struct resource musb_resources[] = {
 	[0] = { /* start and end set dynamically */
 		.flags	= IORESOURCE_MEM,
@@ -189,10 +96,6 @@ void __init usb_musb_init(struct omap_mu
 		musb_device.name = "musb-am35x";
 		musb_resources[0].start = AM35XX_IPSS_USBOTGSS_BASE;
 		musb_resources[1].start = INT_35XX_USBOTG_IRQ;
-		board_data->set_phy_power = am35x_musb_phy_power;
-		board_data->clear_irq = am35x_musb_clear_irq;
-		board_data->set_mode = am35x_musb_set_mode;
-		board_data->reset = am35x_musb_reset;
 	} else if (cpu_is_omap34xx()) {
 		musb_resources[0].start = OMAP34XX_HSUSB_OTG_BASE;
 	} else if (cpu_is_omap44xx()) {
Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
@@ -91,6 +91,10 @@ extern int omap4430_phy_exit(struct devi
 
 #endif
 
+extern void am35x_musb_reset(void);
+extern void am35x_musb_phy_power(u8 on);
+extern void am35x_musb_clear_irq(void);
+extern void am35x_musb_set_mode(u8 musb_mode);
 
 /*
  * FIXME correct answer depends on hmc_mode,
Index: linux-2.6/arch/arm/mach-omap2/Makefile
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/Makefile
+++ linux-2.6/arch/arm/mach-omap2/Makefile
@@ -218,7 +218,8 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board
 					   hsmmc.o \
 					   omap_phy_internal.o
 
-obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
+obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
+					   omap_phy_internal.o \
 
 obj-$(CONFIG_MACH_CRANEBOARD)		+= board-am3517crane.o
 
