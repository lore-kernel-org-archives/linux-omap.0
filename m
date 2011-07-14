From: Jon Hunter <jon-hunter@ti.com>
Subject: [PATCH 5/6] OMAP3+: Update DPLL Fint range for OMAP36xx and OMAP4xxx devices
Date: Thu, 14 Jul 2011 18:25:01 -0500
Message-ID: <1310685901-3397-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45344 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932590Ab1GNXZE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Jul 2011 19:25:04 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Jon Hunter <jon-hunter@ti.com>

From: Jon Hunter <jon-hunter@ti.com>

The OMAP36xx and OMAP4xxx DPLLs have a different internal reference
clock frequency (fint) operating range than OMAP3430. Update the
dpll_test_fint() function to check for the correct frequency ranges
for OMAP36xx and OMAP4xxx.

For OMAP36xx and OMAP4xxx devices, DPLLs fint range is 0.5MHz to
2.5MHz for j-type DPLLs and otherwise it is 32KHz to 52MHz for all
other DPLLs.

Signed-off-by: Jon Hunter <jon-hunter@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |   51 ++++++++++++++++++++++++++------------
 1 files changed, 35 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index bcffee0..e069a9b 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -46,10 +46,19 @@
 					 (DPLL_SCALE_FACTOR / DPLL_SCALE_BASE))
 
 /* DPLL valid Fint frequency band limits - from 34xx TRM Section 4.7.6.2 */
-#define DPLL_FINT_BAND1_MIN		750000
-#define DPLL_FINT_BAND1_MAX		2100000
-#define DPLL_FINT_BAND2_MIN		7500000
-#define DPLL_FINT_BAND2_MAX		21000000
+#define OMAP3430_DPLL_FINT_BAND1_MIN	750000
+#define OMAP3430_DPLL_FINT_BAND1_MAX	2100000
+#define OMAP3430_DPLL_FINT_BAND2_MIN	7500000
+#define OMAP3430_DPLL_FINT_BAND2_MAX	21000000
+
+/*
+ * DPLL valid Fint frequency range for OMAP36xx and OMAP4xxx.
+ * From device data manual section 4.3 "DPLL and DLL Specifications".
+ */
+#define OMAP3PLUS_DPLL_FINT_JTYPE_MIN	500000
+#define OMAP3PLUS_DPLL_FINT_JTYPE_MAX	2500000
+#define OMAP3PLUS_DPLL_FINT_MIN		32000
+#define OMAP3PLUS_DPLL_FINT_MAX		52000000
 
 /* _dpll_test_fint() return codes */
 #define DPLL_FINT_UNDERFLOW		-1
@@ -71,33 +80,43 @@
 static int _dpll_test_fint(struct clk *clk, u8 n)
 {
 	struct dpll_data *dd;
-	long fint;
+	long fint, fint_min, fint_max;
 	int ret = 0;
 
 	dd = clk->dpll_data;
 
 	/* DPLL divider must result in a valid jitter correction val */
 	fint = clk->parent->rate / n;
-	if (fint < DPLL_FINT_BAND1_MIN) {
 
+	if (cpu_is_omap24xx()) {
+		/* Should not be called for OMAP2, so warn if it is called */
+		WARN(1, "No fint limits available for OMAP2!\n");
+		return DPLL_FINT_INVALID;
+	} else if (cpu_is_omap3430()) {
+		fint_min = OMAP3430_DPLL_FINT_BAND1_MIN;
+		fint_max = OMAP3430_DPLL_FINT_BAND2_MAX;
+	} else if (dd->flags & DPLL_J_TYPE) {
+		fint_min = OMAP3PLUS_DPLL_FINT_JTYPE_MIN;
+		fint_max = OMAP3PLUS_DPLL_FINT_JTYPE_MAX;
+	} else {
+		fint_min = OMAP3PLUS_DPLL_FINT_MIN;
+		fint_max = OMAP3PLUS_DPLL_FINT_MAX;
+	}
+
+	if (fint < fint_min) {
 		pr_debug("rejecting n=%d due to Fint failure, "
 			 "lowering max_divider\n", n);
 		dd->max_divider = n;
 		ret = DPLL_FINT_UNDERFLOW;
-
-	} else if (fint > DPLL_FINT_BAND1_MAX &&
-		   fint < DPLL_FINT_BAND2_MIN) {
-
-		pr_debug("rejecting n=%d due to Fint failure\n", n);
-		ret = DPLL_FINT_INVALID;
-
-	} else if (fint > DPLL_FINT_BAND2_MAX) {
-
+	} else if (fint > fint_max) {
 		pr_debug("rejecting n=%d due to Fint failure, "
 			 "boosting min_divider\n", n);
 		dd->min_divider = n;
 		ret = DPLL_FINT_INVALID;
-
+	} else if (cpu_is_omap3430() && fint > OMAP3430_DPLL_FINT_BAND1_MAX &&
+		   fint < OMAP3430_DPLL_FINT_BAND2_MIN) {
+		pr_debug("rejecting n=%d due to Fint failure\n", n);
+		ret = DPLL_FINT_INVALID;
 	}
 
 	return ret;
-- 
1.7.4.1

