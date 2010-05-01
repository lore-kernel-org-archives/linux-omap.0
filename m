From: virtuoso@slind.org
Subject: [PATCH 2/6] coresight: cosmetic fixes
Date: Sat,  1 May 2010 20:38:17 +0300
Message-ID: <1272735501-2963-3-git-send-email-virtuoso@slind.org>
References: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:44777 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755764Ab0EARlV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 1 May 2010 13:41:21 -0400
In-Reply-To: <1272735501-2963-1-git-send-email-virtuoso@slind.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, khilman@deeprootsystems.com, r-woodruff2@ti.com, Alexander Shishkin <virtuoso@slind.org>

From: Alexander Shishkin <virtuoso@slind.org>

Use BIT() macro whenever it is sensible to do so.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/include/asm/hardware/coresight.h |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/hardware/coresight.h b/arch/arm/include/asm/hardware/coresight.h
index d846051..7ecd793 100644
--- a/arch/arm/include/asm/hardware/coresight.h
+++ b/arch/arm/include/asm/hardware/coresight.h
@@ -100,10 +100,10 @@
 
 /* ETM status register, "ETM Architecture", 3.3.2 */
 #define ETMR_STATUS		(0x10)
-#define ETMST_OVERFLOW		(1 << 0)
-#define ETMST_PROGBIT		(1 << 1)
-#define ETMST_STARTSTOP		(1 << 2)
-#define ETMST_TRIGGER		(1 << 3)
+#define ETMST_OVERFLOW		BIT(0)
+#define ETMST_PROGBIT		BIT(1)
+#define ETMST_STARTSTOP		BIT(2)
+#define ETMST_TRIGGER		BIT(3)
 
 #define etm_progbit(t)		(etm_readl((t), ETMR_STATUS) & ETMST_PROGBIT)
 #define etm_started(t)		(etm_readl((t), ETMR_STATUS) & ETMST_STARTSTOP)
@@ -111,7 +111,7 @@
 
 #define ETMR_TRACEENCTRL2	0x1c
 #define ETMR_TRACEENCTRL	0x24
-#define ETMTE_INCLEXCL		(1 << 24)
+#define ETMTE_INCLEXCL		BIT(24)
 #define ETMR_TRACEENEVT		0x20
 #define ETMCTRL_OPTS		(ETMCTRL_DO_CPRT | \
 				ETMCTRL_DATA_DO_ADDR | \
@@ -134,12 +134,12 @@
 #define ETBR_CTRL		0x20
 #define ETBR_FORMATTERCTRL	0x304
 #define ETBFF_ENFTC		1
-#define ETBFF_ENFCONT		(1 << 1)
-#define ETBFF_FONFLIN		(1 << 4)
-#define ETBFF_MANUAL_FLUSH	(1 << 6)
-#define ETBFF_TRIGIN		(1 << 8)
-#define ETBFF_TRIGEVT		(1 << 9)
-#define ETBFF_TRIGFL		(1 << 10)
+#define ETBFF_ENFCONT		BIT(1)
+#define ETBFF_FONFLIN		BIT(4)
+#define ETBFF_MANUAL_FLUSH	BIT(6)
+#define ETBFF_TRIGIN		BIT(8)
+#define ETBFF_TRIGEVT		BIT(9)
+#define ETBFF_TRIGFL		BIT(10)
 
 #define etb_writel(t, v, x) \
 	(__raw_writel((v), (t)->etb_regs + (x)))
-- 
1.7.1.1.g15764

