From: Hema HK <hemahk@ti.com>
Subject: [3/7 v3] usb: otg: OMAP4430: Introducing suspend function for power management
Date: Wed, 16 Feb 2011 17:20:45 +0530
Message-ID: <1297857049-27367-3-git-send-email-hemahk@ti.com>
References: <1297857049-27367-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49184 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758930Ab1BPLvM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 16 Feb 2011 06:51:12 -0500
In-Reply-To: <1297857049-27367-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "Kalliguddi, Hema" <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

From: Kalliguddi, Hema <hemahk@ti.com>

Introduced the suspend/resume function for the OMAP4430 internal PHY.
This will be used by the twl6030-usb transceiver driver.
Moved the clock enable/disable function calls and power on/off of the PHY
code from power on/off functions to suspend/resume function.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>

---
arch/arm/mach-omap2/omap_phy_internal.c |   22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

Index: linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
===================================================================
--- linux-2.6.orig/arch/arm/mach-omap2/omap_phy_internal.c
+++ linux-2.6/arch/arm/mach-omap2/omap_phy_internal.c
@@ -103,13 +103,6 @@ int omap4430_phy_set_clk(struct device *
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
@@ -125,10 +118,25 @@ int omap4430_phy_power(struct device *de
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
 
