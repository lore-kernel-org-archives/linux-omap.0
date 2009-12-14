From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 1/2] OMAP3 clock: reorganize CK_* platform flags
Date: Mon, 14 Dec 2009 13:16:38 -0700
Message-ID: <20091214201635.370.2758.stgit@localhost.localdomain>
References: <20091214201431.370.35496.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46358 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758200AbZLNUTp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 14 Dec 2009 15:19:45 -0500
In-Reply-To: <20091214201431.370.35496.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Ranjith Lohithakshan <ranjithl@ti.com>

Add CK_* flags for the two new Sitara chips, AM3505 and AM3517, and
the OMAP34xx die shrink, OMAP36xx/OMAP37xx.  Introduce a new CK_*
flag, CK_3XXX, that marks all clocks that are common to OMAP3 family
chips.  CK_343X now refers to clocks that are available only on
OMAP34{1,2,3,4}0 (WTBU) and OMAP35{03,15,25,30} (any version).
At some point, the RATE_IN_* flags should be updated also.

While here, add some documentation describing the chip families
covered by these clock flags.

This patch is partially based on patches from Ranjith Lohithakshan
<ranjithl@ti.com> and Vishwanath Sripathy <vishwanath.bs@ti.com>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Ranjith Lohithakshan <ranjithl@ti.com>
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock34xx_data.c          |    4 ++--
 arch/arm/plat-omap/include/plat/clkdev_omap.h |   26 ++++++++++++++++---------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 8bdcc9c..d714f84 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3216,11 +3216,11 @@ int __init omap2_clk_init(void)
 	/* struct prcm_config *prcm; */
 	struct omap_clk *c;
 	/* u32 clkrate; */
-	u32 cpu_clkflg;
+	u32 cpu_clkflg = CK_3XXX;
 
 	if (cpu_is_omap34xx()) {
 		cpu_mask = RATE_IN_343X;
-		cpu_clkflg = CK_343X;
+		cpu_clkflg |= CK_343X;
 
 		/*
 		 * Update this if there are further clock changes between ES2
diff --git a/arch/arm/plat-omap/include/plat/clkdev_omap.h b/arch/arm/plat-omap/include/plat/clkdev_omap.h
index 35b36ca..bb937f3 100644
--- a/arch/arm/plat-omap/include/plat/clkdev_omap.h
+++ b/arch/arm/plat-omap/include/plat/clkdev_omap.h
@@ -25,17 +25,25 @@ struct omap_clk {
 		},			\
 	}
 
-
+/* Platform flags for the clkdev-OMAP integration code */
 #define CK_310		(1 << 0)
-#define CK_7XX		(1 << 1)
+#define CK_7XX		(1 << 1)	/* 7xx, 850 */
 #define CK_1510		(1 << 2)
-#define CK_16XX		(1 << 3)
-#define CK_243X		(1 << 4)
-#define CK_242X		(1 << 5)
-#define CK_343X		(1 << 6)
-#define CK_3430ES1	(1 << 7)
-#define CK_3430ES2	(1 << 8)
-#define CK_443X		(1 << 9)
+#define CK_16XX		(1 << 3)	/* 16xx, 17xx, 5912 */
+#define CK_242X		(1 << 4)
+#define CK_243X		(1 << 5)
+#define CK_3XXX		(1 << 6)	/* OMAP3 + AM3 common clocks*/
+#define CK_343X		(1 << 7)	/* OMAP34xx common clocks */
+#define CK_3430ES1	(1 << 8)	/* 34xxES1 only */
+#define CK_3430ES2	(1 << 9)	/* 34xxES2, ES3, non-Sitara 35xx only */
+#define CK_3505		(1 << 10)
+#define CK_3517		(1 << 11)
+#define CK_36XX		(1 << 12)	/* OMAP36xx/37xx-specific clocks */
+#define CK_443X		(1 << 13)
+
+#define CK_AM35XX	(CK_3505 | CK_3517)	/* all Sitara AM35xx */
+
+
 
 #endif
 


