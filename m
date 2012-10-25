From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/13] ARM: OMAP2xxx: clock: remove global 'dclk' variable
Date: Thu, 25 Oct 2012 17:21:15 -0600
Message-ID: <20121025232114.17558.43866.stgit@dusk.lan>
References: <20121025231818.17558.57884.stgit@dusk.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38280 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751106Ab2JYXYC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Oct 2012 19:24:02 -0400
In-Reply-To: <20121025231818.17558.57884.stgit@dusk.lan>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Remove the global 'dclk' variable, instead replacing it with a
variable local to the dpllcore clock type C file.  This removes some
of the special-case code surrounding the OMAP2xxx clock init.

This patch is a prerequisite for the removal of the
omap_prcm_restart() code from arch/arm/mach-omap2/prcm.c.  It also
cleans up some special-case OMAP2xxx clock code in the process.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   34 ++++++++++++++++++++++----
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |    2 +-
 arch/arm/mach-omap2/clock2420_data.c         |    4 ++-
 arch/arm/mach-omap2/clock2430_data.c         |    4 ++-
 arch/arm/mach-omap2/clock2xxx.c              |    2 +-
 arch/arm/mach-omap2/clock2xxx.h              |    5 ++--
 6 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 4ae4392..38a06d9 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -37,9 +37,15 @@
 
 /* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
 
+/*
+ * dpll_core_ck: pointer to the combined dpll_ck + core_ck on OMAP2xxx
+ * (currently defined as "dpll_ck" in the OMAP2xxx clock tree).  Set
+ * during dpll_ck init and used later by omap2xxx_clk_get_core_rate().
+ */
+static struct clk *dpll_core_ck;
+
 /**
  * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
- * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
  *
  * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
  * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
@@ -47,12 +53,14 @@
  * struct clk *dpll_ck, which is a composite clock of dpll_ck and
  * core_ck.
  */
-unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
+unsigned long omap2xxx_clk_get_core_rate(void)
 {
 	long long core_clk;
 	u32 v;
 
-	core_clk = omap2_get_dpll_rate(clk);
+	WARN_ON(!dpll_core_ck);
+
+	core_clk = omap2_get_dpll_rate(dpll_core_ck);
 
 	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	v &= OMAP24XX_CORE_CLK_SRC_MASK;
@@ -100,7 +108,7 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 
 unsigned long omap2_dpllcore_recalc(struct clk *clk)
 {
-	return omap2xxx_clk_get_core_rate(clk);
+	return omap2xxx_clk_get_core_rate();
 }
 
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
@@ -110,7 +118,7 @@ int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	struct prcm_config tmpset;
 	const struct dpll_data *dd;
 
-	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+	cur_rate = omap2xxx_clk_get_core_rate();
 	mult = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
@@ -171,3 +179,19 @@ int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	return 0;
 }
 
+/**
+ * omap2xxx_clkt_dpllcore_init - clk init function for dpll_ck
+ * @clk: struct clk *dpll_ck
+ *
+ * Store a local copy of @clk in dpll_core_ck so other code can query
+ * the core rate without having to clk_get(), which can sleep.  Must
+ * only be called once.  No return value.  XXX If the clock
+ * registration process is ever changed such that dpll_ck is no longer
+ * statically defined, this code may need to change to increment some
+ * kind of use count on dpll_ck.
+ */
+void omap2xxx_clkt_dpllcore_init(struct clk *clk)
+{
+	WARN(dpll_core_ck, "dpll_core_ck already set - should never happen");
+	dpll_core_ck = clk;
+}
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index 3524f0e..1b95078 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -119,7 +119,7 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	}
 
 	curr_prcm_set = prcm;
-	cur_rate = omap2xxx_clk_get_core_rate(dclk);
+	cur_rate = omap2xxx_clk_get_core_rate();
 
 	if (prcm->dpll_speed == cur_rate / 2) {
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
diff --git a/arch/arm/mach-omap2/clock2420_data.c b/arch/arm/mach-omap2/clock2420_data.c
index 969bc58..69335d3 100644
--- a/arch/arm/mach-omap2/clock2420_data.c
+++ b/arch/arm/mach-omap2/clock2420_data.c
@@ -126,6 +126,7 @@ static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.ops		= &clkops_omap2xxx_dpll_ops,
 	.parent		= &sys_ck,		/* Can be func_32k also */
+	.init		= &omap2xxx_clkt_dpllcore_init,
 	.dpll_data	= &dpll_dd,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_dpllcore_recalc,
@@ -1957,7 +1958,7 @@ int __init omap2420_clk_init(void)
 	omap_clk_disable_autoidle_all();
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
+	clkrate = omap2xxx_clk_get_core_rate();
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
@@ -1983,7 +1984,6 @@ int __init omap2420_clk_init(void)
 	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
 	vclk = clk_get(NULL, "virt_prcm_set");
 	sclk = clk_get(NULL, "sys_ck");
-	dclk = clk_get(NULL, "dpll_ck");
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clock2430_data.c b/arch/arm/mach-omap2/clock2430_data.c
index 186f06a..8d9894c 100644
--- a/arch/arm/mach-omap2/clock2430_data.c
+++ b/arch/arm/mach-omap2/clock2430_data.c
@@ -125,6 +125,7 @@ static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.ops		= &clkops_omap2xxx_dpll_ops,
 	.parent		= &sys_ck,		/* Can be func_32k also */
+	.init		= &omap2xxx_clkt_dpllcore_init,
 	.dpll_data	= &dpll_dd,
 	.clkdm_name	= "wkup_clkdm",
 	.recalc		= &omap2_dpllcore_recalc,
@@ -2056,7 +2057,7 @@ int __init omap2430_clk_init(void)
 	omap_clk_disable_autoidle_all();
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
+	clkrate = omap2xxx_clk_get_core_rate();
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
@@ -2082,7 +2083,6 @@ int __init omap2430_clk_init(void)
 	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
 	vclk = clk_get(NULL, "virt_prcm_set");
 	sclk = clk_get(NULL, "sys_ck");
-	dclk = clk_get(NULL, "dpll_ck");
 
 	return 0;
 }
diff --git a/arch/arm/mach-omap2/clock2xxx.c b/arch/arm/mach-omap2/clock2xxx.c
index e92be1fc..0e71fc2 100644
--- a/arch/arm/mach-omap2/clock2xxx.c
+++ b/arch/arm/mach-omap2/clock2xxx.c
@@ -30,7 +30,7 @@
 #include "cm.h"
 #include "cm-regbits-24xx.h"
 
-struct clk *vclk, *sclk, *dclk;
+struct clk *vclk, *sclk;
 
 /*
  * Omap24xx specific clock functions
diff --git a/arch/arm/mach-omap2/clock2xxx.h b/arch/arm/mach-omap2/clock2xxx.h
index cb6df8c..19dc0659 100644
--- a/arch/arm/mach-omap2/clock2xxx.h
+++ b/arch/arm/mach-omap2/clock2xxx.h
@@ -15,10 +15,11 @@ unsigned long omap2xxx_sys_clk_recalc(struct clk *clk);
 unsigned long omap2_osc_clk_recalc(struct clk *clk);
 unsigned long omap2_dpllcore_recalc(struct clk *clk);
 int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
-unsigned long omap2xxx_clk_get_core_rate(struct clk *clk);
+unsigned long omap2xxx_clk_get_core_rate(void);
 u32 omap2xxx_get_apll_clkin(void);
 u32 omap2xxx_get_sysclkdiv(void);
 void omap2xxx_clk_prepare_for_reboot(void);
+void omap2xxx_clkt_dpllcore_init(struct clk *clk);
 
 #ifdef CONFIG_SOC_OMAP2420
 int omap2420_clk_init(void);
@@ -34,8 +35,6 @@ int omap2430_clk_init(void);
 
 extern void __iomem *prcm_clksrc_ctrl, *cm_idlest_pll;
 
-extern struct clk *dclk;
-
 extern const struct clkops clkops_omap2430_i2chs_wait;
 extern const struct clkops clkops_oscck;
 extern const struct clkops clkops_apll96;


