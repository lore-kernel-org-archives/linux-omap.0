From: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2 v2] usb: otg: OMAP4430: Fixing the omap4430_phy_init function
Date: Thu, 24 Mar 2011 17:08:42 +0530
Message-ID: <1300966722-10955-1-git-send-email-hemahk@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

omap4430_phy_init() function can be called with no device pointer,
to powerdown the PHY during board init when USB is disabled.
Fix the function accordingly.

Signed-off-by: Hema HK <hemahk-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index e2e605f..ae97336 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -50,13 +50,16 @@ int omap4430_phy_init(struct device *dev)
 {
 	ctrl_base = ioremap(OMAP443X_SCM_BASE, SZ_1K);
 	if (!ctrl_base) {
-		dev_err(dev, "control module ioremap failed\n");
+		pr_err("control module ioremap failed\n");
 		return -ENOMEM;
 	}
 	/* Power down the phy */
 	__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
-	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
 
+	if (!dev)
+		return 0;
+
+	phyclk = clk_get(dev, "ocp2scp_usb_phy_ick");
 	if (IS_ERR(phyclk)) {
 		dev_err(dev, "cannot clk_get ocp2scp_usb_phy_ick\n");
 		iounmap(ctrl_base);
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
