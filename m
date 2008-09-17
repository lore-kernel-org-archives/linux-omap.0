From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] Add definitions for ETK pads and debobs registers
Date: Wed, 17 Sep 2008 18:02:27 +0300
Message-ID: <1221663749-26121-2-git-send-email-peter.de-schrijver@nokia.com>
References: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:25272 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752822AbYIQPDn (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 17 Sep 2008 11:03:43 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m8HF3eQY009509
	for <linux-omap@vger.kernel.org>; Wed, 17 Sep 2008 18:03:40 +0300
In-Reply-To: <1221663749-26121-1-git-send-email-peter.de-schrijver@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/plat-omap/include/mach/control.h |   34 +++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/control.h b/arch/arm/plat-omap/include/mach/control.h
index ef8cf12..19addae 100644
--- a/arch/arm/plat-omap/include/mach/control.h
+++ b/arch/arm/plat-omap/include/mach/control.h
@@ -149,6 +149,8 @@
 #define OMAP343X_CONTROL_FUSE_SR	(OMAP2_CONTROL_GENERAL + 0x0130)
 #define OMAP343X_CONTROL_IVA2_BOOTADDR	(OMAP2_CONTROL_GENERAL + 0x0190)
 #define OMAP343X_CONTROL_IVA2_BOOTMOD	(OMAP2_CONTROL_GENERAL + 0x0194)
+#define OMAP343X_CONTROL_DEBOBS(i)	(OMAP2_CONTROL_GENERAL + 0x01B0 \
+					+ ((i) >> 1) * 4 + (!(i) & 1) * 2)
 #define OMAP343X_CONTROL_DEBOBS_0	(OMAP2_CONTROL_GENERAL + 0x01B0)
 #define OMAP343X_CONTROL_DEBOBS_1	(OMAP2_CONTROL_GENERAL + 0x01B4)
 #define OMAP343X_CONTROL_DEBOBS_2	(OMAP2_CONTROL_GENERAL + 0x01B8)
@@ -170,6 +172,38 @@
 #define OMAP343X_CONTROL_SRAMLDO5	(OMAP2_CONTROL_GENERAL + 0x02C0)
 #define OMAP343X_CONTROL_CSI		(OMAP2_CONTROL_GENERAL + 0x02b4)
 
+/* 34xx PADCONF register offsets */
+
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
+
+#define OMAP343X_CONTROL_WKUP_DEBOBSMUX(i) (OMAP343X_CONTROL_GENERAL_WKUP + \
+						0x008 + (i))
+#define OMAP343X_CONTROL_WKUP_DEBOBS0	(OMAP343X_CONTROL_GENERAL_WKUP + 0x008)
+#define OMAP343X_CONTROL_WKUP_DEBOBS1	(OMAP343X_CONTROL_GENERAL_WKUP + 0x00C)
+#define OMAP343X_CONTROL_WKUP_DEBOBS2	(OMAP343X_CONTROL_GENERAL_WKUP + 0x010)
+#define OMAP343X_CONTROL_WKUP_DEBOBS3	(OMAP343X_CONTROL_GENERAL_WKUP + 0x014)
+#define OMAP343X_CONTROL_WKUP_DEBOBS4	(OMAP343X_CONTROL_GENERAL_WKUP + 0x018)
 
 /*
  * REVISIT: This list of registers is not comprehensive - there are more
-- 
1.5.6.3

