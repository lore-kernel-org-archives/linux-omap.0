From: Hema HK <hemahk@ti.com>
Subject: [PATCH 3/7] usb: otg: OMAP4430: Introducing suspend function for power management
Date: Thu,  3 Feb 2011 15:19:43 +0530
Message-ID: <1296726587-10530-3-git-send-email-hemahk@ti.com>
References: <yes>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49818 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756046Ab1BCJuC (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 3 Feb 2011 04:50:02 -0500
In-Reply-To: <yes>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>

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
