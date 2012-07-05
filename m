From: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 2/2] OMAP4: otg: phy: remove uggly mdelay(200)
Date: Thu, 5 Jul 2012 11:42:19 +0300
Message-ID: <1341477739-6801-1-git-send-email-ruslan.bilovol@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

The original issue with powering on the PHY (and using
200 ms delay after this) is not related to internal
processes in the PHY but is in the incorrect charger
detection feature usage.

Now when it is fixed, we can safely remove this uggly
mdelay that sometimes was called in atomic context and
leads to unacceptable system freezing

Tested with different hubs, devices, and booting scenarios.

Signed-off-by: Ruslan Bilovol <ruslan.bilovol-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index a13a37c..0a59268 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -152,10 +152,8 @@ int omap4430_phy_suspend(struct device *dev, int suspend)
 		/* Enable the internel phy clcoks */
 		omap4430_phy_set_clk(dev, 1);
 		/* power on the phy */
-		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD) {
+		if (__raw_readl(ctrl_base + CONTROL_DEV_CONF) & PHY_PD)
 			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-			mdelay(200);
-		}
 
 		/* restore the context */
 		__raw_writel(usbotghs_control, ctrl_base + USBOTGHS_CONTROL);
-- 
1.7.1

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
