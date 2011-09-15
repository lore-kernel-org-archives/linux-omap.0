From: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Subject: [RFC PATCH 2/6] usb: musb: omap4430_phy_power to enable/disable clocks and power up/down phy
Date: Thu, 15 Sep 2011 19:49:59 +0530
Message-ID: <1316096403-6013-3-git-send-email-kishon@ti.com>
References: <1316096403-6013-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1316096403-6013-1-git-send-email-kishon-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, gregkh-l3A5Bk7waGM@public.gmane.org
Cc: p-basak2-l0cyMroinI0@public.gmane.org, kishon-l0cyMroinI0@public.gmane.org, balajitk-l0cyMroinI0@public.gmane.org, x0153364-l0cyMroinI0@public.gmane.org, m-sonasath-l0cyMroinI0@public.gmane.org, vishp-l0cyMroinI0@public.gmane.org, hemahk-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

omap4430_phy_power is modified to be self contained in that it enables clock
and power up the phy in addition to modifying the USBOTGHS_CONTROL register
during power on. Similarly while powering down, it disables clock and
power down the phy.

Signed-off-by: Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
Signed-off-by: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Signed-off-by: Partha Basak <p-basak2-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 58775e3..a828833 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -110,6 +110,13 @@ int omap4430_phy_set_clk(struct device *dev, int on)
 int omap4430_phy_power(struct device *dev, int ID, int on)
 {
 	if (on) {
+		/* enabled the clocks */
+		omap4430_phy_set_clk(dev, 1);
+		/* power on the phy */
+		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
+			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+			msleep_interruptible(200);
+		}
 		if (ID)
 			/* enable VBUS valid, IDDIG groung */
 			__raw_writel(AVALID | VBUSVALID, ctrl_base +
@@ -125,6 +132,10 @@ int omap4430_phy_power(struct device *dev, int ID, int on)
 		/* Enable session END and IDIG to high impedance. */
 		__raw_writel(SESSEND | IDDIG, ctrl_base +
 					USBOTGHS_CONTROL);
+		/* Power down the phy */
+		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+		/* Disable the clocks */
+		omap4430_phy_set_clk(dev, 0);
 	}
 	return 0;
 }
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
