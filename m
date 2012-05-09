From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: [PATCH 1/1] omap3: Provide means for changing CSI2 PHY configuration
Date: Wed,  9 May 2012 08:00:41 +0300
Message-ID: <1336539641-28424-1-git-send-email-sakari.ailus@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:40280 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754507Ab2EIFBB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 9 May 2012 01:01:01 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: paul@pwsan.com, tony@atomide.com, laurent.pinchart@ideasonboard.com

The OMAP 3630 has configuration how the ISP CSI-2 PHY pins are connected to
the actual CSI-2 receivers outside the ISP itself. Allow changing this
configuration from the ISP driver.

Signed-off-by: Sakari Ailus <sakari.ailus@iki.fi>
---
Hi,

This patch does what was discussed some time ago: provide a bit more high
level interface than the registers for the ISP driver to change the CSI-2
PHY mappings.

omap_writel()/omap_readl() functions are no longer there so this works as a
convenient push to write a patch such as this. ;-)

 arch/arm/mach-omap2/control.c              |   32 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/control.h |   11 +++++++++
 2 files changed, 43 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/include/mach/control.h

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 08e674b..78c27b2 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -12,9 +12,12 @@
  */
 #undef DEBUG
 
+#include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/io.h>
 
+#include <mach/control.h>
+
 #include <plat/hardware.h>
 #include <plat/sdrc.h>
 
@@ -564,4 +567,33 @@ int omap3_ctrl_save_padconf(void)
 	return 0;
 }
 
+void omap3_ctrl_csi2_select(u32 csi2cfg)
+{
+	/* FIXME: Do 34xx / 35xx require something here? */
+	if (cpu_is_omap3630()) {
+		u32 cam_phy_ctrl =
+			omap_ctrl_readl(OMAP3630_CONTROL_CAMERA_PHY_CTRL);
+
+		/*
+		 * SCM.CONTROL_CAMERA_PHY_CTRL
+		 * - bit[4]    : CSIPHY1 data sent to CSIB
+		 * - bit [3:2] : CSIPHY1 config: 00 d-phy, 01/10 ccp2
+		 * - bit [1:0] : CSIPHY2 config: 00 d-phy, 01/10 ccp2
+		 */
+		if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY1_CCP2B)
+			cam_phy_ctrl |= 1 << 2;
+		else if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY1_CSI2C)
+			cam_phy_ctrl &= ~(1 << 2);
+
+		if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY2_CCP2B)
+			cam_phy_ctrl |= 1;
+		else if (csi2cfg == OMAP3_CTRL_CSI2_SELECT_PHY2_CSI2A)
+			cam_phy_ctrl &= ~1;
+
+		omap_ctrl_writel(cam_phy_ctrl,
+				 OMAP3630_CONTROL_CAMERA_PHY_CTRL);
+	}
+}
+EXPORT_SYMBOL_GPL(omap3_ctrl_csi2_select);
+
 #endif /* CONFIG_ARCH_OMAP3 && CONFIG_PM */
diff --git a/arch/arm/mach-omap2/include/mach/control.h b/arch/arm/mach-omap2/include/mach/control.h
new file mode 100644
index 0000000..4490b7a
--- /dev/null
+++ b/arch/arm/mach-omap2/include/mach/control.h
@@ -0,0 +1,11 @@
+#ifndef __MACH_CONTROL_H__
+#define __MACH_CONTROL_H__
+
+#define OMAP3_CTRL_CSI2_SELECT_PHY1_CCP2B      (1 << 0)
+#define OMAP3_CTRL_CSI2_SELECT_PHY1_CSI2C      (1 << 1)
+#define OMAP3_CTRL_CSI2_SELECT_PHY2_CCP2B      (1 << 2)
+#define OMAP3_CTRL_CSI2_SELECT_PHY2_CSI2A      (1 << 3)
+
+void omap3_ctrl_csi2_select(u32 csi2cfg);
+
+#endif /* __MACH_CONTROL_H__ */
-- 
1.7.2.5

