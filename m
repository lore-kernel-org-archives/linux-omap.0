From: felipe.balbi@nokia.com
Subject: [PATCH/PM] arm: omap: musb: proper error checking
Date: Wed, 19 May 2010 09:42:56 +0300
Message-ID: <1274251376-6111-1-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:46173 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752468Ab0ESGpX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 May 2010 02:45:23 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

We need to clk_put() and iounmap() to fully release
the resources.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---

applies on top of the linux-omap/pm

 arch/arm/mach-omap2/usb-musb.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 116548d..085e22e 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -60,23 +60,34 @@ static void __init usb_musb_pm_init(void)
 
 	dev_set_name(dev, "musb_hdrc");
 	otg_clk = clk_get(dev, "ick");
+	if (IS_ERR(otg_clk)) {
+		printk(KERN_WARNING "%s: Unable to get clock for MUSB.\n",
+				__func__);
+		goto out0;
+	}
 
-	if (otg_clk && clk_enable(otg_clk)) {
+	if (clk_enable(otg_clk)) {
 		printk(KERN_WARNING
 			"%s: Unable to enable clocks for MUSB, "
 			"cannot reset.\n",  __func__);
-	} else {
-		/* Reset OTG controller. After reset, it will be in
-		 * force-idle, force-standby mode. */
-		__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
-
-		while (!(OTG_SYSS_RESETDONE &
-					__raw_readl(otg_base + OTG_SYSSTATUS)))
-			cpu_relax();
+		goto out1;
 	}
 
-	if (otg_clk)
-		clk_disable(otg_clk);
+	/* Reset OTG controller. After reset, it will be in
+	 * force-idle, force-standby mode. */
+	__raw_writel(OTG_SYSC_SOFTRESET, otg_base + OTG_SYSCONFIG);
+
+	while (!(OTG_SYSS_RESETDONE &
+				__raw_readl(otg_base + OTG_SYSSTATUS)))
+		cpu_relax();
+
+	clk_disable(otg_clk);
+
+out1:
+	clk_put(otg_clk);
+
+out0:
+	iounmap(otg_base);
 }
 
 void usb_musb_disable_autoidle(void)
-- 
1.7.1

