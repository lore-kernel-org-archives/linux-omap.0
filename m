From: Hema HK <hemahk@ti.com>
Subject: [PATCH 5/5 v2] usb: musb: OMAP4430: Save/restore the context
Date: Fri, 25 Feb 2011 18:54:06 +0530
Message-ID: <1298640246-21181-6-git-send-email-hemahk@ti.com>
References: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36688 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337Ab1BYNYh (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Feb 2011 08:24:37 -0500
In-Reply-To: <1298640246-21181-1-git-send-email-hemahk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Hema HK <hemahk@ti.com>, Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Paul Walmsley <paul@pwsan.com>

Add the context save restore for the control module register
used for OMAP4430 musb with UTMI embedded PHY interface.

Signed-off-by: Hema HK <hemahk@ti.com>
Cc: Felipe Balbi <balbi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>
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

