From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 06/13] ARM: OMAP2+: clock: add fint values to the ti_clk_features struct
Date: Wed, 2 Jul 2014 11:47:40 +0300
Message-ID: <1404290867-6768-7-git-send-email-t-kristo@ti.com>
References: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54384 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751525AbaGBIr6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 2 Jul 2014 04:47:58 -0400
In-Reply-To: <1404290867-6768-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

These are SoC specific and get their init values based on the SoC type.
Previously the values were hard coded within the DPLL clock code, but
having them inside the clock features avoids runtime cpu_is_X type checks.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |   34 ++++++++++++----------------------
 arch/arm/mach-omap2/clock.c     |   23 +++++++++++++++++++++++
 arch/arm/mach-omap2/clock.h     |    4 ++++
 3 files changed, 39 insertions(+), 22 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index 5aa734a..5207e84 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -44,20 +44,12 @@
 #define DPLL_ROUNDING_VAL		((DPLL_SCALE_BASE / 2) * \
 					 (DPLL_SCALE_FACTOR / DPLL_SCALE_BASE))
 
-/* DPLL valid Fint frequency band limits - from 34xx TRM Section 4.7.6.2 */
-#define OMAP3430_DPLL_FINT_BAND1_MIN	750000
-#define OMAP3430_DPLL_FINT_BAND1_MAX	2100000
-#define OMAP3430_DPLL_FINT_BAND2_MIN	7500000
-#define OMAP3430_DPLL_FINT_BAND2_MAX	21000000
-
 /*
  * DPLL valid Fint frequency range for OMAP36xx and OMAP4xxx.
  * From device data manual section 4.3 "DPLL and DLL Specifications".
  */
 #define OMAP3PLUS_DPLL_FINT_JTYPE_MIN	500000
 #define OMAP3PLUS_DPLL_FINT_JTYPE_MAX	2500000
-#define OMAP3PLUS_DPLL_FINT_MIN		32000
-#define OMAP3PLUS_DPLL_FINT_MAX		52000000
 
 /* _dpll_test_fint() return codes */
 #define DPLL_FINT_UNDERFLOW		-1
@@ -87,33 +79,31 @@ static int _dpll_test_fint(struct clk_hw_omap *clk, int n)
 	/* DPLL divider must result in a valid jitter correction val */
 	fint = __clk_get_rate(__clk_get_parent(clk->hw.clk)) / n;
 
-	if (cpu_is_omap24xx()) {
-		/* Should not be called for OMAP2, so warn if it is called */
-		WARN(1, "No fint limits available for OMAP2!\n");
-		return DPLL_FINT_INVALID;
-	} else if (cpu_is_omap3430()) {
-		fint_min = OMAP3430_DPLL_FINT_BAND1_MIN;
-		fint_max = OMAP3430_DPLL_FINT_BAND2_MAX;
-	} else if (dd->flags & DPLL_J_TYPE) {
+	if (dd->flags & DPLL_J_TYPE) {
 		fint_min = OMAP3PLUS_DPLL_FINT_JTYPE_MIN;
 		fint_max = OMAP3PLUS_DPLL_FINT_JTYPE_MAX;
 	} else {
-		fint_min = OMAP3PLUS_DPLL_FINT_MIN;
-		fint_max = OMAP3PLUS_DPLL_FINT_MAX;
+		fint_min = ti_clk_features.fint_min;
+		fint_max = ti_clk_features.fint_max;
+	}
+
+	if (!fint_min || !fint_max) {
+		WARN(1, "No fint limits available!\n");
+		return DPLL_FINT_INVALID;
 	}
 
-	if (fint < fint_min) {
+	if (fint < ti_clk_features.fint_min) {
 		pr_debug("rejecting n=%d due to Fint failure, lowering max_divider\n",
 			 n);
 		dd->max_divider = n;
 		ret = DPLL_FINT_UNDERFLOW;
-	} else if (fint > fint_max) {
+	} else if (fint > ti_clk_features.fint_max) {
 		pr_debug("rejecting n=%d due to Fint failure, boosting min_divider\n",
 			 n);
 		dd->min_divider = n;
 		ret = DPLL_FINT_INVALID;
-	} else if (cpu_is_omap3430() && fint > OMAP3430_DPLL_FINT_BAND1_MAX &&
-		   fint < OMAP3430_DPLL_FINT_BAND2_MIN) {
+	} else if (fint > ti_clk_features.fint_band1_max &&
+		   fint < ti_clk_features.fint_band2_min) {
 		pr_debug("rejecting n=%d due to Fint failure\n", n);
 		ret = DPLL_FINT_INVALID;
 	}
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 7897053..7efe66e 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -51,6 +51,19 @@ u16 cpu_mask;
  */
 struct ti_clk_features ti_clk_features;
 
+/* DPLL valid Fint frequency band limits - from 34xx TRM Section 4.7.6.2 */
+#define OMAP3430_DPLL_FINT_BAND1_MIN	750000
+#define OMAP3430_DPLL_FINT_BAND1_MAX	2100000
+#define OMAP3430_DPLL_FINT_BAND2_MIN	7500000
+#define OMAP3430_DPLL_FINT_BAND2_MAX	21000000
+
+/*
+ * DPLL valid Fint frequency range for OMAP36xx and OMAP4xxx.
+ * From device data manual section 4.3 "DPLL and DLL Specifications".
+ */
+#define OMAP3PLUS_DPLL_FINT_MIN		32000
+#define OMAP3PLUS_DPLL_FINT_MAX		52000000
+
 /*
  * clkdm_control: if true, then when a clock is enabled in the
  * hardware, its clockdomain will first be enabled; and when a clock
@@ -744,4 +757,14 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
  */
 void __init ti_clk_init_features(void)
 {
+	/* Fint setup for DPLLs */
+	if (cpu_is_omap3430()) {
+		ti_clk_features.fint_min = OMAP3430_DPLL_FINT_BAND1_MIN;
+		ti_clk_features.fint_max = OMAP3430_DPLL_FINT_BAND2_MAX;
+		ti_clk_features.fint_band1_max = OMAP3430_DPLL_FINT_BAND1_MAX;
+		ti_clk_features.fint_band2_min = OMAP3430_DPLL_FINT_BAND2_MIN;
+	} else {
+		ti_clk_features.fint_min = OMAP3PLUS_DPLL_FINT_MIN;
+		ti_clk_features.fint_max = OMAP3PLUS_DPLL_FINT_MAX;
+	}
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 9b89cc0..02aa2e3 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -228,6 +228,10 @@ extern u16 cpu_mask;
  */
 struct ti_clk_features {
 	u32 flags;
+	long fint_min;
+	long fint_max;
+	long fint_band1_max;
+	long fint_band2_min;
 };
 extern struct ti_clk_features ti_clk_features;
 
-- 
1.7.9.5

