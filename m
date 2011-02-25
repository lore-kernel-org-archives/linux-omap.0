From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 5/5] usb: musb: OMAP4430: Save/restore the context
Date: Fri, 25 Feb 2011 15:41:03 +0530
Message-ID: <1298628663-27650-6-git-send-email-hemahk@ti.com>
References: <1298628663-27650-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298628663-27650-1-git-send-email-hemahk-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add the context save restore for the control module register
used for OMAP4430 musb with UTMI embedded PHY interface.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index c50441f..e2e605f 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -44,6 +44,7 @@
 
 static struct clk *phyclk, *clk48m, *clk32k;
 static void __iomem *ctrl_base;
+static int usbotghs_control;
 
 int omap4430_phy_init(struct device *dev)
 {
@@ -130,6 +131,9 @@ int omap4430_phy_suspend(struct device *dev, int suspend)
 		omap4430_phy_set_clk(dev, 0);
 		/* Power down the phy */
 		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+
+		/* save the context */
+		usbotghs_control = __raw_readl(ctrl_base + USBOTGHS_CONTROL);
 	} else {
 		/* Enable the internel phy clcoks */
 		omap4430_phy_set_clk(dev, 1);
@@ -138,6 +142,9 @@ int omap4430_phy_suspend(struct device *dev, int suspend)
 			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
 			mdelay(200);
 		}
+
+		/* restore the context */
+		__raw_writel(usbotghs_control, ctrl_base + USBOTGHS_CONTROL);
 	}
 
 	return 0;
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
