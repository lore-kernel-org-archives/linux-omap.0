From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: [patch-v2.6.39 08/12] usb: otg: OMAP4430: Introducing suspend function for power management
Date: Thu, 17 Feb 2011 14:38:45 +0200
Message-ID: <1297946329-9353-9-git-send-email-balbi@ti.com>
References: <1297946329-9353-1-git-send-email-balbi@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297946329-9353-1-git-send-email-balbi-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
Cc: Linux USB Mailing List <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>

Introduced the suspend/resume function for the OMAP4430 internal PHY.
This will be used by the twl6030-usb transceiver driver.
Moved the clock enable/disable function calls and power on/off of the PHY
code from power on/off functions to suspend/resume function.

Pass the suspend function through board data for OMAP4430sdp and OMAP4panda.
This will be used by the twl6030-usb transceiver driver.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/board-4430sdp.c     |    1 +
 arch/arm/mach-omap2/board-omap4panda.c  |    1 +
 arch/arm/mach-omap2/omap_phy_internal.c |   22 +++++++++++++++-------
 arch/arm/plat-omap/include/plat/usb.h   |    1 +
 4 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index 07d1b20..9cf8e33 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -272,6 +272,7 @@ static struct twl4030_usb_data omap4_usbphy_data = {
 	.phy_exit	= omap4430_phy_exit,
 	.phy_power	= omap4430_phy_power,
 	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index e944025..77748f8 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -153,6 +153,7 @@ static struct twl4030_usb_data omap4_usbphy_data = {
 	.phy_exit	= omap4430_phy_exit,
 	.phy_power	= omap4430_phy_power,
 	.phy_set_clock	= omap4430_phy_set_clk,
+	.phy_suspend	= omap4430_phy_suspend,
 };
 
 static struct omap2_hsmmc_info mmc[] = {
diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 745252c..3ce6758 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -103,13 +103,6 @@ int omap4430_phy_set_clk(struct device *dev, int on)
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
@@ -125,10 +118,25 @@ int omap4430_phy_power(struct device *dev, int ID, int on)
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
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 450a332..f888e0e 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -88,6 +88,7 @@ extern int omap4430_phy_power(struct device *dev, int ID, int on);
 extern int omap4430_phy_set_clk(struct device *dev, int on);
 extern int omap4430_phy_init(struct device *dev);
 extern int omap4430_phy_exit(struct device *dev);
+extern int omap4430_phy_suspend(struct device *dev, int suspend);
 
 #endif
 
-- 
1.7.4.rc2

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
