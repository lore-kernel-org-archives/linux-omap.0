From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/12] ARM: OMAP2: Change 24xx to use shared clock code and new
	reg access
Date: Tue, 18 Mar 2008 12:39:56 +0200
Message-ID: <1205836800-31737-9-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-123926
	<1205836800-31737-1-git-send-email-tony@atomide.com>
	<1205836800-31737-2-git-send-email-tony@atomide.com>
	<1205836800-31737-3-git-send-email-tony@atomide.com>
	<1205836800-31737-4-git-send-email-tony@atomide.com>
	<1205836800-31737-5-git-send-email-tony@atomide.com>
	<1205836800-31737-6-git-send-email-tony@atomide.com>
	<1205836800-31737-7-git-send-email-tony@atomide.com>
	<1205836800-31737-8-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205836800-31737-8-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

This patch changes 24xx to use shared clock code and new register
access.

Note that patch adds some temporary OLD_CK defines to keep patch
more readable. These temporary defines will be removed in the next
patch.

Also, the patch fixes few incorrect clock defines in clock24xx.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/clock24xx.c   |  318 +++++---
 arch/arm/mach-omap2/clock24xx.h   | 1745 ++++++++++++++++++++++++-------------
 arch/arm/mach-omap2/memory.c      |   48 +
 arch/arm/mach-omap2/memory.h      |    2 +
 arch/arm/plat-omap/clock.c        |   42 +
 include/asm-arm/arch-omap/clock.h |   65 ++-
 7 files changed, 1486 insertions(+), 736 deletions(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index be2b671..a3b2507 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -3,7 +3,7 @@
 #
 
 # Common support
-obj-y := irq.o id.o io.o sram-fn.o memory.o control.o prcm.o mux.o \
+obj-y := irq.o id.o io.o sram-fn.o memory.o control.o prcm.o clock.o mux.o \
 		devices.o serial.o gpmc.o timer-gp.o
 
 # Power Management
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 5c24781..f2b12b6 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -15,6 +15,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
+#undef DEBUG
+
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
@@ -23,29 +25,63 @@
 #include <linux/delay.h>
 #include <linux/clk.h>
 
-#include <asm/io.h>
+#include <linux/io.h>
+#include <linux/cpufreq.h>
 
 #include <asm/arch/clock.h>
 #include <asm/arch/sram.h>
 #include <asm/div64.h>
 
-#include "prcm-regs.h"
 #include "memory.h"
+#include "clock.h"
 #include "clock24xx.h"
+#include "prm.h"
+#include "prm-regbits-24xx.h"
+#include "cm.h"
+#include "cm-regbits-24xx.h"
 
-#undef DEBUG
+/* CM_CLKEN_PLL.EN_{54,96}M_PLL options (24XX) */
+#define EN_APLL_STOPPED			0
+#define EN_APLL_LOCKED			3
 
-//#define DOWN_VARIABLE_DPLL 1			/* Experimental */
+/* CM_CLKSEL1_PLL.APLLS_CLKIN options (24XX) */
+#define APLLS_CLKIN_19_2MHZ		0
+#define APLLS_CLKIN_13MHZ		2
+#define APLLS_CLKIN_12MHZ		3
+
+/* #define DOWN_VARIABLE_DPLL 1 */		/* Experimental */
 
 static struct prcm_config *curr_prcm_set;
-static u32 curr_perf_level = PRCM_FULL_SPEED;
 static struct clk *vclk;
 static struct clk *sclk;
 
 /*-------------------------------------------------------------------------
- * Omap2 specific clock functions
+ * Omap24xx specific clock functions
  *-------------------------------------------------------------------------*/
 
+static int omap2_enable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+
+	prm_write_reg(pcc & ~OMAP_AUTOEXTCLKMODE_MASK,
+		      OMAP24XX_PRCM_CLKSRC_CTRL);
+
+	return 0;
+}
+
+static void omap2_disable_osc_ck(struct clk *clk)
+{
+	u32 pcc;
+
+	pcc = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+
+	prm_write_reg(pcc | OMAP_AUTOEXTCLKMODE_MASK,
+		      OMAP24XX_PRCM_CLKSRC_CTRL);
+}
+
+#ifdef OLD_CK
 /* Recalculate SYST_CLK */
 static void omap2_sys_clk_recalc(struct clk * clk)
 {
@@ -55,17 +91,18 @@ static void omap2_sys_clk_recalc(struct clk * clk)
 	clk->rate = (clk->parent->rate / div);
 	propagate_rate(clk);
 }
+#endif	/* OLD_CK */
 
-static u32 omap2_get_dpll_rate(struct clk * tclk)
+/* This actually returns the rate of core_ck, not dpll_ck. */
+static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
 {
 	long long dpll_clk;
-	int dpll_mult, dpll_div, amult;
+	u8 amult;
+
+	dpll_clk = omap2_get_dpll_rate(tclk);
 
-	dpll_mult = (CM_CLKSEL1_PLL >> 12) & 0x03ff;	/* 10 bits */
-	dpll_div = (CM_CLKSEL1_PLL >> 8) & 0x0f;	/* 4 bits */
-	dpll_clk = (long long)tclk->parent->rate * dpll_mult;
-	do_div(dpll_clk, dpll_div + 1);
-	amult = CM_CLKSEL2_PLL & 0x3;
+	amult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	amult &= OMAP24XX_CORE_CLK_SRC_MASK;
 	dpll_clk *= amult;
 
 	return dpll_clk;
@@ -84,6 +121,7 @@ static void omap2_propagate_rate(struct clk * clk)
 	propagate_rate(clk);
 }
 
+#ifdef OLD_CK
 static void omap2_set_osc_ck(int enable)
 {
 	if (enable)
@@ -91,39 +129,40 @@ static void omap2_set_osc_ck(int enable)
 	else
 		PRCM_CLKSRC_CTRL |= 0x3 << 3;
 }
+#endif	/* OLD_CK */
 
 /* Enable an APLL if off */
-static void omap2_clk_fixed_enable(struct clk *clk)
+static int omap2_clk_fixed_enable(struct clk *clk)
 {
-	u32 cval, i=0;
+	u32 cval, apll_mask;
 
-	if (clk->enable_bit == 0xff)			/* Parent will do it */
-		return;
+	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
 
-	cval = CM_CLKEN_PLL;
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
-	if ((cval & (0x3 << clk->enable_bit)) == (0x3 << clk->enable_bit))
-		return;
+	if ((cval & apll_mask) == apll_mask)
+		return 0;   /* apll already enabled */
 
-	cval &= ~(0x3 << clk->enable_bit);
-	cval |= (0x3 << clk->enable_bit);
-	CM_CLKEN_PLL = cval;
+	cval &= ~apll_mask;
+	cval |= apll_mask;
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	if (clk == &apll96_ck)
-		cval = (1 << 8);
+		cval = OMAP24XX_ST_96M_APLL;
 	else if (clk == &apll54_ck)
-		cval = (1 << 6);
+		cval = OMAP24XX_ST_54M_APLL;
 
-	while (!(CM_IDLEST_CKGEN & cval)) {		/* Wait for lock */
-		++i;
-		udelay(1);
-		if (i == 100000) {
-			printk(KERN_ERR "Clock %s didn't lock\n", clk->name);
-			break;
-		}
-	}
+	omap2_wait_clock_ready(OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST), cval,
+			    clk->name);
+
+	/*
+	 * REVISIT: Should we return an error code if omap2_wait_clock_ready()
+	 * fails?
+	 */
+	return 0;
 }
 
+#ifdef OLD_CK
 static void omap2_clk_wait_ready(struct clk *clk)
 {
 	unsigned long reg, other_reg, st_reg;
@@ -199,20 +238,19 @@ static int _omap2_clk_enable(struct clk * clk)
 
 	return 0;
 }
+#endif	/* OLD_CK */
 
 /* Stop APLL */
 static void omap2_clk_fixed_disable(struct clk *clk)
 {
 	u32 cval;
 
-	if(clk->enable_bit == 0xff)		/* let parent off do it */
-		return;
-
-	cval = CM_CLKEN_PLL;
-	cval &= ~(0x3 << clk->enable_bit);
-	CM_CLKEN_PLL = cval;
+	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
+	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
+#ifdef OLD_CK
 /* Disables clock without considering parent dependencies or use count */
 static void _omap2_clk_disable(struct clk *clk)
 {
@@ -269,6 +307,7 @@ static void omap2_clk_disable(struct clk *clk)
 			omap2_clk_disable(clk->parent);
 	}
 }
+#endif	/* OLD_CK */
 
 /*
  * Uses the current prcm set to tell if a rate is valid.
@@ -276,9 +315,12 @@ static void omap2_clk_disable(struct clk *clk)
  */
 static u32 omap2_dpll_round_rate(unsigned long target_rate)
 {
-	u32 high, low;
+	u32 high, low, core_clk_src;
 
-	if ((CM_CLKSEL2_PLL & 0x3) == 1) {	/* DPLL clockout */
+	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
 		high = curr_prcm_set->dpll_speed * 2;
 		low = curr_prcm_set->dpll_speed;
 	} else {				/* DPLL clockout x 2 */
@@ -300,6 +342,7 @@ static u32 omap2_dpll_round_rate(unsigned long target_rate)
 
 }
 
+#ifdef OLD_CK
 /*
  * Used for clocks that are part of CLKSEL_xyz governed clocks.
  * REVISIT: Maybe change to use clk->enable() functions like on omap1?
@@ -486,55 +529,72 @@ static u32 omap2_reprogram_sdrc(u32 level, u32 force)
 
 	return prev;
 }
+#endif	/* OLD_CK */
+
+static void omap2_dpll_recalc(struct clk *clk)
+{
+	clk->rate = omap2_get_dpll_rate_24xx(clk);
+
+	propagate_rate(clk);
+}
 
-static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
+static int omap2_reprogram_dpll(struct clk *clk, unsigned long rate)
 {
-	u32 flags, cur_rate, low, mult, div, valid_rate, done_rate;
+	u32 cur_rate, low, mult, div, valid_rate, done_rate;
 	u32 bypass = 0;
 	struct prcm_config tmpset;
+	const struct dpll_data *dd;
+	unsigned long flags;
 	int ret = -EINVAL;
 
 	local_irq_save(flags);
-	cur_rate = omap2_get_dpll_rate(&dpll_ck);
-	mult = CM_CLKSEL2_PLL & 0x3;
+	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
+	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if ((rate == (cur_rate / 2)) && (mult == 2)) {
-		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
 	} else if ((rate == (cur_rate * 2)) && (mult == 1)) {
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (rate != cur_rate) {
 		valid_rate = omap2_dpll_round_rate(rate);
 		if (valid_rate != rate)
 			goto dpll_exit;
 
-		if ((CM_CLKSEL2_PLL & 0x3) == 1)
+		if (mult == 1)
 			low = curr_prcm_set->dpll_speed;
 		else
 			low = curr_prcm_set->dpll_speed / 2;
 
-		tmpset.cm_clksel1_pll = CM_CLKSEL1_PLL;
-		tmpset.cm_clksel1_pll &= ~(0x3FFF << 8);
+		dd = clk->dpll_data;
+		if (!dd)
+			goto dpll_exit;
+
+		tmpset.cm_clksel1_pll = cm_read_reg(dd->mult_div1_reg);
+		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
+					   dd->div1_mask);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = CM_CLKSEL2_PLL;
-		tmpset.cm_clksel2_pll &= ~0x3;
+		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
 		if (rate > low) {
-			tmpset.cm_clksel2_pll |= 0x2;
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
 			mult = ((rate / 2) / 1000000);
-			done_rate = PRCM_FULL_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL_X2;
 		} else {
-			tmpset.cm_clksel2_pll |= 0x1;
+			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL;
 			mult = (rate / 1000000);
-			done_rate = PRCM_HALF_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL;
 		}
-		tmpset.cm_clksel1_pll |= ((div << 8) | (mult << 12));
+		tmpset.cm_clksel1_pll |= (div << mask_to_shift(dd->mult_mask));
+		tmpset.cm_clksel1_pll |= (mult << mask_to_shift(dd->div1_mask));
 
 		/* Worst case */
-		tmpset.base_sdrc_rfr = V24XX_SDRC_RFR_CTRL_BYPASS;
+		tmpset.base_sdrc_rfr = SDRC_RFR_CTRL_BYPASS;
 
 		if (rate == curr_prcm_set->xtal_speed)	/* If asking for 1-1 */
 			bypass = 1;
 
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1); /* For init_mem */
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1); /* For init_mem */
 
 		/* Force dll lock mode */
 		omap2_set_prcm(tmpset.cm_clksel1_pll, tmpset.base_sdrc_rfr,
@@ -544,7 +604,7 @@ static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate)
 		omap2_init_memory_params(omap2_dll_force_needed());
 		omap2_reprogram_sdrc(done_rate, 0);
 	}
-	omap2_clksel_recalc(&dpll_ck);
+	omap2_dpll_recalc(&dpll_ck);
 	ret = 0;
 
 dpll_exit:
@@ -552,8 +612,13 @@ dpll_exit:
 	return(ret);
 }
 
-/* Just return the MPU speed */
-static void omap2_mpu_recalc(struct clk * clk)
+/**
+ * omap2_table_mpu_recalc - just return the MPU speed
+ * @clk: virt_prcm_set struct clk
+ *
+ * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
+ */
+static void omap2_table_mpu_recalc(struct clk *clk)
 {
 	clk->rate = curr_prcm_set->mpu_speed;
 }
@@ -565,9 +630,9 @@ static void omap2_mpu_recalc(struct clk * clk)
  * Some might argue L3-DDR, others ARM, others IVA. This code is simple and
  * just uses the ARM rates.
  */
-static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate)
+static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate)
 {
-	struct prcm_config * ptr;
+	struct prcm_config *ptr;
 	long highest_rate;
 
 	if (clk != &virt_prcm_set)
@@ -576,6 +641,8 @@ static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate)
 	highest_rate = -EINVAL;
 
 	for (ptr = rate_table; ptr->mpu_speed; ptr++) {
+		if (!(ptr->flags & cpu_mask))
+			continue;
 		if (ptr->xtal_speed != sys_ck.rate)
 			continue;
 
@@ -588,6 +655,7 @@ static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate)
 	return highest_rate;
 }
 
+#ifdef OLD_CK
 /*
  * omap2_convert_field_to_div() - turn field value into integer divider
  */
@@ -938,24 +1006,19 @@ static int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
  set_parent_error:
 	return ret;
 }
+#endif	/* OLD_CK */
 
 /* Sets basic clocks based on the specified rate */
-static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
+static int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 {
-	u32 flags, cur_rate, done_rate, bypass = 0;
-	u8 cpu_mask = 0;
+	u32 cur_rate, done_rate, bypass = 0, tmp;
 	struct prcm_config *prcm;
 	unsigned long found_speed = 0;
+	unsigned long flags;
 
 	if (clk != &virt_prcm_set)
 		return -EINVAL;
 
-	/* FIXME: Change cpu_is_omap2420() to cpu_is_omap242x() */
-	if (cpu_is_omap2420())
-		cpu_mask = RATE_IN_242X;
-	else if (cpu_is_omap2430())
-		cpu_mask = RATE_IN_243X;
-
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
 		if (!(prcm->flags & cpu_mask))
 			continue;
@@ -976,38 +1039,42 @@ static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
 	}
 
 	curr_prcm_set = prcm;
-	cur_rate = omap2_get_dpll_rate(&dpll_ck);
+	cur_rate = omap2_get_dpll_rate_24xx(&dpll_ck);
 
 	if (prcm->dpll_speed == cur_rate / 2) {
-		omap2_reprogram_sdrc(PRCM_HALF_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL, 1);
 	} else if (prcm->dpll_speed == cur_rate * 2) {
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 	} else if (prcm->dpll_speed != cur_rate) {
 		local_irq_save(flags);
 
 		if (prcm->dpll_speed == prcm->xtal_speed)
 			bypass = 1;
 
-		if ((prcm->cm_clksel2_pll & 0x3) == 2)
-			done_rate = PRCM_FULL_SPEED;
+		if ((prcm->cm_clksel2_pll & OMAP24XX_CORE_CLK_SRC_MASK) ==
+		    CORE_CLK_SRC_DPLL_X2)
+			done_rate = CORE_CLK_SRC_DPLL_X2;
 		else
-			done_rate = PRCM_HALF_SPEED;
+			done_rate = CORE_CLK_SRC_DPLL;
 
 		/* MPU divider */
-		CM_CLKSEL_MPU = prcm->cm_clksel_mpu;
+		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
 
 		/* dsp + iva1 div(2420), iva2.1(2430) */
-		CM_CLKSEL_DSP = prcm->cm_clksel_dsp;
+		cm_write_mod_reg(prcm->cm_clksel_dsp,
+				 OMAP24XX_DSP_MOD, CM_CLKSEL);
 
-		CM_CLKSEL_GFX = prcm->cm_clksel_gfx;
+		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
 
 		/* Major subsystem dividers */
-		CM_CLKSEL1_CORE = prcm->cm_clksel1_core;
+		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
+		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD, CM_CLKSEL1);
 		if (cpu_is_omap2430())
-			CM_CLKSEL_MDM = prcm->cm_clksel_mdm;
+			cm_write_mod_reg(prcm->cm_clksel_mdm,
+					 OMAP2430_MDM_MOD, CM_CLKSEL);
 
 		/* x2 to enter init_mem */
-		omap2_reprogram_sdrc(PRCM_FULL_SPEED, 1);
+		omap2_reprogram_sdrc(CORE_CLK_SRC_DPLL_X2, 1);
 
 		omap2_set_prcm(prcm->cm_clksel1_pll, prcm->base_sdrc_rfr,
 			       bypass);
@@ -1017,7 +1084,7 @@ static int omap2_select_table_rate(struct clk * clk, unsigned long rate)
 
 		local_irq_restore(flags);
 	}
-	omap2_clksel_recalc(&dpll_ck);
+	omap2_dpll_recalc(&dpll_ck);
 
 	return 0;
 }
@@ -1051,27 +1118,45 @@ static struct clk_functions omap2_clk_functions = {
 	.clk_disable_unused	= omap2_clk_disable_unused,
 };
 
-static void __init omap2_get_crystal_rate(struct clk *osc, struct clk *sys)
+static u32 omap2_get_apll_clkin(void)
 {
-	u32 div, aplls, sclk = 13000000;
+	u32 aplls, sclk = 0;
 
-	aplls = CM_CLKSEL1_PLL;
-	aplls &= ((1 << 23) | (1 << 24) | (1 << 25));
-	aplls >>= 23;			/* Isolate field, 0,2,3 */
+	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
+	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
 
-	if (aplls == 0)
+	if (aplls == APLLS_CLKIN_19_2MHZ)
 		sclk = 19200000;
-	else if (aplls == 2)
+	else if (aplls == APLLS_CLKIN_13MHZ)
 		sclk = 13000000;
-	else if (aplls == 3)
+	else if (aplls == APLLS_CLKIN_12MHZ)
 		sclk = 12000000;
 
-	div = PRCM_CLKSRC_CTRL;
-	div &= ((1 << 7) | (1 << 6));
-	div >>= sys->rate_offset;
+	return sclk;
+}
+
+static u32 omap2_get_sysclkdiv(void)
+{
+	u32 div;
+
+	div = prm_read_reg(OMAP24XX_PRCM_CLKSRC_CTRL);
+	div &= OMAP_SYSCLKDIV_MASK;
+	div >>= OMAP_SYSCLKDIV_SHIFT;
 
-	osc->rate = sclk * div;
-	sys->rate = sclk;
+	return div;
+}
+
+static void omap2_osc_clk_recalc(struct clk *clk)
+{
+	clk->rate = omap2_get_apll_clkin() * omap2_get_sysclkdiv();
+	propagate_rate(clk);
+}
+
+static void omap2_sys_clk_recalc(struct clk *clk)
+{
+	clk->rate = clk->parent->rate / omap2_get_sysclkdiv();
+	propagate_rate(clk);
 }
 
 /*
@@ -1100,8 +1185,7 @@ static int __init omap2_clk_arch_init(void)
 	if (omap2_select_table_rate(&virt_prcm_set, mpurate))
 		printk(KERN_ERR "Could not find matching MPU rate\n");
 
-	propagate_rate(&osc_ck);		/* update main root fast */
-	propagate_rate(&func_32k_ck);		/* update main root slow */
+	recalculate_root_clocks();
 
 	printk(KERN_INFO "Switched to new clocking rate (Crystal/DPLL/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
@@ -1115,13 +1199,21 @@ arch_initcall(omap2_clk_arch_init);
 int __init omap2_clk_init(void)
 {
 	struct prcm_config *prcm;
-	struct clk ** clkp;
+	struct clk **clkp;
 	u32 clkrate;
 
+	if (cpu_is_omap242x())
+		cpu_mask = RATE_IN_242X;
+	else if (cpu_is_omap2430())
+		cpu_mask = RATE_IN_243X;
+
 	clk_init(&omap2_clk_functions);
-	omap2_get_crystal_rate(&osc_ck, &sys_ck);
 
-	for (clkp = onchip_clks; clkp < onchip_clks + ARRAY_SIZE(onchip_clks);
+	omap2_osc_clk_recalc(&osc_ck);
+	omap2_sys_clk_recalc(&sys_ck);
+
+	for (clkp = onchip_24xx_clks;
+	     clkp < onchip_24xx_clks + ARRAY_SIZE(onchip_24xx_clks);
 	     clkp++) {
 
 		if ((*clkp)->flags & CLOCK_IN_OMAP242X && cpu_is_omap2420()) {
@@ -1136,8 +1228,10 @@ int __init omap2_clk_init(void)
 	}
 
 	/* Check the MPU rate set by bootloader */
-	clkrate = omap2_get_dpll_rate(&dpll_ck);
+	clkrate = omap2_get_dpll_rate_24xx(&dpll_ck);
 	for (prcm = rate_table; prcm->mpu_speed; prcm++) {
+		if (!(prcm->flags & cpu_mask))
+			continue;
 		if (prcm->xtal_speed != sys_ck.rate)
 			continue;
 		if (prcm->dpll_speed <= clkrate)
@@ -1145,8 +1239,7 @@ int __init omap2_clk_init(void)
 	}
 	curr_prcm_set = prcm;
 
-	propagate_rate(&osc_ck);		/* update main root fast */
-	propagate_rate(&func_32k_ck);		/* update main root slow */
+	recalculate_root_clocks();
 
 	printk(KERN_INFO "Clocking rate (Crystal/DPLL/MPU): "
 	       "%ld.%01ld/%ld/%ld MHz\n",
@@ -1157,16 +1250,7 @@ int __init omap2_clk_init(void)
 	 * Only enable those clocks we will need, let the drivers
 	 * enable other clocks as necessary
 	 */
-	clk_enable(&sync_32k_ick);
-	clk_enable(&omapctrl_ick);
-
-	/* Force the APLLs always active. The clocks are idled
-	 * automatically by hardware. */
-	clk_enable(&apll96_ck);
-	clk_enable(&apll54_ck);
-
-	if (cpu_is_omap2430())
-		clk_enable(&sdrc_ick);
+	clk_enable_init_clocks();
 
 	/* Avoid sleeping sleeping during omap2_clk_prepare_for_reboot() */
 	vclk = clk_get(NULL, "virt_prcm_set");
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 4f79186..559eade 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -14,24 +14,29 @@
  * published by the Free Software Foundation.
  */
 
-#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK_H
-#define __ARCH_ARM_MACH_OMAP2_CLOCK_H
+#ifndef __ARCH_ARM_MACH_OMAP2_CLOCK24XX_H
+#define __ARCH_ARM_MACH_OMAP2_CLOCK24XX_H
 
-static void omap2_sys_clk_recalc(struct clk * clk);
-static void omap2_clksel_recalc(struct clk * clk);
-static void omap2_followparent_recalc(struct clk * clk);
-static void omap2_propagate_rate(struct clk * clk);
-static void omap2_mpu_recalc(struct clk * clk);
+#include "clock.h"
+
+#include "prm.h"
+#include "cm.h"
+#include "prm-regbits-24xx.h"
+#include "cm-regbits-24xx.h"
+#include "sdrc.h"
+
+static void omap2_table_mpu_recalc(struct clk * clk);
 static int omap2_select_table_rate(struct clk * clk, unsigned long rate);
 static long omap2_round_to_table_rate(struct clk * clk, unsigned long rate);
-static void omap2_clk_disable(struct clk *clk);
 static void omap2_sys_clk_recalc(struct clk * clk);
-static u32 omap2_clksel_to_divisor(u32 div_sel, u32 field_val);
-static u32 omap2_clksel_get_divisor(struct clk *clk);
-
-
-#define RATE_IN_242X	(1 << 0)
-#define RATE_IN_243X	(1 << 1)
+static void omap2_osc_clk_recalc(struct clk * clk);
+static void omap2_sys_clk_recalc(struct clk * clk);
+static void omap2_dpll_recalc(struct clk * clk);
+static int omap2_clk_fixed_enable(struct clk * clk);
+static void omap2_clk_fixed_disable(struct clk * clk);
+static int omap2_enable_osc_ck(struct clk * clk);
+static void omap2_disable_osc_ck(struct clk * clk);
+static int omap2_reprogram_dpll(struct clk * clk, unsigned long rate);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
  * xtal_speed, dpll_speed, mpu_speed, CM_CLKSEL_MPU,CM_CLKSEL_DSP
@@ -52,16 +57,6 @@ struct prcm_config {
 	unsigned char flags;
 };
 
-/* Mask for clksel which support parent settign in set_rate */
-#define SRC_SEL_MASK (CM_CORE_SEL1 | CM_CORE_SEL2 | CM_WKUP_SEL1 | \
-			CM_PLL_SEL1 | CM_PLL_SEL2 | CM_SYSCLKOUT_SEL1)
-
-/* Mask for clksel regs which support rate operations */
-#define SRC_RATE_SEL_MASK (CM_MPU_SEL1 | CM_DSP_SEL1 | CM_GFX_SEL1 | \
-			CM_MODEM_SEL1 | CM_CORE_SEL1 | CM_CORE_SEL2 | \
-			CM_WKUP_SEL1 | CM_PLL_SEL1 | CM_PLL_SEL2 | \
-			CM_SYSCLKOUT_SEL1)
-
 /*
  * The OMAP2 processor can be run at several discrete 'PRCM configurations'.
  * These configurations are characterized by voltage and speed for clocks.
@@ -174,7 +169,7 @@ struct prcm_config {
 #define RII_CLKSEL_DSP			(3 << 0)	/* c5x - 200MHz */
 #define RII_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 100MHz */
 #define RII_SYNC_DSP			(0 << 7)	/* Bypass sync */
-#define RII_CLKSEL_IVA			(6 << 8)	/* iva1 - 200MHz */
+#define RII_CLKSEL_IVA			(3 << 8)	/* iva1 - 200MHz */
 #define RII_SYNC_IVA			(0 << 13)	/* Bypass sync */
 #define RII_CM_CLKSEL_DSP_VAL		RII_SYNC_IVA | RII_CLKSEL_IVA | \
 					RII_SYNC_DSP | RII_CLKSEL_DSP_IF | \
@@ -182,6 +177,27 @@ struct prcm_config {
 #define RII_CLKSEL_GFX			(2 << 0)	/* 50MHz */
 #define RII_CM_CLKSEL_GFX_VAL		RII_CLKSEL_GFX
 
+/* 2420-PRCM I 660MHz core */
+#define RI_CLKSEL_L3			(4 << 0)	/* 165MHz */
+#define RI_CLKSEL_L4			(2 << 5)	/* 82.5MHz */
+#define RI_CLKSEL_USB			(4 << 25)	/* 41.25MHz */
+#define RI_CM_CLKSEL1_CORE_VAL		RI_CLKSEL_USB | \
+					RXX_CLKSEL_SSI | RXX_CLKSEL_VLYNQ | \
+					RX_CLKSEL_DSS2 | RX_CLKSEL_DSS1 | \
+					RI_CLKSEL_L4 | RI_CLKSEL_L3
+#define RI_CLKSEL_MPU			(2 << 0)	/* 330MHz */
+#define RI_CM_CLKSEL_MPU_VAL		RI_CLKSEL_MPU
+#define RI_CLKSEL_DSP			(3 << 0)	/* c5x - 220MHz */
+#define RI_CLKSEL_DSP_IF		(2 << 5)	/* c5x - 110MHz */
+#define RI_SYNC_DSP			(1 << 7)	/* Activate sync */
+#define RI_CLKSEL_IVA			(4 << 8)	/* iva1 - 165MHz */
+#define RI_SYNC_IVA			(0 << 13)	/* Bypass sync */
+#define RI_CM_CLKSEL_DSP_VAL		RI_SYNC_IVA | RI_CLKSEL_IVA | \
+					RI_SYNC_DSP | RI_CLKSEL_DSP_IF | \
+					RI_CLKSEL_DSP
+#define RI_CLKSEL_GFX			(1 << 0)	/* 165MHz */
+#define RI_CM_CLKSEL_GFX_VAL		RI_CLKSEL_GFX
+
 /* 2420-PRCM VII (boot) */
 #define RVII_CLKSEL_L3			(1 << 0)
 #define RVII_CLKSEL_L4			(1 << 5)
@@ -224,7 +240,6 @@ struct prcm_config {
 
 /*
  * 2430 - standalone, 2*ref*M/(n+1), M/N is for exactness not relock speed
- * #2	(ratio1) baseport-target
  * #5a	(ratio1) baseport-target, target DPLL = 266*2 = 532MHz
  */
 #define M5A_DPLL_MULT_12		(133 << 12)
@@ -232,13 +247,13 @@ struct prcm_config {
 #define M5A_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M5A_DPLL_DIV_12 | M5A_DPLL_MULT_12 | \
 					MX_APLLS_CLIKIN_12
-#define M5A_DPLL_MULT_13		(266 << 12)
-#define M5A_DPLL_DIV_13			(12 << 8)
+#define M5A_DPLL_MULT_13		(61 << 12)
+#define M5A_DPLL_DIV_13			(2 << 8)
 #define M5A_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M5A_DPLL_DIV_13 | M5A_DPLL_MULT_13 | \
 					MX_APLLS_CLIKIN_13
-#define M5A_DPLL_MULT_19		(180 << 12)
-#define M5A_DPLL_DIV_19			(12 << 8)
+#define M5A_DPLL_MULT_19		(55 << 12)
+#define M5A_DPLL_DIV_19			(3 << 8)
 #define M5A_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M5A_DPLL_DIV_19 | M5A_DPLL_MULT_19 | \
 					MX_APLLS_CLIKIN_19_2
@@ -260,7 +275,27 @@ struct prcm_config {
 					M5B_DPLL_DIV_19 | M5B_DPLL_MULT_19 | \
 					MX_APLLS_CLIKIN_19_2
 /*
- * #4	(ratio2)
+ * #4	(ratio2), DPLL = 399*2 = 798MHz, L3=133MHz
+ */
+#define M4_DPLL_MULT_12			(133 << 12)
+#define M4_DPLL_DIV_12			(3 << 8)
+#define M4_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M4_DPLL_DIV_12 | M4_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+
+#define M4_DPLL_MULT_13			(399 << 12)
+#define M4_DPLL_DIV_13			(12 << 8)
+#define M4_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M4_DPLL_DIV_13 | M4_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+
+#define M4_DPLL_MULT_19			(145 << 12)
+#define M4_DPLL_DIV_19			(6 << 8)
+#define M4_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M4_DPLL_DIV_19 | M4_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+
+/*
  * #3	(ratio2) baseport-target, target DPLL = 330*2 = 660MHz
  */
 #define M3_DPLL_MULT_12			(55 << 12)
@@ -268,16 +303,41 @@ struct prcm_config {
 #define M3_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M3_DPLL_DIV_12 | M3_DPLL_MULT_12 | \
 					MX_APLLS_CLIKIN_12
-#define M3_DPLL_MULT_13			(330 << 12)
-#define M3_DPLL_DIV_13			(12 << 8)
+#define M3_DPLL_MULT_13			(76 << 12)
+#define M3_DPLL_DIV_13			(2 << 8)
 #define M3_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M3_DPLL_DIV_13 | M3_DPLL_MULT_13 | \
 					MX_APLLS_CLIKIN_13
-#define M3_DPLL_MULT_19			(275 << 12)
-#define M3_DPLL_DIV_19			(15 << 8)
+#define M3_DPLL_MULT_19			(17 << 12)
+#define M3_DPLL_DIV_19			(0 << 8)
 #define M3_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
 					M3_DPLL_DIV_19 | M3_DPLL_MULT_19 | \
 					MX_APLLS_CLIKIN_19_2
+
+/*
+ * #2   (ratio1) DPLL = 330*2 = 660MHz, L3=165MHz
+ */
+#define M2_DPLL_MULT_12		        (55 << 12)
+#define M2_DPLL_DIV_12		        (1 << 8)
+#define M2_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M2_DPLL_DIV_12 | M2_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+
+/* Speed changes - Used 658.7MHz instead of 660MHz for LP-Refresh M=76 N=2,
+ * relock time issue */
+/* Core frequency changed from 330/165 to 329/164 MHz*/
+#define M2_DPLL_MULT_13		        (76 << 12)
+#define M2_DPLL_DIV_13		        (2 << 8)
+#define M2_CM_CLKSEL1_PLL_13_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M2_DPLL_DIV_13 | M2_DPLL_MULT_13 | \
+					MX_APLLS_CLIKIN_13
+
+#define M2_DPLL_MULT_19		        (17 << 12)
+#define M2_DPLL_DIV_19		        (0 << 8)
+#define M2_CM_CLKSEL1_PLL_19_VAL	MX_48M_SRC | MX_54M_SRC | \
+					M2_DPLL_DIV_19 | M2_DPLL_MULT_19 | \
+					MX_APLLS_CLIKIN_19_2
+
 /* boot (boot) */
 #define MB_DPLL_MULT			(1 << 12)
 #define MB_DPLL_DIV			(0 << 8)
@@ -300,6 +360,13 @@ struct prcm_config {
  * boot (boot)
  */
 
+/* PRCM I target DPLL = 2*330MHz = 660MHz */
+#define MI_DPLL_MULT_12			(55 << 12)
+#define MI_DPLL_DIV_12			(1 << 8)
+#define MI_CM_CLKSEL1_PLL_12_VAL	MX_48M_SRC | MX_54M_SRC | \
+					MI_DPLL_DIV_12 | MI_DPLL_MULT_12 | \
+					MX_APLLS_CLIKIN_12
+
 /*
  * 2420 Equivalent - mode registers
  * PRCM II , target DPLL = 2*300MHz = 600MHz
@@ -335,28 +402,6 @@ struct prcm_config {
 #define MX_CLKSEL2_PLL_2x_VAL		(2 << 0)
 #define MX_CLKSEL2_PLL_1x_VAL		(1 << 0)
 
-/*
- * These represent optimal values for common parts, it won't work for all.
- * As long as you scale down, most parameters are still work, they just
- * become sub-optimal. The RFR value goes in the opposite direction. If you
- * don't adjust it down as your clock period increases the refresh interval
- * will not be met. Setting all parameters for complete worst case may work,
- * but may cut memory performance by 2x. Due to errata the DLLs need to be
- * unlocked and their value needs run time calibration.	A dynamic call is
- * need for that as no single right value exists acorss production samples.
- *
- * Only the FULL speed values are given. Current code is such that rate
- * changes must be made at DPLLoutx2. The actual value adjustment for low
- * frequency operation will be handled by omap_set_performance()
- *
- * By having the boot loader boot up in the fastest L4 speed available likely
- * will result in something which you can switch between.
- */
-#define V24XX_SDRC_RFR_CTRL_133MHz	(0x0003de00 | 1)
-#define V24XX_SDRC_RFR_CTRL_100MHz	(0x0002da01 | 1)
-#define V24XX_SDRC_RFR_CTRL_110MHz	(0x0002da01 | 1) /* Need to calc */
-#define V24XX_SDRC_RFR_CTRL_BYPASS	(0x00005000 | 1) /* Need to calc */
-
 /* MPU speed defines */
 #define S12M	12000000
 #define S13M	13000000
@@ -365,15 +410,21 @@ struct prcm_config {
 #define S100M	100000000
 #define S133M	133000000
 #define S150M	150000000
+#define S164M	164000000
 #define S165M	165000000
+#define S199M	199000000
 #define S200M	200000000
 #define S266M	266000000
 #define S300M	300000000
+#define S329M	329000000
 #define S330M	330000000
+#define S399M	399000000
 #define S400M	400000000
 #define S532M	532000000
 #define S600M	600000000
+#define S658M	658000000
 #define S660M	660000000
+#define S798M	798000000
 
 /*-------------------------------------------------------------------------
  * Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
@@ -394,78 +445,93 @@ struct prcm_config {
  * Note: This table needs to be sorted, fastest to slowest.
  *-------------------------------------------------------------------------*/
 static struct prcm_config rate_table[] = {
+	/* PRCM I - FAST */
+	{S12M, S660M, S330M, RI_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+		RI_CM_CLKSEL_DSP_VAL, RI_CM_CLKSEL_GFX_VAL,
+		RI_CM_CLKSEL1_CORE_VAL, MI_CM_CLKSEL1_PLL_12_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_165MHz,
+		RATE_IN_242X},
+
 	/* PRCM II - FAST */
 	{S12M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	{S13M, S600M, S300M, RII_CM_CLKSEL_MPU_VAL,		/* 300MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	/* PRCM III - FAST */
 	{S12M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	{S13M, S532M, S266M, RIII_CM_CLKSEL_MPU_VAL,		/* 266MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	/* PRCM II - SLOW */
 	{S12M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	{S13M, S300M, S150M, RII_CM_CLKSEL_MPU_VAL,		/* 150MHz ARM */
 		RII_CM_CLKSEL_DSP_VAL, RII_CM_CLKSEL_GFX_VAL,
 		RII_CM_CLKSEL1_CORE_VAL, MII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_100MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_100MHz,
 		RATE_IN_242X},
 
 	/* PRCM III - SLOW */
 	{S12M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	{S13M, S266M, S133M, RIII_CM_CLKSEL_MPU_VAL,		/* 133MHz ARM */
 		RIII_CM_CLKSEL_DSP_VAL, RIII_CM_CLKSEL_GFX_VAL,
 		RIII_CM_CLKSEL1_CORE_VAL, MIII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_133MHz,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_133MHz,
 		RATE_IN_242X},
 
 	/* PRCM-VII (boot-bypass) */
 	{S12M, S12M, S12M, RVII_CM_CLKSEL_MPU_VAL,		/* 12MHz ARM*/
 		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
 		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_12_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_242X},
 
 	/* PRCM-VII (boot-bypass) */
 	{S13M, S13M, S13M, RVII_CM_CLKSEL_MPU_VAL,		/* 13MHz ARM */
 		RVII_CM_CLKSEL_DSP_VAL, RVII_CM_CLKSEL_GFX_VAL,
 		RVII_CM_CLKSEL1_CORE_VAL, MVII_CM_CLKSEL1_PLL_13_VAL,
-		MX_CLKSEL2_PLL_2x_VAL, 0, V24XX_SDRC_RFR_CTRL_BYPASS,
+		MX_CLKSEL2_PLL_2x_VAL, 0, SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_242X},
 
-	/* PRCM #3 - ratio2 (ES2) - FAST */
-	{S13M, S660M, S330M, R2_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+	/* PRCM #4 - ratio2 (ES2.1) - FAST */
+	{S13M, S798M, S399M, R2_CM_CLKSEL_MPU_VAL,		/* 399MHz ARM */
 		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_110MHz,
+		SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #2 - ratio1 (ES2) - FAST */
+	{S13M, S658M, S329M, R1_CM_CLKSEL_MPU_VAL,		/* 330MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_165MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5a - ratio1 - FAST */
@@ -473,7 +539,7 @@ static struct prcm_config rate_table[] = {
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_133MHz,
+		SDRC_RFR_CTRL_133MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5b - ratio1 - FAST */
@@ -481,15 +547,23 @@ static struct prcm_config rate_table[] = {
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_100MHz,
+		SDRC_RFR_CTRL_100MHz,
 		RATE_IN_243X},
 
-	/* PRCM #3 - ratio2 (ES2) - SLOW */
-	{S13M, S330M, S165M, R2_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
+	/* PRCM #4 - ratio1 (ES2.1) - SLOW */
+	{S13M, S399M, S199M, R2_CM_CLKSEL_MPU_VAL,		/* 200MHz ARM */
 		R2_CM_CLKSEL_DSP_VAL, R2_CM_CLKSEL_GFX_VAL,
-		R2_CM_CLKSEL1_CORE_VAL, M3_CM_CLKSEL1_PLL_13_VAL,
+		R2_CM_CLKSEL1_CORE_VAL, M4_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R2_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_110MHz,
+		SDRC_RFR_CTRL_133MHz,
+		RATE_IN_243X},
+
+	/* PRCM #2 - ratio1 (ES2) - SLOW */
+	{S13M, S329M, S164M, R1_CM_CLKSEL_MPU_VAL,		/* 165MHz ARM */
+		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
+		R1_CM_CLKSEL1_CORE_VAL, M2_CM_CLKSEL1_PLL_13_VAL,
+		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
+		SDRC_RFR_CTRL_165MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5a - ratio1 - SLOW */
@@ -497,7 +571,7 @@ static struct prcm_config rate_table[] = {
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5A_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_133MHz,
+		SDRC_RFR_CTRL_133MHz,
 		RATE_IN_243X},
 
 	/* PRCM #5b - ratio1 - SLOW*/
@@ -505,7 +579,7 @@ static struct prcm_config rate_table[] = {
 		R1_CM_CLKSEL_DSP_VAL, R1_CM_CLKSEL_GFX_VAL,
 		R1_CM_CLKSEL1_CORE_VAL, M5B_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_1x_VAL, R1_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_100MHz,
+		SDRC_RFR_CTRL_100MHz,
 		RATE_IN_243X},
 
 	/* PRCM-boot/bypass */
@@ -513,7 +587,7 @@ static struct prcm_config rate_table[] = {
 		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
 		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_13_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_BYPASS,
+		SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_243X},
 
 	/* PRCM-boot/bypass */
@@ -521,7 +595,7 @@ static struct prcm_config rate_table[] = {
 		RB_CM_CLKSEL_DSP_VAL, RB_CM_CLKSEL_GFX_VAL,
 		RB_CM_CLKSEL1_CORE_VAL, MB_CM_CLKSEL1_PLL_12_VAL,
 		MX_CLKSEL2_PLL_2x_VAL, RB_CM_CLKSEL_MDM_VAL,
-		V24XX_SDRC_RFR_CTRL_BYPASS,
+		SDRC_RFR_CTRL_BYPASS,
 		RATE_IN_243X},
 
 	{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
@@ -552,25 +626,26 @@ static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED,
+				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
+	.recalc		= &propagate_rate,
 };
 
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
-	.rate		= 26000000,		/* fixed up in clock init */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
+				RATE_PROPAGATES,
+	.enable		= &omap2_enable_osc_ck,
+	.disable	= &omap2_disable_osc_ck,
+	.recalc		= &omap2_osc_clk_recalc,
 };
 
 /* With out modem likely 12MHz, with modem likely 13MHz */
 static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.name		= "sys_ck",		/* ~ ref_clk also */
 	.parent		= &osc_ck,
-	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.rate_offset	= 6, /* sysclkdiv 1 or 2, already handled or no boot */
+				ALWAYS_ENABLED | RATE_PROPAGATES,
 	.recalc		= &omap2_sys_clk_recalc,
 };
 
@@ -579,7 +654,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &propagate_rate,
 };
 
 /*
@@ -587,23 +662,37 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
  */
 
 /* dpll_ck, is broken out in to special cases through clksel */
+/* REVISIT: Rate changes on dpll_ck trigger a full set change.	...
+ * deal with this
+ */
+
+static const struct dpll_data dpll_dd = {
+	.mult_div1_reg		= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.mult_mask		= OMAP24XX_DPLL_MULT_MASK,
+	.div1_mask		= OMAP24XX_DPLL_DIV_MASK,
+};
+
 static struct clk dpll_ck = {
 	.name		= "dpll_ck",
 	.parent		= &sys_ck,		/* Can be func_32k also */
+	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_PROPAGATES | RATE_CKCTL | CM_PLL_SEL1,
-	.recalc		= &omap2_clksel_recalc,
+				RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_dpll_recalc,
+	.set_rate	= &omap2_reprogram_dpll,
 };
 
 static struct clk apll96_ck = {
 	.name		= "apll96_ck",
 	.parent		= &sys_ck,
 	.rate		= 96000000,
-	.flags		= CLOCK_IN_OMAP242X |CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0x2,
-	.recalc		= &omap2_propagate_rate,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
+	.enable		= &omap2_clk_fixed_enable,
+	.disable	= &omap2_clk_fixed_disable,
+	.recalc		= &propagate_rate,
 };
 
 static struct clk apll54_ck = {
@@ -611,25 +700,46 @@ static struct clk apll54_ck = {
 	.parent		= &sys_ck,
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0x6,
-	.recalc		= &omap2_propagate_rate,
+				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
+	.enable		= &omap2_clk_fixed_enable,
+	.disable	= &omap2_clk_fixed_disable,
+	.recalc		= &propagate_rate,
 };
 
 /*
  * PRCM digital base sources
  */
+
+/* func_54m_ck */
+
+static const struct clksel_rate func_54m_apll54_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate func_54m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel func_54m_clksel[] = {
+	{ .parent = &apll54_ck, .rates = func_54m_apll54_rates, },
+	{ .parent = &alt_ck,	.rates = func_54m_alt_rates, },
+	{ .parent = NULL },
+};
+
 static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.parent		= &apll54_ck,	/* can also be alt_clk */
-	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 5,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_54M_SOURCE,
+	.clksel		= func_54m_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk core_ck = {
@@ -637,49 +747,80 @@ static struct clk core_ck = {
 	.parent		= &dpll_ck,		/* can also be 32k */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &followparent_recalc,
 };
 
-static struct clk sleep_ck = {		/* sys_clk or 32k */
-	.name		= "sleep_ck",
-	.parent		= &func_32k_ck,
-	.rate		= 32000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_propagate_rate,
+/* func_96m_ck */
+static const struct clksel_rate func_96m_apll96_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate func_96m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_243X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel func_96m_clksel[] = {
+	{ .parent = &apll96_ck,	.rates = func_96m_apll96_rates },
+	{ .parent = &alt_ck,	.rates = func_96m_alt_rates },
+	{ .parent = NULL }
 };
 
+/* The parent of this clock is not selectable on 2420. */
 static struct clk func_96m_ck = {
 	.name		= "func_96m_ck",
 	.parent		= &apll96_ck,
-	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP2430_96M_SOURCE,
+	.clksel		= func_96m_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+/* func_48m_ck */
+
+static const struct clksel_rate func_48m_apll96_rates[] = {
+	{ .div = 2, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate func_48m_alt_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel func_48m_clksel[] = {
+	{ .parent = &apll96_ck,	.rates = func_48m_apll96_rates },
+	{ .parent = &alt_ck, .rates = func_48m_alt_rates },
+	{ .parent = NULL }
 };
 
 static struct clk func_48m_ck = {
 	.name		= "func_48m_ck",
 	.parent		= &apll96_ck,	 /* 96M or Alt */
-	.rate		= 48000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | CM_PLL_SEL1 | RATE_PROPAGATES,
-	.src_offset	= 3,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
-	.recalc		= &omap2_propagate_rate,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_48M_SOURCE,
+	.clksel		= func_48m_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk func_12m_ck = {
 	.name		= "func_12m_ck",
 	.parent		= &func_48m_ck,
-	.rate		= 12000000,
+	.fixed_div	= 4,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
-	.enable_reg	= (void __iomem *)&CM_CLKEN_PLL,
-	.enable_bit	= 0xff,
+				RATE_PROPAGATES | PARENT_CONTROLS_CLOCK,
+	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /* Secure timer, only available in secure mode */
@@ -687,43 +828,129 @@ static struct clk wdt1_osc_ck = {
 	.name		= "ck_wdt1_osc",
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.recalc		= &omap2_followparent_recalc,
+	.recalc		= &followparent_recalc,
+};
+
+/*
+ * The common_clkout* clksel_rate structs are common to
+ * sys_clkout, sys_clkout_src, sys_clkout2, and sys_clkout2_src.
+ * sys_clkout2_* are 2420-only, so the
+ * clksel_rate flags fields are inaccurate for those clocks. This is
+ * harmless since access to those clocks are gated by the struct clk
+ * flags fields, which mark them as 2420-only.
+ */
+static const struct clksel_rate common_clkout_src_core_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_clkout_src_sys_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_clkout_src_96m_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate common_clkout_src_54m_rates[] = {
+	{ .div = 1, .val = 3, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel common_clkout_src_clksel[] = {
+	{ .parent = &core_ck,	  .rates = common_clkout_src_core_rates },
+	{ .parent = &sys_ck,	  .rates = common_clkout_src_sys_rates },
+	{ .parent = &func_96m_ck, .rates = common_clkout_src_96m_rates },
+	{ .parent = &func_54m_ck, .rates = common_clkout_src_54m_rates },
+	{ .parent = NULL }
+};
+
+static struct clk sys_clkout_src = {
+	.name		= "sys_clkout_src",
+	.parent		= &func_54m_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				RATE_PROPAGATES,
+	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP24XX_CLKOUT_SOURCE_MASK,
+	.clksel		= common_clkout_src_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+static const struct clksel_rate common_clkout_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 8, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 16, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 0 },
+};
+
+static const struct clksel sys_clkout_clksel[] = {
+	{ .parent = &sys_clkout_src, .rates = common_clkout_rates },
+	{ .parent = NULL }
 };
 
 static struct clk sys_clkout = {
 	.name		= "sys_clkout",
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
+	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 0,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
-	.enable_bit	= 7,
-	.rate_offset	= 3,
+				PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
+	.clksel		= sys_clkout_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+/* In 2430, new in 2420 ES2 */
+static struct clk sys_clkout2_src = {
+	.name		= "sys_clkout2_src",
+	.parent		= &func_54m_ck,
+	.flags		= CLOCK_IN_OMAP242X | RATE_PROPAGATES,
+	.enable_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.enable_bit	= OMAP2420_CLKOUT2_EN_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP2420_CLKOUT2_SOURCE_MASK,
+	.clksel		= common_clkout_src_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+static const struct clksel sys_clkout2_clksel[] = {
+	{ .parent = &sys_clkout2_src, .rates = common_clkout_rates },
+	{ .parent = NULL }
 };
 
 /* In 2430, new in 2420 ES2 */
 static struct clk sys_clkout2 = {
 	.name		= "sys_clkout2",
-	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_SYSCLKOUT_SEL1 | RATE_CKCTL,
-	.src_offset	= 8,
-	.enable_reg	= (void __iomem *)&PRCM_CLKOUT_CTRL,
-	.enable_bit	= 15,
-	.rate_offset	= 11,
+	.parent		= &sys_clkout2_src,
+	.flags		= CLOCK_IN_OMAP242X | PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP24XX_PRCM_CLKOUT_CTRL,
+	.clksel_mask	= OMAP2420_CLKOUT2_DIV_MASK,
+	.clksel		= sys_clkout2_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk emul_ck = {
 	.name		= "emul_ck",
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&PRCM_CLKEMUL_CTRL,
-	.enable_bit	= 0,
-	.recalc		= &omap2_propagate_rate,
+	.enable_reg	= OMAP24XX_PRCM_CLKEMUL_CTRL,
+	.enable_bit	= OMAP24XX_EMULATION_EN_SHIFT,
+	.recalc		= &followparent_recalc,
 
 };
 
@@ -737,90 +964,149 @@ static struct clk emul_ck = {
  * - Base divider comes from: CM_CLKSEL_MPU
  *
  */
+static const struct clksel_rate mpu_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 0 },
+};
+
+static const struct clksel mpu_clksel[] = {
+	{ .parent = &core_ck, .rates = mpu_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk mpu_ck = {	/* Control cpu */
 	.name		= "mpu_ck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL |
-				ALWAYS_ENABLED | CM_MPU_SEL1 | DELAYED_APP |
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
+				ALWAYS_ENABLED | DELAYED_APP |
 				CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,	/* bits 0-4 */
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(MPU_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_MPU_MASK,
+	.clksel		= mpu_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate     = &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
  * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
  * Clocks:
- *	2430: IVA2.1_FCLK, IVA2.1_ICLK
+ *	2430: IVA2.1_FCLK (really just DSP_FCLK), IVA2.1_ICLK
  *	2420: UMA_FCLK, UMA_ICLK, IVA_MPU, IVA_COP
+ *
+ * Won't be too specific here. The core clock comes into this block
+ * it is divided then tee'ed. One branch goes directly to xyz enable
+ * controls. The other branch gets further divided by 2 then possibly
+ * routed into a synchronizer and out of clocks abc.
  */
-static struct clk iva2_1_fck = {
-	.name		= "iva2_1_fck",
+static const struct clksel_rate dsp_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 0 },
+};
+
+static const struct clksel dsp_fck_clksel[] = {
+	{ .parent = &core_ck, .rates = dsp_fck_core_rates },
+	{ .parent = NULL }
+};
+
+static struct clk dsp_fck = {
+	.name		= "dsp_fck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES |
-				CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 0,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_MASK,
+	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
-static struct clk iva2_1_ick = {
-	.name		= "iva2_1_ick",
-	.parent		= &iva2_1_fck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 5,
-	.recalc		= &omap2_clksel_recalc,
+/* DSP interface clock */
+static const struct clksel_rate dsp_irate_ick_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_243X },
+	{ .div = 0 },
+};
+
+static const struct clksel dsp_irate_ick_clksel[] = {
+	{ .parent = &dsp_fck, .rates = dsp_irate_ick_rates },
+	{ .parent = NULL }
 };
 
 /*
- * Won't be too specific here. The core clock comes into this block
- * it is divided then tee'ed. One branch goes directly to xyz enable
- * controls. The other branch gets further divided by 2 then possibly
- * routed into a synchronizer and out of clocks abc.
+ * This clock does not exist as such in the TRM, but is added to
+ * separate source selection from  XXX
  */
-static struct clk dsp_fck = {
-	.name		= "dsp_fck",
-	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
-			DELAYED_APP | CONFIG_PARTICIPANT | RATE_PROPAGATES,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 0,
+static struct clk dsp_irate_ick = {
+	.name		= "dsp_irate_ick",
+	.parent		= &dsp_fck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | DELAYED_APP |
+				CONFIG_PARTICIPANT | PARENT_CONTROLS_CLOCK,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSP_IF_MASK,
+	.clksel		= dsp_irate_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	      = &omap2_clksel_set_rate
 };
 
+/* 2420 only */
 static struct clk dsp_ick = {
 	.name		= "dsp_ick",	 /* apparently ipi and isp */
-	.parent		= &dsp_fck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset = 5,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_DSP,
-	.enable_bit	= 1,		/* for ipi */
-	.recalc		= &omap2_clksel_recalc,
+	.parent		= &dsp_irate_ick,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2420_EN_DSP_IPI_SHIFT,	      /* for ipi */
+};
+
+/* 2430 only - EN_DSP controls both dsp fclk and iclk on 2430 */
+static struct clk iva2_1_ick = {
+	.name		= "iva2_1_ick",
+	.parent		= &dsp_irate_ick,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_CM_FCLKEN_DSP_EN_DSP_SHIFT,
 };
 
 static struct clk iva1_ifck = {
 	.name		= "iva1_ifck",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP242X | CM_DSP_SEL1 | RATE_CKCTL |
-			CONFIG_PARTICIPANT | RATE_PROPAGATES | DELAYED_APP,
-	.rate_offset= 8,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 10,
+	.flags		= CLOCK_IN_OMAP242X | CONFIG_PARTICIPANT |
+				RATE_PROPAGATES | DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP2420_EN_IVA_COP_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP2420_CLKSEL_IVA_MASK,
+	.clksel		= dsp_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /* IVA1 mpu/int/i/f clocks are /2 of parent */
 static struct clk iva1_mpu_int_ifck = {
 	.name		= "iva1_mpu_int_ifck",
 	.parent		= &iva1_ifck,
-	.flags		= CLOCK_IN_OMAP242X | RATE_CKCTL | CM_DSP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_DSP,
-	.enable_bit	= 8,
-	.recalc		= &omap2_clksel_recalc,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP24XX_DSP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP2420_EN_IVA_MPU_SHIFT,
+	.fixed_div	= 2,
+	.recalc		= &omap2_fixed_divisor_recalc,
 };
 
 /*
@@ -842,27 +1128,62 @@ static struct clk iva1_mpu_int_ifck = {
  * may very well need notification when the clock changes. Currently for low
  * operating points, these are taken care of in sleep.S.
  */
+static const struct clksel_rate core_l3_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 16, .val = 16, .flags = RATE_IN_242X },
+	{ .div = 0 }
+};
+
+static const struct clksel core_l3_clksel[] = {
+	{ .parent = &core_ck, .rates = core_l3_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk core_l3_ck = {	/* Used for ick and fck, interconnect */
 	.name		= "core_l3_ck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT |
-				RATE_PROPAGATES,
-	.rate_offset	= 0,
+				ALWAYS_ENABLED | DELAYED_APP |
+				CONFIG_PARTICIPANT | RATE_PROPAGATES,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_L3_MASK,
+	.clksel		= core_l3_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+/* usb_l4_ick */
+static const struct clksel_rate usb_l4_ick_core_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 0 }
+};
+
+static const struct clksel usb_l4_ick_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = usb_l4_ick_core_l3_rates },
+	{ .parent = NULL },
 };
 
 static struct clk usb_l4_ick = {	/* FS-USB interface clock */
 	.name		= "usb_l4_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP |
-				CONFIG_PARTICIPANT,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 0,
-	.rate_offset = 25,
+				DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_USB_MASK,
+	.clksel		= usb_l4_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -873,15 +1194,35 @@ static struct clk usb_l4_ick = {	/* FS-USB interface clock */
  *
  * ssr = core/1/2/3/4/5, sst = 1/2 ssr.
  */
+static const struct clksel_rate ssi_ssr_sst_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_243X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 0 }
+};
+
+static const struct clksel ssi_ssr_sst_fck_clksel[] = {
+	{ .parent = &core_ck, .rates = ssi_ssr_sst_fck_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk ssi_ssr_sst_fck = {
 	.name		= "ssi_fck",
 	.parent		= &core_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,	/* bit 1 */
-	.enable_bit	= 1,
-	.rate_offset = 20,
+				DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_SSI_MASK,
+	.clksel		= ssi_ssr_sst_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 /*
@@ -895,36 +1236,49 @@ static struct clk ssi_ssr_sst_fck = {
  * divided value of fclk.
  *
  */
+/* XXX REVISIT: GFX clock is part of CONFIG_PARTICIPANT, no? doublecheck. */
+
+/* This clksel struct is shared between gfx_3d_fck and gfx_2d_fck */
+static const struct clksel gfx_fck_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = gfx_l3_rates },
+	{ .parent = NULL },
+};
+
 static struct clk gfx_3d_fck = {
 	.name		= "gfx_3d_fck",
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
-	.enable_bit	= 2,
-	.rate_offset= 0,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_3D_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_2d_fck = {
 	.name		= "gfx_2d_fck",
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_GFX_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_GFX,
-	.enable_bit	= 1,
-	.rate_offset= 0,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_2D_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP_CLKSEL_GFX_MASK,
+	.clksel		= gfx_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gfx_ick = {
 	.name		= "gfx_ick",		/* From l3 */
 	.parent		= &core_l3_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_GFX,	/* bit 0 */
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(GFX_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP_EN_GFX_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -932,26 +1286,42 @@ static struct clk gfx_ick = {
  *	CLOCKS:
  *		MDM_OSC_CLK
  *		MDM_ICLK
+ * These clocks are usable in chassis mode only.
  */
+static const struct clksel_rate mdm_ick_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_243X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_243X | DEFAULT_RATE },
+	{ .div = 6, .val = 6, .flags = RATE_IN_243X },
+	{ .div = 9, .val = 9, .flags = RATE_IN_243X },
+	{ .div = 0 }
+};
+
+static const struct clksel mdm_ick_clksel[] = {
+	{ .parent = &core_ck, .rates = mdm_ick_core_rates },
+	{ .parent = NULL }
+};
+
 static struct clk mdm_ick = {		/* used both as a ick and fck */
 	.name		= "mdm_ick",
 	.parent		= &core_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_CKCTL | CM_MODEM_SEL1 |
-				DELAYED_APP | CONFIG_PARTICIPANT,
-	.rate_offset	= 0,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_MDM,
-	.enable_bit	= 0,
+	.flags		= CLOCK_IN_OMAP243X | DELAYED_APP | CONFIG_PARTICIPANT,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2430_CM_ICLKEN_MDM_EN_MDM_SHIFT,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_CLKSEL),
+	.clksel_mask	= OMAP2430_CLKSEL_MDM_MASK,
+	.clksel		= mdm_ick_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk mdm_osc_ck = {
 	.name		= "mdm_osc_ck",
-	.rate		= 26000000,
 	.parent		= &osc_ck,
-	.flags		= CLOCK_IN_OMAP243X | RATE_FIXED,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_MDM,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(OMAP2430_MDM_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP2430_EN_OSC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -961,23 +1331,37 @@ static struct clk mdm_osc_ck = {
  * functional clocks.	Fixed APLL functional source clocks are managed in
  * this domain.
  */
+static const struct clksel_rate l4_core_l3_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 0 }
+};
+
+static const struct clksel l4_clksel[] = {
+	{ .parent = &core_l3_ck, .rates = l4_core_l3_rates },
+	{ .parent = NULL }
+};
+
 static struct clk l4_ck = {		/* used both as an ick and fck */
 	.name		= "l4_ck",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | ALWAYS_ENABLED | CM_CORE_SEL1 |
-				DELAYED_APP | RATE_PROPAGATES,
-	.rate_offset	= 5,
+				ALWAYS_ENABLED | DELAYED_APP | RATE_PROPAGATES,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_L4_MASK,
+	.clksel		= l4_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk ssi_l4_ick = {
 	.name		= "ssi_l4_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,	/* bit 1 */
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_SSI_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -988,48 +1372,95 @@ static struct clk ssi_l4_ick = {
  *
  * DSS is both initiator and target.
  */
+/* XXX Add RATE_NOT_VALIDATED */
+
+static const struct clksel_rate dss1_fck_sys_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate dss1_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX },
+	{ .div = 2, .val = 2, .flags = RATE_IN_24XX },
+	{ .div = 3, .val = 3, .flags = RATE_IN_24XX },
+	{ .div = 4, .val = 4, .flags = RATE_IN_24XX },
+	{ .div = 5, .val = 5, .flags = RATE_IN_24XX },
+	{ .div = 6, .val = 6, .flags = RATE_IN_24XX },
+	{ .div = 8, .val = 8, .flags = RATE_IN_24XX },
+	{ .div = 9, .val = 9, .flags = RATE_IN_24XX },
+	{ .div = 12, .val = 12, .flags = RATE_IN_24XX },
+	{ .div = 16, .val = 16, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel dss1_fck_clksel[] = {
+	{ .parent = &sys_ck,  .rates = dss1_fck_sys_rates },
+	{ .parent = &core_ck, .rates = dss1_fck_core_rates },
+	{ .parent = NULL },
+};
+
 static struct clk dss_ick = {		/* Enables both L3,L4 ICLK's */
 	.name		= "dss_ick",
 	.parent		= &l4_ck,	/* really both l3 and l4 */
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | RATE_CKCTL,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss1_fck = {
 	.name		= "dss1_fck",
 	.parent		= &core_ck,		/* Core or sys */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 0,
-	.rate_offset	= 8,
-	.src_offset	= 8,
+				DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_DSS1_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSS1_MASK,
+	.clksel		= dss1_fck_clksel,
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
+};
+
+static const struct clksel_rate dss2_fck_sys_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate dss2_fck_48m_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel dss2_fck_clksel[] = {
+	{ .parent = &sys_ck,	  .rates = dss2_fck_sys_rates },
+	{ .parent = &func_48m_ck, .rates = dss2_fck_48m_rates },
+	{ .parent = NULL }
 };
 
 static struct clk dss2_fck = {		/* Alt clk used in power management */
 	.name		= "dss2_fck",
 	.parent		= &sys_ck,		/* fixed at sys_ck or 48MHz */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_CKCTL | CM_CORE_SEL1 | RATE_FIXED |
 				DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 1,
-	.src_offset	= 13,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_DSS2_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_DSS2_MASK,
+	.clksel		= dss2_fck_clksel,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk dss_54m_fck = {	/* Alt clk used in power management */
 	.name		= "dss_54m_fck",	/* 54m tv clk */
 	.parent		= &func_54m_ck,
-	.rate		= 54000000,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				RATE_FIXED | RATE_PROPAGATES,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_propagate_rate,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_TV_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1038,334 +1469,372 @@ static struct clk dss_54m_fck = {	/* Alt clk used in power management */
  * here will likely have an L4 interface parent, and may have multiple
  * functional clock parents.
  */
+static const struct clksel_rate gpt_alt_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_24XX | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel omap24xx_gpt_clksel[] = {
+	{ .parent = &func_32k_ck, .rates = gpt_32k_rates },
+	{ .parent = &sys_ck,	  .rates = gpt_sys_rates },
+	{ .parent = &alt_ck,	  .rates = gpt_alt_rates },
+	{ .parent = NULL },
+};
+
 static struct clk gpt1_ick = {
 	.name		= "gpt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,	/* Bit0 */
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt1_fck = {
 	.name		= "gpt1_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_WKUP_SEL1,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,	/* Bit0 */
-	.enable_bit	= 0,
-	.src_offset	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_GPT1_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT1_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk gpt2_ick = {
 	.name		= "gpt2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit4 */
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt2_fck = {
 	.name		= "gpt2_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 4,
-	.src_offset	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT2_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT2_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt3_ick = {
 	.name		= "gpt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit5 */
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt3_fck = {
 	.name		= "gpt3_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 5,
-	.src_offset	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT3_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT3_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt4_ick = {
 	.name		= "gpt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	/* Bit6 */
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt4_fck = {
 	.name		= "gpt4_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 6,
-	.src_offset	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT4_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT4_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt5_ick = {
 	.name		= "gpt5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* Bit7 */
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt5_fck = {
 	.name		= "gpt5_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 7,
-	.src_offset	= 8,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT5_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT5_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt6_ick = {
 	.name		= "gpt6_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 8,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit8 */
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt6_fck = {
 	.name		= "gpt6_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 8,
-	.src_offset	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT6_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT6_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt7_ick = {
 	.name		= "gpt7_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit9 */
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt7_fck = {
 	.name		= "gpt7_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 9,
-	.src_offset	= 12,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT7_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT7_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt8_ick = {
 	.name		= "gpt8_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit10 */
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt8_fck = {
 	.name		= "gpt8_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-				CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 10,
-	.src_offset	= 14,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT8_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT8_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt9_ick = {
 	.name		= "gpt9_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 11,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt9_fck = {
 	.name		= "gpt9_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 11,
-	.src_offset	= 16,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT9_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT9_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt10_ick = {
 	.name		= "gpt10_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 12,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt10_fck = {
 	.name		= "gpt10_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 12,
-	.src_offset	= 18,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT10_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT10_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt11_ick = {
 	.name		= "gpt11_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 13,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt11_fck = {
 	.name		= "gpt11_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 13,
-	.src_offset	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT11_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT11_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit14 */
-	.enable_bit	= 14,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpt12_fck = {
 	.name		= "gpt12_fck",
 	.parent		= &func_32k_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
-					CM_CORE_SEL2,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 14,
-	.src_offset	= 22,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_GPT12_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_mask	= OMAP24XX_CLKSEL_GPT12_MASK,
+	.clksel		= omap24xx_gpt_clksel,
+	.recalc		= &omap2_clksel_recalc,
 };
 
 static struct clk mcbsp1_ick = {
 	.name		= "mcbsp1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,	 /* bit16 */
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp1_fck = {
 	.name		= "mcbsp1_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 15,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp2_ick = {
 	.name		= "mcbsp2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp2_fck = {
 	.name		= "mcbsp2_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_bit	= 16,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCBSP2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp3_ick = {
 	.name		= "mcbsp3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp3_fck = {
 	.name		= "mcbsp3_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp4_ick = {
 	.name		= "mcbsp4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp4_fck = {
 	.name		= "mcbsp4_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp5_ick = {
 	.name		= "mcbsp5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcbsp5_fck = {
 	.name		= "mcbsp5_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCBSP5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi1_ick = {
@@ -1373,9 +1842,9 @@ static struct clk mcspi1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi1_fck = {
@@ -1383,9 +1852,9 @@ static struct clk mcspi1_fck = {
 	.id		= 1,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi2_ick = {
@@ -1393,9 +1862,9 @@ static struct clk mcspi2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 18,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi2_fck = {
@@ -1403,9 +1872,9 @@ static struct clk mcspi2_fck = {
 	.id		= 2,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 18,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MCSPI2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi3_ick = {
@@ -1413,9 +1882,9 @@ static struct clk mcspi3_ick = {
 	.id		= 3,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mcspi3_fck = {
@@ -1423,285 +1892,285 @@ static struct clk mcspi3_fck = {
 	.id		= 3,
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 9,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MCSPI3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_ick = {
 	.name		= "uart1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 21,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart1_fck = {
 	.name		= "uart1_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 21,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart2_ick = {
 	.name		= "uart2_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 22,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart2_fck = {
 	.name		= "uart2_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 22,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_UART2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart3_ick = {
 	.name		= "uart3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk uart3_fck = {
 	.name		= "uart3_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP24XX_EN_UART3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_ick = {
 	.name		= "gpios_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN_WKUP,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
+	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sync_32k_ick = {
 	.name		= "sync_32k_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_32KSYNC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 static struct clk omapctrl_ick = {
 	.name		= "omapctrl_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 5,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP24XX_EN_OMAPCTRL_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 static struct clk icr_ick = {
 	.name		= "icr_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN_WKUP,
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
+	.enable_bit	= OMAP2430_EN_ICR_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_ick = {
 	.name		= "cam_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 31,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk cam_fck = {
 	.name		= "cam_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 31,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_CAM_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mailboxes_ick = {
 	.name		= "mailboxes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 30,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MAILBOXES_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt4_ick = {
 	.name		= "wdt4_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 29,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt4_fck = {
 	.name		= "wdt4_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 29,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_WDT4_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt3_ick = {
 	.name		= "wdt3_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 28,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk wdt3_fck = {
 	.name		= "wdt3_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 28,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_WDT3_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mspro_ick = {
 	.name		= "mspro_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 27,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mspro_fck = {
 	.name		= "mspro_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 27,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_MSPRO_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmc_ick = {
 	.name		= "mmc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 26,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmc_fck = {
 	.name		= "mmc_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 26,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_MMC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk fac_ick = {
 	.name		= "fac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 25,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk fac_fck = {
 	.name		= "fac_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 25,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_FAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk eac_ick = {
 	.name		= "eac_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 24,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk eac_fck = {
 	.name		= "eac_fck",
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 24,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_EAC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk hdq_ick = {
 	.name		= "hdq_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 23,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk hdq_fck = {
 	.name		= "hdq_fck",
 	.parent		= &func_12m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 23,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP24XX_EN_HDQ_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_ick = {
@@ -1709,28 +2178,29 @@ static struct clk i2c2_ick = {
 	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c2_fck = {
 	.name		= "i2c_fck",
 	.id		= 2,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2chs2_fck = {
-	.name		= "i2chs2_fck",
+	.name		= "i2chs_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 20,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_I2CHS2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c1_ick = {
@@ -1738,200 +2208,258 @@ static struct clk i2c1_ick = {
 	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2c1_fck = {
 	.name		= "i2c_fck",
 	.id		= 1,
 	.parent		= &func_12m_ck,
-	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_I2C1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk i2chs1_fck = {
-	.name		= "i2chs1_fck",
+	.name		= "i2chs_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 19,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_I2CHS1_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk gpmc_fck = {
+	.name		= "gpmc_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdma_fck = {
+	.name		= "sdma_fck",
+	.parent		= &core_l3_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
+};
+
+static struct clk sdma_ick = {
+	.name		= "sdma_ick",
+	.parent		= &l4_ck,
+	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk vlynq_ick = {
 	.name		= "vlynq_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN1_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
+	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.recalc		= &followparent_recalc,
+};
+
+static const struct clksel_rate vlynq_fck_96m_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 0 }
+};
+
+static const struct clksel_rate vlynq_fck_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_242X },
+	{ .div = 2, .val = 2, .flags = RATE_IN_242X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_242X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_242X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_242X },
+	{ .div = 8, .val = 8, .flags = RATE_IN_242X },
+	{ .div = 9, .val = 9, .flags = RATE_IN_242X },
+	{ .div = 12, .val = 12, .flags = RATE_IN_242X },
+	{ .div = 16, .val = 16, .flags = RATE_IN_242X | DEFAULT_RATE },
+	{ .div = 18, .val = 18, .flags = RATE_IN_242X },
+	{ .div = 0 }
+};
+
+static const struct clksel vlynq_fck_clksel[] = {
+	{ .parent = &func_96m_ck, .rates = vlynq_fck_96m_rates },
+	{ .parent = &core_ck,	  .rates = vlynq_fck_core_rates },
+	{ .parent = NULL }
 };
 
 static struct clk vlynq_fck = {
 	.name		= "vlynq_fck",
 	.parent		= &func_96m_ck,
-	.flags		= CLOCK_IN_OMAP242X  | RATE_CKCTL | CM_CORE_SEL1 | DELAYED_APP,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN1_CORE,
-	.enable_bit	= 3,
-	.src_offset	= 15,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP242X | DELAYED_APP,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
+	.enable_bit	= OMAP2420_EN_VLYNQ_SHIFT,
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP2420_CLKSEL_VLYNQ_MASK,
+	.clksel		= vlynq_fck_clksel,
+	.recalc		= &omap2_clksel_recalc,
+	.round_rate	= &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
 
 static struct clk sdrc_ick = {
 	.name		= "sdrc_ick",
 	.parent		= &l4_ck,
-	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN3_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.flags		= CLOCK_IN_OMAP243X | ENABLE_ON_INIT,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN3),
+	.enable_bit	= OMAP2430_EN_SDRC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk des_ick = {
 	.name		= "des_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_DES_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk sha_ick = {
 	.name		= "sha_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 1,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_SHA_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk rng_ick = {
 	.name		= "rng_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 2,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_RNG_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk aes_ick = {
 	.name		= "aes_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 3,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_AES_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk pka_ick = {
 	.name		= "pka_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN4_CORE,
-	.enable_bit	= 4,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_ICLKEN4),
+	.enable_bit	= OMAP24XX_EN_PKA_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk usb_fck = {
 	.name		= "usb_fck",
 	.parent		= &func_48m_ck,
 	.flags		= CLOCK_IN_OMAP243X | CLOCK_IN_OMAP242X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 0,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP24XX_EN_USB_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk usbhs_ick = {
 	.name		= "usbhs_ick",
 	.parent		= &core_l3_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 6,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_USBHS_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs1_ick = {
-	.name		= "mmchs1_ick",
+	.name		= "mmchs_ick",
+	.id		= 1,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs1_fck = {
-	.name		= "mmchs1_fck",
+	.name		= "mmchs_fck",
+	.id		= 1,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 7,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs2_ick = {
-	.name		= "mmchs2_ick",
+	.name		= "mmchs_ick",
+	.id		= 2,
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 8,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchs2_fck = {
-	.name		= "mmchs2_fck",
+	.name		= "mmchs_fck",
+	.id		= 2,
 	.parent		= &func_96m_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 8,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHS2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio5_ick = {
 	.name		= "gpio5_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk gpio5_fck = {
 	.name		= "gpio5_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 10,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_GPIO5_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mdm_intc_ick = {
 	.name		= "mdm_intc_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_ICLKEN2_CORE,
-	.enable_bit	= 11,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN2),
+	.enable_bit	= OMAP2430_EN_MDM_INTC_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchsdb1_fck = {
-	.name		= "mmchsdb1_fck",
+	.name		= "mmchsdb_fck",
+	.id		= 1,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 16,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHSDB1_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 static struct clk mmchsdb2_fck = {
-	.name		= "mmchsdb2_fck",
+	.name		= "mmchsdb_fck",
+	.id		= 2,
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP243X,
-	.enable_reg	= (void __iomem *)&CM_FCLKEN2_CORE,
-	.enable_bit	= 17,
-	.recalc		= &omap2_followparent_recalc,
+	.enable_reg	= OMAP_CM_REGADDR(CORE_MOD, OMAP24XX_CM_FCLKEN2),
+	.enable_bit	= OMAP2430_EN_MMCHSDB2_SHIFT,
+	.recalc		= &followparent_recalc,
 };
 
 /*
@@ -1953,12 +2481,12 @@ static struct clk virt_prcm_set = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
-	.recalc		= &omap2_mpu_recalc,	/* sets are keyed on mpu rate */
+	.recalc		= &omap2_table_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
 	.round_rate	= &omap2_round_to_table_rate,
 };
 
-static struct clk *onchip_clks[] = {
+static struct clk *onchip_24xx_clks[] __initdata = {
 	/* external root sources */
 	&func_32k_ck,
 	&osc_ck,
@@ -1971,23 +2499,24 @@ static struct clk *onchip_clks[] = {
 	/* internal prcm root sources */
 	&func_54m_ck,
 	&core_ck,
-	&sleep_ck,
 	&func_96m_ck,
 	&func_48m_ck,
 	&func_12m_ck,
 	&wdt1_osc_ck,
+	&sys_clkout_src,
 	&sys_clkout,
+	&sys_clkout2_src,
 	&sys_clkout2,
 	&emul_ck,
 	/* mpu domain clocks */
 	&mpu_ck,
 	/* dsp domain clocks */
-	&iva2_1_fck,		/* 2430 */
-	&iva2_1_ick,
-	&dsp_ick,		/* 2420 */
 	&dsp_fck,
-	&iva1_ifck,
-	&iva1_mpu_int_ifck,
+	&dsp_irate_ick,
+	&dsp_ick,		/* 242x */
+	&iva2_1_ick,		/* 243x */
+	&iva1_ifck,		/* 242x */
+	&iva1_mpu_int_ifck,	/* 242x */
 	/* GFX domain clocks */
 	&gfx_3d_fck,
 	&gfx_2d_fck,
@@ -2087,6 +2616,9 @@ static struct clk *onchip_clks[] = {
 	&i2c2_ick,
 	&i2c2_fck,
 	&i2chs2_fck,
+	&gpmc_fck,
+	&sdma_fck,
+	&sdma_ick,
 	&vlynq_ick,
 	&vlynq_fck,
 	&sdrc_ick,
@@ -2109,3 +2641,4 @@ static struct clk *onchip_clks[] = {
 };
 
 #endif
+
diff --git a/arch/arm/mach-omap2/memory.c b/arch/arm/mach-omap2/memory.c
index b56c1a0..412357e 100644
--- a/arch/arm/mach-omap2/memory.c
+++ b/arch/arm/mach-omap2/memory.c
@@ -53,6 +53,54 @@ u32 omap2_memory_get_type(void)
 	return mem_timings.m_type;
 }
 
+/*
+ * Check the DLL lock state, and return tue if running in unlock mode.
+ * This is needed to compensate for the shifted DLL value in unlock mode.
+ */
+u32 omap2_dll_force_needed(void)
+{
+	/* dlla and dllb are a set */
+	u32 dll_state = sdrc_read_reg(SDRC_DLLA_CTRL);
+
+	if ((dll_state & (1 << 2)) == (1 << 2))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * 'level' is the value to store to CM_CLKSEL2_PLL.CORE_CLK_SRC.
+ * Practical values are CORE_CLK_SRC_DPLL (for CORE_CLK = DPLL_CLK) or
+ * CORE_CLK_SRC_DPLL_X2 (for CORE_CLK = * DPLL_CLK * 2)
+ */
+u32 omap2_reprogram_sdrc(u32 level, u32 force)
+{
+	u32 dll_ctrl, m_type;
+	u32 prev = curr_perf_level;
+	unsigned long flags;
+
+	if ((curr_perf_level == level) && !force)
+		return prev;
+
+	if (level == CORE_CLK_SRC_DPLL) {
+		dll_ctrl = omap2_memory_get_slow_dll_ctrl();
+	} else if (level == CORE_CLK_SRC_DPLL_X2) {
+		dll_ctrl = omap2_memory_get_fast_dll_ctrl();
+	} else {
+		return prev;
+	}
+
+	m_type = omap2_memory_get_type();
+
+	local_irq_save(flags);
+	prm_write_reg(0xffff, OMAP24XX_PRCM_VOLTSETUP);
+	omap2_sram_reprogram_sdrc(level, dll_ctrl, m_type);
+	curr_perf_level = level;
+	local_irq_restore(flags);
+
+	return prev;
+}
+
 void omap2_init_memory_params(u32 force_lock_to_unlock_mode)
 {
 	unsigned long dll_cnt;
diff --git a/arch/arm/mach-omap2/memory.h b/arch/arm/mach-omap2/memory.h
index d212eea..9a280b5 100644
--- a/arch/arm/mach-omap2/memory.h
+++ b/arch/arm/mach-omap2/memory.h
@@ -32,3 +32,5 @@ extern void omap2_init_memory_params(u32 force_lock_to_unlock_mode);
 extern u32 omap2_memory_get_slow_dll_ctrl(void);
 extern u32 omap2_memory_get_fast_dll_ctrl(void);
 extern u32 omap2_memory_get_type(void);
+u32 omap2_dll_force_needed(void);
+u32 omap2_reprogram_sdrc(u32 level, u32 force);
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 0a60324..32a533b 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -304,6 +304,23 @@ void propagate_rate(struct clk * tclk)
 	}
 }
 
+/**
+ * recalculate_root_clocks - recalculate and propagate all root clocks
+ *
+ * Recalculates all root clocks (clocks with no parent), which if the
+ * clock's .recalc is set correctly, should also propagate their rates.
+ * Called at init.
+ */
+void recalculate_root_clocks(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clocks, node) {
+		if (unlikely(!clkp->parent) && likely((u32)clkp->recalc))
+			clkp->recalc(clkp);
+	}
+}
+
 int clk_register(struct clk *clk)
 {
 	if (clk == NULL || IS_ERR(clk))
@@ -358,6 +375,30 @@ void clk_allow_idle(struct clk *clk)
 }
 EXPORT_SYMBOL(clk_allow_idle);
 
+void clk_enable_init_clocks(void)
+{
+	struct clk *clkp;
+
+	list_for_each_entry(clkp, &clocks, node) {
+		if (clkp->flags & ENABLE_ON_INIT)
+			clk_enable(clkp);
+	}
+}
+EXPORT_SYMBOL(clk_enable_init_clocks);
+
+#ifdef CONFIG_CPU_FREQ
+void clk_init_cpufreq_table(struct cpufreq_frequency_table **table)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+	if (arch_clock->clk_init_cpufreq_table)
+		arch_clock->clk_init_cpufreq_table(table);
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+}
+EXPORT_SYMBOL(clk_init_cpufreq_table);
+#endif
+
 /*-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
@@ -396,3 +437,4 @@ int __init clk_init(struct clk_functions * custom_clocks)
 
 	return 0;
 }
+
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index fc7b806..ff0f94d 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -14,6 +14,30 @@
 #define __ARCH_ARM_OMAP_CLOCK_H
 
 struct module;
+struct clk;
+
+#if defined(CONFIG_ARCH_OMAP2)
+
+struct clksel_rate {
+	u8			div;
+	u32			val;
+	u8			flags;
+};
+
+struct clksel {
+	struct clk		 *parent;
+	const struct clksel_rate *rates;
+};
+
+struct dpll_data {
+	void __iomem		*mult_div1_reg;
+	u32			mult_mask;
+	u32			div1_mask;
+	void __iomem		*div2_reg;
+	u32			div2_mask;
+};
+
+#endif
 
 struct clk {
 	struct list_head	node;
@@ -25,8 +49,6 @@ struct clk {
 	__u32			flags;
 	void __iomem		*enable_reg;
 	__u8			enable_bit;
-	__u8			rate_offset;
-	__u8			src_offset;
 	__s8			usecount;
 	void			(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
@@ -34,6 +56,16 @@ struct clk {
 	void			(*init)(struct clk *);
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
+#if defined(CONFIG_ARCH_OMAP2)
+	u8			fixed_div;
+	void __iomem		*clksel_reg;
+	u32			clksel_mask;
+	const struct clksel	*clksel;
+	const struct dpll_data	*dpll_data;
+#else
+	__u8			rate_offset;
+	__u8			src_offset;
+#endif
 };
 
 struct clk_functions {
@@ -54,10 +86,12 @@ extern int clk_init(struct clk_functions * custom_clocks);
 extern int clk_register(struct clk *clk);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
+extern void recalculate_root_clocks(void);
 extern void followparent_recalc(struct clk * clk);
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern int clk_get_usecount(struct clk *clk);
+extern void clk_enable_init_clocks(void);
 
 /* Clock flags */
 #define RATE_CKCTL		(1 << 0)	/* Main fixed ratio clocks */
@@ -71,22 +105,29 @@ extern int clk_get_usecount(struct clk *clk);
 #define CLOCK_NO_IDLE_PARENT	(1 << 8)
 #define DELAYED_APP		(1 << 9)	/* Delay application of clock */
 #define CONFIG_PARTICIPANT	(1 << 10)	/* Fundamental clock */
-#define CM_MPU_SEL1		(1 << 11)	/* Domain divider/source */
-#define CM_DSP_SEL1		(1 << 12)
-#define CM_GFX_SEL1		(1 << 13)
-#define CM_MODEM_SEL1		(1 << 14)
-#define CM_CORE_SEL1		(1 << 15)	/* Sets divider for many */
-#define CM_CORE_SEL2		(1 << 16)	/* sets parent for GPT */
-#define CM_WKUP_SEL1		(1 << 17)
-#define CM_PLL_SEL1		(1 << 18)
-#define CM_PLL_SEL2		(1 << 19)
-#define CM_SYSCLKOUT_SEL1	(1 << 20)
+#define ENABLE_ON_INIT		(1 << 11)	/* Enable upon framework init */
+#define INVERT_ENABLE           (1 << 12)       /* 0 enables, 1 disables */
+/* bits 13-20 are currently free */
 #define CLOCK_IN_OMAP310	(1 << 21)
 #define CLOCK_IN_OMAP730	(1 << 22)
 #define CLOCK_IN_OMAP1510	(1 << 23)
 #define CLOCK_IN_OMAP16XX	(1 << 24)
 #define CLOCK_IN_OMAP242X	(1 << 25)
 #define CLOCK_IN_OMAP243X	(1 << 26)
+#define CLOCK_IN_OMAP343X	(1 << 27)	/* clocks common to all 343X */
+#define PARENT_CONTROLS_CLOCK	(1 << 28)
+#define CLOCK_IN_OMAP3430ES1	(1 << 29)	/* 3430ES1 clocks only */
+#define CLOCK_IN_OMAP3430ES2	(1 << 30)	/* 3430ES2 clocks only */
+
+/* Clksel_rate flags */
+#define DEFAULT_RATE		(1 << 0)
+#define RATE_IN_242X		(1 << 1)
+#define RATE_IN_243X		(1 << 2)
+#define RATE_IN_343X		(1 << 3)	/* rates common to all 343X */
+#define RATE_IN_3430ES2		(1 << 4)	/* 3430ES2 rates only */
+
+#define RATE_IN_24XX		(RATE_IN_242X | RATE_IN_243X)
+
 
 /* CM_CLKSEL2_PLL.CORE_CLK_SRC options (24XX) */
 #define CORE_CLK_SRC_32K		0
-- 
1.5.3.6


-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
