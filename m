From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH] OMAP2/3 clock: fix DPLL rate calculation
Date: Mon, 1 Dec 2008 00:43:58 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0812010040460.31066@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45088 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbYLAHn7 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 1 Dec 2008 02:43:59 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tero.kristo@nokia.com, khilman@deeprootsystems.com, k.kooi@student.utwente.nl, peter.de-schrijver@nokia.com


From: Tero Kristo <tero.kristo@nokia.com>

Noncore dpll can enter autoidle state, in which case the rate calculation
fails.  Fixed by checking dpll mode instead of idle status.

Also, previously, the OMAP2xxx code returned the wrong value for the
DPLL rate under some conditions.  Move the CORE_CLK rate recalculation
to clock24xx.c:omap2xxx_clk_get_core_rate().

This patch is a collaboration between Tero Kristo <tero.kristo@nokia.com> 
and Paul Walmsley <paul@pwsan.com>.  Thanks to Peter de Schrijver 
<peter.de-schrijver@nokia.com> for help debugging and Kevin Hilman 
<khilman@deeprootsystems.com> for reporting the OMAP2 build problems with 
an earlier version of this patch.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Peter de Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/clock.c             |   21 +++++++----------
 arch/arm/mach-omap2/clock.h             |   15 ++++++++++++
 arch/arm/mach-omap2/clock24xx.c         |   39 +++++++++++++++++++++----------
 arch/arm/mach-omap2/clock24xx.h         |    4 ++-
 arch/arm/mach-omap2/clock34xx.c         |    7 +++---
 arch/arm/mach-omap2/sdrc2xxx.c          |    2 ++
 arch/arm/plat-omap/include/mach/clock.h |   13 +++-------
 7 files changed, 62 insertions(+), 39 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 42af286..e7fa9b0 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -71,10 +71,6 @@
 #define DPLL_FINT_UNDERFLOW		-1
 #define DPLL_FINT_INVALID		-2
 
-/* Some OMAP2xxx CM_CLKSEL_PLL.ST_CORE_CLK bits - for omap2_get_dpll_rate() */
-#define ST_CORE_CLK_REF			0x1
-#define ST_CORE_CLK_32K			0x3
-
 /* Bitmask to isolate the register type of clk.enable_reg */
 #define PRCM_REGTYPE_MASK		0xf0
 /* various CM register type options */
@@ -267,19 +263,20 @@ u32 omap2_get_dpll_rate(struct clk *clk)
 		return 0;
 
 	/* Return bypass rate if DPLL is bypassed */
-	v = cm_read_mod_reg(clk->prcm_mod, dd->idlest_reg);
-	v &= dd->idlest_mask;
-	v >>= __ffs(dd->idlest_mask);
+	v = cm_read_mod_reg(clk->prcm_mod, dd->control_reg);
+	v &= dd->enable_mask;
+	v >>= __ffs(dd->enable_mask);
+
 	if (cpu_is_omap24xx()) {
 
-		if (v == ST_CORE_CLK_REF)
-			return clk->parent->rate; /* sys_clk */
-		else if (v == ST_CORE_CLK_32K)
-			return 32768;
+		if (v == OMAP2XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP2XXX_EN_DPLL_FRBYPASS)
+			return clk->parent->rate;
 
 	} else if (cpu_is_omap34xx()) {
 
-		if (!v)
+		if (v == OMAP3XXX_EN_DPLL_LPBYPASS ||
+		    v == OMAP3XXX_EN_DPLL_FRBYPASS)
 			return dd->bypass_clk->rate;
 
 	}
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index bcb0c03..c95e48c 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -21,6 +21,21 @@
 /* The maximum error between a target DPLL rate and the rounded rate in Hz */
 #define DEFAULT_DPLL_RATE_TOLERANCE	50000
 
+/* CM_CLKSEL2_PLL.CORE_CLK_SRC bits (2XXX) */
+#define CORE_CLK_SRC_32K		0x0
+#define CORE_CLK_SRC_DPLL		0x1
+#define CORE_CLK_SRC_DPLL_X2		0x2
+
+/* OMAP2xxx CM_CLKEN_PLL.EN_DPLL bits - for omap2_get_dpll_rate() */
+#define OMAP2XXX_EN_DPLL_LPBYPASS		0x1
+#define OMAP2XXX_EN_DPLL_FRBYPASS		0x2
+#define OMAP2XXX_EN_DPLL_LOCKED			0x3
+
+/* OMAP3xxx CM_CLKEN_PLL*.EN_*_DPLL bits - for omap2_get_dpll_rate() */
+#define OMAP3XXX_EN_DPLL_LPBYPASS		0x5
+#define OMAP3XXX_EN_DPLL_FRBYPASS		0x6
+#define OMAP3XXX_EN_DPLL_LOCKED			0x7
+
 int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 32f6632..4bd21dd 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -60,19 +60,32 @@ static struct clk *sclk;
  * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
 
-/* This actually returns the rate of core_ck, not dpll_ck. */
-static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
+/**
+ * omap2xxx_clk_get_core_rate - return the CORE_CLK rate
+ * @clk: pointer to the combined dpll_ck + core_ck (currently "dpll_ck")
+ *
+ * Returns the CORE_CLK rate.  CORE_CLK can have one of three rate
+ * sources on OMAP2xxx: the DPLL CLKOUT rate, DPLL CLKOUTX2, or 32KHz
+ * (the latter is unusual).  This currently should be called with
+ * struct clk *dpll_ck, which is a composite clock of dpll_ck and
+ * core_ck.
+ */
+static u32 omap2xxx_clk_get_core_rate(struct clk *clk)
 {
-	long long dpll_clk;
-	u8 amult;
+	long long core_clk;
+	u32 v;
 
-	dpll_clk = omap2_get_dpll_rate(tclk);
+	core_clk = omap2_get_dpll_rate(clk);
 
-	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
-	dpll_clk *= amult;
+	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	v &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (v == CORE_CLK_SRC_32K)
+		core_clk = 32768;
+	else
+		core_clk *= v;
 
-	return dpll_clk;
+	return core_clk;
 }
 
 static int omap2_enable_osc_ck(struct clk *clk)
@@ -164,7 +177,7 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 
 static void omap2_dpllcore_recalc(struct clk *clk)
 {
-	clk->rate = omap2_get_dpll_rate_24xx(clk);
+	clk->rate = omap2xxx_clk_get_core_rate(clk);
 
 	propagate_rate(clk);
 }
@@ -179,7 +192,7 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	int ret = -EINVAL;
 
 	local_irq_save(flags);
-	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck);
 	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
@@ -319,7 +332,7 @@ static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 	}
 
 	curr_prcm_set = prcm;
-	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	cur_rate = omap2xxx_clk_get_core_rate(&dpll_ck);
 
 	if (prcm->dpll_speed == cur_rate / 2) {
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
@@ -535,7 +548,7 @@ int __init omap2_clk_init(void)
 	}
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	clkrate = omap2xxx_clk_get_core_rate(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 724bcb0..929a257 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -673,8 +673,8 @@ static struct dpll_data dpll_dd = {
 	.mult_div1_reg		= CM_CLKSEL1,
 	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
 	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
-	.idlest_reg		= CM_IDLEST,
-	.idlest_mask		= OMAP24XX_ST_CORE_CLK_MASK,
+	.control_reg		= CM_CLKEN,
+	.enable_mask		= OMAP24XX_EN_DPLL_MASK,
 	.max_multiplier		= 1024,
 	.min_divider		= 1,
 	.max_divider		= 16,
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index b8b4494..6c41112 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -604,10 +604,11 @@ static void omap3_clkoutx2_recalc(struct clk *clk)
 
 	dd = pclk->dpll_data;
 
-	WARN_ON(!dd->idlest_reg || !dd->idlest_mask);
+	WARN_ON(!dd->enable_mask);
 
-	v = cm_read_mod_reg(pclk->prcm_mod, dd->idlest_reg) & dd->idlest_mask;
-	if (!v)
+	v = cm_read_mod_reg(pclk->prcm_mod, dd->control_reg) & dd->enable_mask;
+	v >>= __ffs(dd->enable_mask);
+	if (v != OMAP3XXX_EN_DPLL_LOCKED)
 		clk->rate = clk->parent->rate;
 	else
 		clk->rate = clk->parent->rate * 2;
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 0723e59..479dc8c 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -28,6 +28,8 @@
 #include <mach/clock.h>
 #include <mach/sram.h>
 
+#include "clock.h"
+
 #include "prm.h"
 
 #include <mach/sdrc.h>
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 4eef580..e793616 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -42,14 +42,14 @@ struct dpll_data {
 	u8			min_divider;
 	u8			max_divider;
 	u32			max_tolerance;
-	u16			idlest_reg;
-	u32			idlest_mask;
 	struct clk		*bypass_clk;
+	u16			control_reg;
+	u32			enable_mask;
 #  if defined(CONFIG_ARCH_OMAP3)
+	u16			idlest_reg;
+	u32			idlest_mask;
 	u32			freqsel_mask;
 	u8			modes;
-	u16			control_reg;
-	u32			enable_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
 	u8			recal_st_bit;
@@ -175,9 +175,4 @@ extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #define CLK_REG_IN_PRM		(1 << 0)
 #define CLK_REG_IN_SCM		(1 << 1)
 
-/* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
-#define CORE_CLK_SRC_32K		0
-#define CORE_CLK_SRC_DPLL		1
-#define CORE_CLK_SRC_DPLL_X2		2
-
 #endif
