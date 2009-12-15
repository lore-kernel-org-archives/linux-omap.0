From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH v2] AM35xx: Add AM35xx specific control module registers
Date: Tue, 15 Dec 2009 16:57:42 +0530
Message-ID: <1260876462-10826-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:35777 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759934AbZLOL1u (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 06:27:50 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com, paul@pwsan.com

AM3517/05 has a few additional control module registers defined mainly
to control the new IP's. This patch adds support for those new registers.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index 2ae8843..6683419 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -160,6 +160,14 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
 
+/* AM35XX only CONTROL_GENERAL register offsets */
+#define AM35XX_CONTROL_MSUSPENDMUX_6    (OMAP2_CONTROL_GENERAL + 0x0038)
+#define AM35XX_CONTROL_DEVCONF2         (OMAP2_CONTROL_GENERAL + 0x0310)
+#define AM35XX_CONTROL_DEVCONF3         (OMAP2_CONTROL_GENERAL + 0x0314)
+#define AM35XX_CONTROL_CBA_PRIORITY     (OMAP2_CONTROL_GENERAL + 0x0320)
+#define AM35XX_CONTROL_LVL_INTR_CLEAR   (OMAP2_CONTROL_GENERAL + 0x0324)
+#define AM35XX_CONTROL_IP_SW_RESET      (OMAP2_CONTROL_GENERAL + 0x0328)
+#define AM35XX_CONTROL_IPSS_CLK_CTRL    (OMAP2_CONTROL_GENERAL + 0x032C)
 
 /* 34xx PADCONF register offsets */
 #define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
@@ -257,6 +265,15 @@
 #define OMAP343X_SCRATCHPAD		(OMAP343X_CTRL_BASE + 0x910)
 #define OMAP343X_SCRATCHPAD_ROM_OFFSET	0x19C
 
+/* AM35XX_CONTROL_IPSS_CLK_CTRL bits */
+#define AM35XX_USBOTG_VBUSP_CLK_SHIFT   0
+#define AM35XX_CPGMAC_VBUSP_CLK_SHIFT   1
+#define AM35XX_VPFE_VBUSP_CLK_SHIFT     2
+#define AM35XX_HECC_VBUSP_CLK_SHIFT     3
+#define AM35XX_USBOTG_FCLK_SHIFT        8
+#define AM35XX_CPGMAC_FCLK_SHIFT        9
+#define AM35XX_VPFE_FCLK_SHIFT          10
+
 /*
  * CONTROL OMAP STATUS register to identify OMAP3 features
  */
-- 
1.6.2.4

