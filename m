From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] AM35xx: Add AM35xx specific control module registers
Date: Tue,  3 Nov 2009 23:07:50 +0530
Message-ID: <1257269870-10356-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38256 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbZKCRhu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 3 Nov 2009 12:37:50 -0500
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id nA3Hbqrd001307
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 3 Nov 2009 11:37:54 -0600
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ranjithl@ti.com

AM3517/05 has a few additional control module registers defined mainly
to control the new IP's. This patch adds support for those new registers.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 arch/arm/plat-omap/include/plat/control.h |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/control.h b/arch/arm/plat-omap/include/plat/control.h
index fdb6300..9ba907a 100644
--- a/arch/arm/plat-omap/include/plat/control.h
+++ b/arch/arm/plat-omap/include/plat/control.h
@@ -147,6 +147,15 @@
 #define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
 #define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
 
+/* OMAP3517/AM3517 only CONTROL_GENERAL register offsets */
+#define OMAP3517_CONTROL_MSUSPENDMUX_6  (OMAP2_CONTROL_GENERAL + 0x0038)
+#define OMAP3517_CONTROL_DEVCONF2       (OMAP2_CONTROL_GENERAL + 0x0310)
+#define OMAP3517_CONTROL_DEVCONF3       (OMAP2_CONTROL_GENERAL + 0x0314)
+#define OMAP3517_CONTROL_CBA_PRIORITY   (OMAP2_CONTROL_GENERAL + 0x0320)
+#define OMAP3517_CONTROL_LVL_INTR_CLEAR (OMAP2_CONTROL_GENERAL + 0x0324)
+#define OMAP3517_CONTROL_IP_SW_RESET    (OMAP2_CONTROL_GENERAL + 0x0328)
+#define OMAP3517_CONTROL_IP_CLK_CTRL    (OMAP2_CONTROL_GENERAL + 0x032C)
+
 /* 34xx D2D idle-related pins, handled by PM core */
 #define OMAP3_PADCONF_SAD2D_MSTANDBY   0x250
 #define OMAP3_PADCONF_SAD2D_IDLEACK    0x254
@@ -238,6 +247,14 @@
 #define		FEAT_NEON		0
 #define		FEAT_NEON_NONE		1
 
+/* OMAP3517_CONTROL_IP_CLK_CTRL bits */
+#define OMAP3517_USBOTG_VBUSP_CLK_SHIFT    0
+#define OMAP3517_CPGMAC_VBUSP_CLK_SHIFT    1
+#define OMAP3517_VPFE_VBUSP_CLK_SHIFT      2
+#define OMAP3517_HECC_VBUSP_CLK_SHIFT      3
+#define OMAP3517_USBOTG_FCLK_SHIFT         8
+#define OMAP3517_CPGMAC_FCLK_SHIFT         9
+#define OMAP3517_VPFE_FCLK_SHIFT           10
 
 #ifndef __ASSEMBLY__
 #if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
-- 
1.6.2.4

