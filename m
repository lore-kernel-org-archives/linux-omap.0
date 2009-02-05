From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 19/21] OMAP: PM: Add definitions for ETK pads and observability registers
Date: Wed,  4 Feb 2009 18:06:05 -0800
Message-ID: <1233799567-22250-20-git-send-email-khilman@deeprootsystems.com>
References: <1233799567-22250-1-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-2-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-3-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-4-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-5-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-6-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-7-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-8-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-9-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-10-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-11-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-12-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-13-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-14-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-15-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-16-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-17-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-18-git-send-email-khilman@deeprootsystems.com>
 <1233799567-22250-19-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:56091 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762604AbZBECHr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 4 Feb 2009 21:07:47 -0500
Received: by yx-out-2324.google.com with SMTP id 8so195yxm.1
        for <linux-omap@vger.kernel.org>; Wed, 04 Feb 2009 18:07:46 -0800 (PST)
In-Reply-To: <1233799567-22250-19-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/plat-omap/include/mach/control.h |   47 +++++++++++++++++++++++++++-
 1 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index 9052a0a..c76e4ec 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -150,8 +150,51 @@
 #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
-#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02b0)
-#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02b4)
+#define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
+					+ ((i) >> 1) * 4 + (!(i & 1)) * 2)
+#define OMAP343X_CONTROL_PROG_IO0	(OMAP2_CONTROL_GENERAL + 0x01D4)
+#define OMAP343X_CONTROL_PROG_IO1	(OMAP2_CONTROL_GENERAL + 0x01D8)
+#define OMAP343X_CONTROL_DSS_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E0)
+#define OMAP343X_CONTROL_CORE_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E4)
+#define OMAP343X_CONTROL_PER_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01E8)
+#define OMAP343X_CONTROL_USBHOST_DPLL_SPREADING	(OMAP2_CONTROL_GENERAL + 0x01EC)
+#define OMAP343X_CONTROL_PBIAS_LITE	(OMAP2_CONTROL_GENERAL + 0x02B0)
+#define OMAP343X_CONTROL_TEMP_SENSOR	(OMAP2_CONTROL_GENERAL + 0x02B4)
+#define OMAP343X_CONTROL_SRAMLDO4	(OMAP2_CONTROL_GENERAL + 0x02B8)
+#define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
+#define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02C4)
+
+
+/* 34xx PADCONF register offsets */
+#define OMAP343X_PADCONF_ETK(i)		(OMAP2_CONTROL_PADCONFS + 0x5a8 + \
+						(i)*2)
+#define OMAP343X_PADCONF_ETK_CLK	OMAP343X_PADCONF_ETK(0)
+#define OMAP343X_PADCONF_ETK_CTL	OMAP343X_PADCONF_ETK(1)
+#define OMAP343X_PADCONF_ETK_D0		OMAP343X_PADCONF_ETK(2)
+#define OMAP343X_PADCONF_ETK_D1		OMAP343X_PADCONF_ETK(3)
+#define OMAP343X_PADCONF_ETK_D2		OMAP343X_PADCONF_ETK(4)
+#define OMAP343X_PADCONF_ETK_D3		OMAP343X_PADCONF_ETK(5)
+#define OMAP343X_PADCONF_ETK_D4		OMAP343X_PADCONF_ETK(6)
+#define OMAP343X_PADCONF_ETK_D5		OMAP343X_PADCONF_ETK(7)
+#define OMAP343X_PADCONF_ETK_D6		OMAP343X_PADCONF_ETK(8)
+#define OMAP343X_PADCONF_ETK_D7		OMAP343X_PADCONF_ETK(9)
+#define OMAP343X_PADCONF_ETK_D8		OMAP343X_PADCONF_ETK(10)
+#define OMAP343X_PADCONF_ETK_D9		OMAP343X_PADCONF_ETK(11)
+#define OMAP343X_PADCONF_ETK_D10	OMAP343X_PADCONF_ETK(12)
+#define OMAP343X_PADCONF_ETK_D11	OMAP343X_PADCONF_ETK(13)
+#define OMAP343X_PADCONF_ETK_D12	OMAP343X_PADCONF_ETK(14)
+#define OMAP343X_PADCONF_ETK_D13	OMAP343X_PADCONF_ETK(15)
+#define OMAP343X_PADCONF_ETK_D14	OMAP343X_PADCONF_ETK(16)
+#define OMAP343X_PADCONF_ETK_D15	OMAP343X_PADCONF_ETK(17)
+
+/* 34xx GENERAL_WKUP regist offsets */
+#define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
+						0x008 + (i))
+#define OMAP343X_CONTROL_WKUP_DEBOBS0 (OMAP343X_CONTROL_GENERAL_WKUP + 0x008)
+#define OMAP343X_CONTROL_WKUP_DEBOBS1 (OMAP343X_CONTROL_GENERAL_WKUP + 0x00C)
+#define OMAP343X_CONTROL_WKUP_DEBOBS2 (OMAP343X_CONTROL_GENERAL_WKUP + 0x010)
+#define OMAP343X_CONTROL_WKUP_DEBOBS3 (OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
+#define OMAP343X_CONTROL_WKUP_DEBOBS4 (OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
-- 
1.6.1

