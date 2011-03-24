From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] usb: otg: OMAP4430: Fix omap4430_phy_init function
Date: Thu, 24 Mar 2011 16:36:04 +0530
Message-ID: <1300964764-6794-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap4430_phy_init() function can be called with no device pointer
to powerdown the UTMI PHY during board init when USB is disabled.
Fix the function accordingly.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |   44 ++++++++++++++++--------------
 1 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index e2e605f..a959e2f 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -50,34 +50,36 @@ int omap4430_phy_init(struct device *dev)
 {
 	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
 	if (!ctrl_base) {
-		dev_err(dev, "control module ioremap failed\n");
+		printk(KERN_ERR "control module ioremap failed\n");
 		return -ENOMEM;
 	}
 	/* Power down the phy */
 	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
 
-	if (IS_ERR(phyclk)) {
-		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
-		iounmap(ctrl_base);
-		return PTR_ERR(phyclk);
-	}
+	if (dev) {
+		phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
+		if (IS_ERR(phyclk)) {
+			dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
+			iounmap(ctrl_base);
+			return PTR_ERR(phyclk);
+		}
 
-	clk48m = clk_get(dev, "ocp2scp_usb_phy_phy_48m");
-	if (IS_ERR(clk48m)) {
-		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_phy_48m\n");
-		clk_put(phyclk);
-		iounmap(ctrl_base);
-		return PTR_ERR(clk48m);
-	}
+		clk48m = clk_get(dev, "ocp2scp_usb_phy_phy_48m");
+		if (IS_ERR(clk48m)) {
+			dev_err(dev, "cannot clk_get ocp2scp_usb_phy_phy_48m\n");
+			clk_put(phyclk);
+			iounmap(ctrl_base);
+			return PTR_ERR(clk48m);
+		}
 
-	clk32k = clk_get(dev, "usb_phy_cm_clk32k");
-	if (IS_ERR(clk32k)) {
-		dev_err(dev, "cannot clk_get usb_phy_cm_clk32k\n");
-		clk_put(phyclk);
-		clk_put(clk48m);
-		iounmap(ctrl_base);
-		return PTR_ERR(clk32k);
+		clk32k = clk_get(dev, "usb_phy_cm_clk32k");
+		if (IS_ERR(clk32k)) {
+			dev_err(dev, "cannot clk_get usb_phy_cm_clk32k\n");
+			clk_put(phyclk);
+			clk_put(clk48m);
+			iounmap(ctrl_base);
+			return PTR_ERR(clk32k);
+		}
 	}
 	return 0;
 }
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
