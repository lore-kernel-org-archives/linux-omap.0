From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [4/7 v2] usb: otg: OMAP4430: Add phy_suspend function pointer to
Date: Tue, 15 Feb 2011 15:12:35 +0530
Message-ID: <1297762958-26199-4-git-send-email-hemahk@ti.com>
References: <1297762958-26199-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1297762958-26199-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Kalliguddi, Hema" <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Kalliguddi, Hema <hemahk-l0cyMroinI0@public.gmane.org>

Introduce the .phy_suspend function pointer to twl4030_usb_data structure.
assign the function to it for both sdp board and panda boards.
This will be used by the twl6030-usb transceiver driver.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>

---
arch/arm/mach-omap2/board-4430sdp.c    |    1 +
 arch/arm/mach-omap2/board-omap4panda.c |    1 +
 arch/arm/plat-omap/include/plat/usb.h  |    1 +
 include/linux/i2c/twl.h                |    2 ++
 4 files changed, 5 insertions(+)

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
 
Index: linux-2.6/include/linux/i2c/twl.h
===================================================================
--- linux-2.6.orig/include/linux/i2c/twl.h
+++ linux-2.6/include/linux/i2c/twl.h
@@ -600,6 +600,8 @@ struct twl4030_usb_data {
 	int		(*phy_power)(struct device *dev, int iD, int on);
 	/* enable/disable  phy clocks */
 	int		(*phy_set_clock)(struct device *dev, int on);
+	/* suspend/resume of phy */
+	int		(*phy_suspend)(struct device *dev, int suspend);
 };
 
 struct twl4030_ins {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
