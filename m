From: Felipe Balbi <balbi@ti.com>
Subject: [patch-v2.6.39 05/19] usb: otg: OMAP4430: Save/restore the context
Date: Tue,  1 Mar 2011 17:15:26 +0200
Message-ID: <1298992540-5984-6-git-send-email-balbi@ti.com>
References: <1298992540-5984-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:59619 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756535Ab1CAPQT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 1 Mar 2011 10:16:19 -0500
In-Reply-To: <1298992540-5984-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Anand Gadiyar <gadiyar@ti.com>, Hema HK <hemahk@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>, Felipe Balbi <balbi@ti.com>

From: Hema HK <hemahk@ti.com>

Add the context save/restore for the control module register
used for OMAP4430 musb with UTMI embedded PHY interface.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/omap_phy_internal.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_phy_internal.c b/arch/arm/mach-omap2/omap_phy_internal.c
index 3ce6758..ebe33df 100644
--- a/arch/arm/mach-omap2/omap_phy_internal.c
+++ b/arch/arm/mach-omap2/omap_phy_internal.c
@@ -43,6 +43,7 @@
 
 static struct clk *phyclk, *clk48m, *clk32k;
 static void __iomem *ctrl_base;
+static int usbotghs_control;
 
 int omap4430_phy_init(struct device *dev)
 {
@@ -129,6 +130,9 @@ int omap4430_phy_suspend(struct device *dev, int suspend)
 		omap4430_phy_set_clk(dev, 0);
 		/* Power down the phy */
 		__raw_writel(PHY_PD, ctrl_base + CONTROL_DEV_CONF);
+
+		/* save the context */
+		usbotghs_control = __raw_readl(ctrl_base + USBOTGHS_CONTROL);
 	} else {
 		/* Enable the internel phy clcoks */
 		omap4430_phy_set_clk(dev, 1);
@@ -137,6 +141,9 @@ int omap4430_phy_suspend(struct device *dev, int suspend)
 			__raw_writel(~PHY_PD, ctrl_base + CONTROL_DEV_CONF);
 			mdelay(200);
 		}
+
+		/* restore the context */
+		__raw_writel(usbotghs_control, ctrl_base + USBOTGHS_CONTROL);
 	}
 
 	return 0;
-- 
1.7.4.rc2

