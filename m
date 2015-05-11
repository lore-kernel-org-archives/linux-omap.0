From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 01/27] ARM: OMAP2+: clock: export driver API to setup/get clock features
Date: Mon, 11 May 2015 11:54:27 +0300
Message-ID: <1431334493-24455-2-git-send-email-t-kristo@ti.com>
References: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46475 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbbEKIyy (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 11 May 2015 04:54:54 -0400
In-Reply-To: <1431334493-24455-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: mturquette@linaro.org, tony@atomide.com, linux-omap@vger.kernel.org, linux-clk@vger.kernel.org, sboyd@codeaurora.org, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org

As most of the clock driver support code is going to be moved under
drivers/clk/ti, an API for setting / getting the SoC specific clock
features is needed. This patch provides this API and changes the
existing code to use it.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt_dpll.c |   14 +++++++-------
 arch/arm/mach-omap2/clock.c     |   36 +++++++++++++++++-------------------
 arch/arm/mach-omap2/clock.h     |   18 ------------------
 arch/arm/mach-omap2/clock3xxx.c |    4 ++--
 arch/arm/mach-omap2/dpll3xxx.c  |    4 ++--
 drivers/clk/ti/clk.c            |   25 +++++++++++++++++++++++++
 include/linux/clk/ti.h          |   16 ++++++++++++++++
 7 files changed, 69 insertions(+), 48 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt_dpll.c b/arch/arm/mach-omap2/clkt_dpll.c
index f251a14..82f0600 100644
--- a/arch/arm/mach-omap2/clkt_dpll.c
+++ b/arch/arm/mach-omap2/clkt_dpll.c
@@ -80,8 +80,8 @@ static int _dpll_test_fint(struct clk_hw_omap *clk, unsigned int n)
 		fint_min = OMAP3PLUS_DPLL_FINT_JTYPE_MIN;
 		fint_max = OMAP3PLUS_DPLL_FINT_JTYPE_MAX;
 	} else {
-		fint_min = ti_clk_features.fint_min;
-		fint_max = ti_clk_features.fint_max;
+		fint_min = ti_clk_get_features()->fint_min;
+		fint_max = ti_clk_get_features()->fint_max;
 	}
 
 	if (!fint_min || !fint_max) {
@@ -89,18 +89,18 @@ static int _dpll_test_fint(struct clk_hw_omap *clk, unsigned int n)
 		return DPLL_FINT_INVALID;
 	}
 
-	if (fint < ti_clk_features.fint_min) {
+	if (fint < ti_clk_get_features()->fint_min) {
 		pr_debug("rejecting n=%d due to Fint failure, lowering max_divider\n",
 			 n);
 		dd->max_divider = n;
 		ret = DPLL_FINT_UNDERFLOW;
-	} else if (fint > ti_clk_features.fint_max) {
+	} else if (fint > ti_clk_get_features()->fint_max) {
 		pr_debug("rejecting n=%d due to Fint failure, boosting min_divider\n",
 			 n);
 		dd->min_divider = n;
 		ret = DPLL_FINT_INVALID;
-	} else if (fint > ti_clk_features.fint_band1_max &&
-		   fint < ti_clk_features.fint_band2_min) {
+	} else if (fint > ti_clk_get_features()->fint_band1_max &&
+		   fint < ti_clk_get_features()->fint_band2_min) {
 		pr_debug("rejecting n=%d due to Fint failure\n", n);
 		ret = DPLL_FINT_INVALID;
 	}
@@ -183,7 +183,7 @@ static int _omap2_dpll_is_in_bypass(u32 v)
 {
 	u8 mask, val;
 
-	mask = ti_clk_features.dpll_bypass_vals;
+	mask = ti_clk_get_features()->dpll_bypass_vals;
 
 	/*
 	 * Each set bit in the mask corresponds to a bypass value equal
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index a699d71..cbc65b3 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -48,11 +48,6 @@
 
 u16 cpu_mask;
 
-/*
- * Clock features setup. Used instead of CPU type checks.
- */
-struct ti_clk_features ti_clk_features;
-
 /* DPLL valid Fint frequency band limits - from 34xx TRM Section 4.7.6.2 */
 #define OMAP3430_DPLL_FINT_BAND1_MIN	750000
 #define OMAP3430_DPLL_FINT_BAND1_MAX	2100000
@@ -367,7 +362,7 @@ void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
 	 * 34xx reverses this, just to keep us on our toes
 	 * AM35xx uses both, depending on the module.
 	 */
-	*idlest_val = ti_clk_features.cm_idlest_val;
+	*idlest_val = ti_clk_get_features()->cm_idlest_val;
 }
 
 /**
@@ -801,29 +796,30 @@ void __init omap2_clk_print_new_rates(const char *hfclkin_ck_name,
  */
 void __init ti_clk_init_features(void)
 {
+	struct ti_clk_features features = { 0 };
 	/* Fint setup for DPLLs */
 	if (cpu_is_omap3430()) {
-		ti_clk_features.fint_min = OMAP3430_DPLL_FINT_BAND1_MIN;
-		ti_clk_features.fint_max = OMAP3430_DPLL_FINT_BAND2_MAX;
-		ti_clk_features.fint_band1_max = OMAP3430_DPLL_FINT_BAND1_MAX;
-		ti_clk_features.fint_band2_min = OMAP3430_DPLL_FINT_BAND2_MIN;
+		features.fint_min = OMAP3430_DPLL_FINT_BAND1_MIN;
+		features.fint_max = OMAP3430_DPLL_FINT_BAND2_MAX;
+		features.fint_band1_max = OMAP3430_DPLL_FINT_BAND1_MAX;
+		features.fint_band2_min = OMAP3430_DPLL_FINT_BAND2_MIN;
 	} else {
-		ti_clk_features.fint_min = OMAP3PLUS_DPLL_FINT_MIN;
-		ti_clk_features.fint_max = OMAP3PLUS_DPLL_FINT_MAX;
+		features.fint_min = OMAP3PLUS_DPLL_FINT_MIN;
+		features.fint_max = OMAP3PLUS_DPLL_FINT_MAX;
 	}
 
 	/* Bypass value setup for DPLLs */
 	if (cpu_is_omap24xx()) {
-		ti_clk_features.dpll_bypass_vals |=
+		features.dpll_bypass_vals |=
 			(1 << OMAP2XXX_EN_DPLL_LPBYPASS) |
 			(1 << OMAP2XXX_EN_DPLL_FRBYPASS);
 	} else if (cpu_is_omap34xx()) {
-		ti_clk_features.dpll_bypass_vals |=
+		features.dpll_bypass_vals |=
 			(1 << OMAP3XXX_EN_DPLL_LPBYPASS) |
 			(1 << OMAP3XXX_EN_DPLL_FRBYPASS);
 	} else if (soc_is_am33xx() || cpu_is_omap44xx() || soc_is_am43xx() ||
 		   soc_is_omap54xx() || soc_is_dra7xx()) {
-		ti_clk_features.dpll_bypass_vals |=
+		features.dpll_bypass_vals |=
 			(1 << OMAP4XXX_EN_DPLL_LPBYPASS) |
 			(1 << OMAP4XXX_EN_DPLL_FRBYPASS) |
 			(1 << OMAP4XXX_EN_DPLL_MNBYPASS);
@@ -831,7 +827,7 @@ void __init ti_clk_init_features(void)
 
 	/* Jitter correction only available on OMAP343X */
 	if (cpu_is_omap343x())
-		ti_clk_features.flags |= TI_CLK_DPLL_HAS_FREQSEL;
+		features.flags |= TI_CLK_DPLL_HAS_FREQSEL;
 
 	/* Idlest value for interface clocks.
 	 * 24xx uses 0 to indicate not ready, and 1 to indicate ready.
@@ -839,11 +835,13 @@ void __init ti_clk_init_features(void)
 	 * AM35xx uses both, depending on the module.
 	 */
 	if (cpu_is_omap24xx())
-		ti_clk_features.cm_idlest_val = OMAP24XX_CM_IDLEST_VAL;
+		features.cm_idlest_val = OMAP24XX_CM_IDLEST_VAL;
 	else if (cpu_is_omap34xx())
-		ti_clk_features.cm_idlest_val = OMAP34XX_CM_IDLEST_VAL;
+		features.cm_idlest_val = OMAP34XX_CM_IDLEST_VAL;
 
 	/* On OMAP3430 ES1.0, DPLL4 can't be re-programmed */
 	if (omap_rev() == OMAP3430_REV_ES1_0)
-		ti_clk_features.flags |= TI_CLK_DPLL4_DENY_REPROGRAM;
+		features.flags |= TI_CLK_DPLL4_DENY_REPROGRAM;
+
+	ti_clk_setup_features(&features);
 }
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 652ed0a..ac21856 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -225,24 +225,6 @@ void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg);
 
 extern u16 cpu_mask;
 
-/*
- * Clock features setup. Used instead of CPU type checks.
- */
-struct ti_clk_features {
-	u32 flags;
-	long fint_min;
-	long fint_max;
-	long fint_band1_max;
-	long fint_band2_min;
-	u8 dpll_bypass_vals;
-	u8 cm_idlest_val;
-};
-
-#define TI_CLK_DPLL_HAS_FREQSEL		(1 << 0)
-#define TI_CLK_DPLL4_DENY_REPROGRAM	(1 << 1)
-
-extern struct ti_clk_features ti_clk_features;
-
 extern const struct clkops clkops_omap2_dflt_wait;
 extern const struct clkops clkops_omap2_dflt;
 
diff --git a/arch/arm/mach-omap2/clock3xxx.c b/arch/arm/mach-omap2/clock3xxx.c
index a9e86db..8bede6a 100644
--- a/arch/arm/mach-omap2/clock3xxx.c
+++ b/arch/arm/mach-omap2/clock3xxx.c
@@ -58,7 +58,7 @@ int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 	 * on 3430ES1 prevents us from changing DPLL multipliers or dividers
 	 * on DPLL4.
 	 */
-	if (ti_clk_features.flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
 		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
 		return -EINVAL;
 	}
@@ -81,7 +81,7 @@ int omap3_dpll4_set_rate(struct clk_hw *hw, unsigned long rate,
 int omap3_dpll4_set_rate_and_parent(struct clk_hw *hw, unsigned long rate,
 				    unsigned long parent_rate, u8 index)
 {
-	if (ti_clk_features.flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL4_DENY_REPROGRAM) {
 		pr_err("clock: DPLL4 cannot change rate due to silicon 'Limitation 2.5' on 3430ES1.\n");
 		return -EINVAL;
 	}
diff --git a/arch/arm/mach-omap2/dpll3xxx.c b/arch/arm/mach-omap2/dpll3xxx.c
index 44e57ec..9a80f59 100644
--- a/arch/arm/mach-omap2/dpll3xxx.c
+++ b/arch/arm/mach-omap2/dpll3xxx.c
@@ -307,7 +307,7 @@ static int omap3_noncore_dpll_program(struct clk_hw_omap *clk, u16 freqsel)
 	 * Set jitter correction. Jitter correction applicable for OMAP343X
 	 * only since freqsel field is no longer present on other devices.
 	 */
-	if (ti_clk_features.flags & TI_CLK_DPLL_HAS_FREQSEL) {
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
 		v = omap2_clk_readl(clk, dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -559,7 +559,7 @@ int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
 		return -EINVAL;
 
 	/* Freqsel is available only on OMAP343X devices */
-	if (ti_clk_features.flags & TI_CLK_DPLL_HAS_FREQSEL) {
+	if (ti_clk_get_features()->flags & TI_CLK_DPLL_HAS_FREQSEL) {
 		freqsel = _omap3_dpll_compute_freqsel(clk, dd->last_rounded_n);
 		WARN_ON(!freqsel);
 	}
diff --git a/drivers/clk/ti/clk.c b/drivers/clk/ti/clk.c
index 0ebe5c5..567f8b9 100644
--- a/drivers/clk/ti/clk.c
+++ b/drivers/clk/ti/clk.c
@@ -30,6 +30,8 @@
 struct ti_clk_ll_ops *ti_clk_ll_ops;
 static struct device_node *clocks_node_ptr[CLK_MAX_MEMMAPS];
 
+struct ti_clk_features ti_clk_features;
+
 /**
  * ti_dt_clocks_register - register DT alias clocks during boot
  * @oclks: list of clocks to register
@@ -310,4 +312,27 @@ int __init ti_clk_register_legacy_clks(struct ti_clk_alias *clks)
 
 	return 0;
 }
+
+/**
+ * ti_clk_setup_features - setup clock features flags
+ * @features: features definition to use
+ *
+ * Initializes the clock driver features flags based on platform
+ * provided data. No return value.
+ */
+void __init ti_clk_setup_features(struct ti_clk_features *features)
+{
+	memcpy(&ti_clk_features, features, sizeof(*features));
+}
+
+/**
+ * ti_clk_get_features - get clock driver features flags
+ *
+ * Get TI clock driver features description. Returns a pointer
+ * to the current feature setup.
+ */
+struct ti_clk_features *ti_clk_get_features(void)
+{
+	return &ti_clk_features;
+}
 #endif
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 79b76e1..b066835 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -338,6 +338,22 @@ int am43xx_dt_clk_init(void);
 int omap2420_dt_clk_init(void);
 int omap2430_dt_clk_init(void);
 
+struct ti_clk_features {
+	u32 flags;
+	long fint_min;
+	long fint_max;
+	long fint_band1_max;
+	long fint_band2_min;
+	u8 dpll_bypass_vals;
+	u8 cm_idlest_val;
+};
+
+#define TI_CLK_DPLL_HAS_FREQSEL			BIT(0)
+#define TI_CLK_DPLL4_DENY_REPROGRAM		BIT(1)
+
+void ti_clk_setup_features(struct ti_clk_features *features);
+struct ti_clk_features *ti_clk_get_features(void);
+
 #ifdef CONFIG_OF
 void of_ti_clk_allow_autoidle_all(void);
 void of_ti_clk_deny_autoidle_all(void);
-- 
1.7.9.5

