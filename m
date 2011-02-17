From: Hema HK <hemahk@ti.com>
Subject: [4/7 v4] usb: otg: OMAP4430: Introducing suspend function for power management
Date: Thu, 17 Feb 2011 12:06:07 +0530
Message-ID: <1297924570-3750-4-git-send-email-hemahk@ti.com>
References: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54826 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753524Ab1BQGg0 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 Feb 2011 01:36:26 -0500
In-Reply-To: <1297924570-3750-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

From: Kalliguddi, Hema <hemahk@ti.com>

Introduced the suspend/resume function for the OMAP4430 internal PHY.
This will be used by the twl6030-usb transceiver driver.
Moved the clock enable/disable function calls and power on/off of the PHY
code from power on/off functions to suspend/resume function.

Pass the suspend function through board data for OMAP4430sdp and OMAP4panda.
This will be used by the twl6030-usb transceiver driver.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
---
arch/arm/mach-omap2/omap_phy_internal.c |   22 +++++++++++++++-------
 arch/arm/mach-omap2/board-4430sdp.c     |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/omap_phy_internal.c |   22 +++++++++++++++-------
 arch/arm/plat-omap/include/plat/usb.h   |    1 +
 4 files changed, 18 insertions(+), 7 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_phy_internal.c
+++ linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
@@ -104,13 +104,6 @@ int omap4430_phy_set_clk(struct device *
 int omap4430_phy_power(struct device *dev, int ID, int on)
 {
 	if (on) {
-		/* enabled the clocks */
-		omap4430_phy_set_clk(dev, 1);
-		/* power on the phy */
-		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
-			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-			mdelay(200);
-		}
 		if (ID)
 			/* enable VBUS valid, IDDIG groung */
 			__raw_writel(AVALID | VBUSVALID, ctrl_base +
@@ -126,10 +119,25 @@ int omap4430_phy_power(struct device *de
 		/* Enable session END and IDIG to high impedence. */
 		__raw_writel(SESSEND | IDDIG, ctrl_base +
 					USBOTGHS_CONTROL);
+	}
+	return 0;
+}
+
+int omap4430_phy_suspend(struct device *dev, int suspend)
+{
+	if (suspend) {
 		/* Disable the clocks */
 		omap4430_phy_set_clk(dev, 0);
 		/* Power down the phy */
 		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+	} else {
+		/* Enable the internel phy clcoks */
+		omap4430_phy_set_clk(dev, 1);
+		/* power on the phy */
+		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
+			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+			mdelay(200);
+		}
 	}
 
 	return 0;
Index: linux-2.6/arch/arm/plat-omap/include/plat/usb.h
===================================================================
--- linux-2.6.orig/arch/arm/plat-omap/include/plat/usb.h
+++ linux-2.6/arch/arm/plat-omap/include/plat/usb.h
@@ -88,6 +88,7 @@ extern int omap4430_phy_power(struct dev
 extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
+extern int omap4430_phy_suspend(struct device *dev, int suspend);
 
 #endif
 
Index: linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-4430sdp.c
+++ linux-2.6/arch/arm/mach-omap2/board-4430sdp.c
@@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usb
 	.phy_exit	= omap4430_phy_exit,
 	.phy_power	= omap4430_phy_power,
 	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
Index: linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/board-omap4panda.c
+++ linux-2.6/arch/arm/mach-omap2/board-omap4panda.c
@@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usb
 	.phy_exit	= omap4430_phy_exit,
 	.phy_power	= omap4430_phy_power,
 	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
