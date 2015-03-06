From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 16/24] ARM: OMAP2+: clock: remove clkdm_control static boolean from code
Date: Fri, 6 Mar 2015 14:28:51 +0200
Message-ID: <1425644939-3232-17-git-send-email-t-kristo@ti.com>
References: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57396 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755235AbbCFM35 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 6 Mar 2015 07:29:57 -0500
In-Reply-To: <1425644939-3232-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

clkdm_control is used to determine, whether clocks should trigger a
clockdomain transition when they are enabled/disabled. Keep this
functionality intact, but replace this with a clk_features flag
which can be initialized during boot if needed.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clock.c |   34 ++++++++++------------------------
 arch/arm/mach-omap2/clock.h |    2 --
 include/linux/clk/ti.h      |    1 +
 3 files changed, 11 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 9f86e50..d9150f8 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -58,14 +58,6 @@ u16 cpu_mask;
 #define OMAP3PLUS_DPLL_FINT_MIN		32000
 #define OMAP3PLUS_DPLL_FINT_MAX		52000000
 
-/*
- * clkdm_control: if true, then when a clock is enabled in the
- * hardware, its clockdomain will first be enabled; and when a clock
- * is disabled in the hardware, its clockdomain will be disabled
- * afterwards.
- */
-static bool clkdm_control = true;
-
 void __iomem *clk_memmaps[CLK_MAX_MEMMAPS];
 
 void omap2_clk_writel(u32 val, struct clk_hw_omap *clk, void __iomem *reg)
@@ -202,19 +194,6 @@ void omap2_init_clk_clkdm(struct clk_hw *hw)
 }
 
 /**
- * omap2_clk_disable_clkdm_control - disable clkdm control on clk enable/disable
- *
- * Prevent the OMAP clock code from calling into the clockdomain code
- * when a hardware clock in that clockdomain is enabled or disabled.
- * Intended to be called at init time from omap*_clk_init().  No
- * return value.
- */
-void __init omap2_clk_disable_clkdm_control(void)
-{
-	clkdm_control = false;
-}
-
-/**
  * omap2_clk_dflt_find_companion - find companion clock to @clk
  * @clk: struct clk * to find the companion clock of
  * @other_reg: void __iomem ** to return the companion clock CM_*CLKEN va in
@@ -298,6 +277,12 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
 	struct clk_hw_omap *clk;
 	u32 v;
 	int ret = 0;
+	bool clkdm_control;
+
+	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL)
+		clkdm_control = false;
+	else
+		clkdm_control = true;
 
 	clk = to_clk_hw_omap(hw);
 
@@ -371,7 +356,8 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
 	omap2_clk_writel(v, clk, clk->enable_reg);
 	/* No OCP barrier needed here since it is a disable operation */
 
-	if (clkdm_control && clk->clkdm)
+	if (!(ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) &&
+	    clk->clkdm)
 		clkdm_clk_disable(clk->clkdm, hw->clk);
 }
 
@@ -404,7 +390,7 @@ int omap2_clkops_enable_clkdm(struct clk_hw *hw)
 		pr_err("%s: %s: should use dflt_clk_enable ?!\n", __func__,
 		       __clk_get_name(hw->clk));
 
-	if (!clkdm_control) {
+	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
 		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
 		       __func__, __clk_get_name(hw->clk));
 		return 0;
@@ -442,7 +428,7 @@ void omap2_clkops_disable_clkdm(struct clk_hw *hw)
 		pr_err("%s: %s: should use dflt_clk_disable ?!\n", __func__,
 		       __clk_get_name(hw->clk));
 
-	if (!clkdm_control) {
+	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
 		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
 		       __func__, __clk_get_name(hw->clk));
 		return;
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index c224719..f8282e8 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -180,8 +180,6 @@ struct clksel {
 #define OMAP4XXX_EN_DPLL_FRBYPASS		0x6
 #define OMAP4XXX_EN_DPLL_LOCKED			0x7
 
-void __init omap2_clk_disable_clkdm_control(void);
-
 void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
 			       const char *core_ck_name,
 			       const char *mpu_ck_name);
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index 653791e..78b776a 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -330,6 +330,7 @@ struct ti_clk_features {
 
 #define TI_CLK_DPLL_HAS_FREQSEL			BIT(0)
 #define TI_CLK_DPLL4_DENY_REPROGRAM		BIT(1)
+#define TI_CLK_DISABLE_CLKDM_CONTROL		BIT(2)
 
 void ti_clk_setup_features(struct ti_clk_features *features);
 struct ti_clk_features *ti_clk_get_features(void);
-- 
1.7.9.5

