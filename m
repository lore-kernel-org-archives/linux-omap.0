From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 10/17] ARM: OMAP2: Change 24xx to use shared clock code and
	new reg access
Date: Tue, 18 Mar 2008 16:02:08 +0200
Message-ID: <1205848935-12078-11-git-send-email-tony@atomide.com>
References: omap2-upstream-2008-03-18-160209
	<1205848935-12078-1-git-send-email-tony@atomide.com>
	<1205848935-12078-2-git-send-email-tony@atomide.com>
	<1205848935-12078-3-git-send-email-tony@atomide.com>
	<1205848935-12078-4-git-send-email-tony@atomide.com>
	<1205848935-12078-5-git-send-email-tony@atomide.com>
	<1205848935-12078-6-git-send-email-tony@atomide.com>
	<1205848935-12078-7-git-send-email-tony@atomide.com>
	<1205848935-12078-8-git-send-email-tony@atomide.com>
	<1205848935-12078-9-git-send-email-tony@atomide.com>
	<1205848935-12078-10-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
In-Reply-To: <1205848935-12078-10-git-send-email-tony@atomide.com>
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
patch. Also not all clocks are changed in this patch to limit the
size.

Also, the patch fixes few incorrect clock defines in clock24xx.h.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/Makefile      |    2 +-
 arch/arm/mach-omap2/clock24xx.c   |  318 +++++++++++++++++++++++--------------
 arch/arm/mach-omap2/clock24xx.h   |  320 ++++++++++++++++++++++++------------
 arch/arm/mach-omap2/memory.c      |   48 ++++++
 arch/arm/mach-omap2/memory.h      |    2 +
 arch/arm/plat-omap/clock.c        |   42 +++++
 include/asm-arm/arch-omap/clock.h |   65 ++++++--
 7 files changed, 560 insertions(+), 237 deletions(-)

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
index 4f79186..9363c20 100644
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
@@ -547,6 +621,7 @@ static struct prcm_config rate_table[] = {
  *	clocks.
  *-------------------------------------------------------------------------*/
 
+#ifdef OLD_CK
 /* Base external input clocks */
 static struct clk func_32k_ck = {
 	.name		= "func_32k_ck",
@@ -554,7 +629,7 @@ static struct clk func_32k_ck = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED,
 };
-
+#endif	/* OLD_CK */
 /* Typical 12/13MHz in standalone mode, will be 26Mhz in chassis mode */
 static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
@@ -570,10 +645,9 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.rate		= 13000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.rate_offset	= 6, /* sysclkdiv 1 or 2, already handled or no boot */
 	.recalc		= &omap2_sys_clk_recalc,
 };
-
+#ifdef OLD_CK
 static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.name		= "alt_ck",
 	.rate		= 54000000,
@@ -581,29 +655,43 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
 	.recalc		= &omap2_propagate_rate,
 };
-
+#endif	/* OLD_CK */
 /*
  * Analog domain root source clocks
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
@@ -611,15 +699,18 @@ static struct clk apll54_ck = {
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
+#ifdef OLD_CK
 static struct clk func_54m_ck = {
 	.name		= "func_54m_ck",
 	.parent		= &apll54_ck,	/* can also be alt_clk */
@@ -631,15 +722,15 @@ static struct clk func_54m_ck = {
 	.enable_bit	= 0xff,
 	.recalc		= &omap2_propagate_rate,
 };
-
+#endif	/* OLD_CK */
 static struct clk core_ck = {
 	.name		= "core_ck",
 	.parent		= &dpll_ck,		/* can also be 32k */
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
-	.recalc		= &omap2_propagate_rate,
+	.recalc		= &followparent_recalc,
 };
-
+#ifdef OLD_CK
 static struct clk sleep_ck = {		/* sys_clk or 32k */
 	.name		= "sleep_ck",
 	.parent		= &func_32k_ck,
@@ -726,7 +817,7 @@ static struct clk emul_ck = {
 	.recalc		= &omap2_propagate_rate,
 
 };
-
+#endif	/* OLD_CK */
 /*
  * MPU clock domain
  *	Clocks:
@@ -740,13 +831,17 @@ static struct clk emul_ck = {
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
 	.recalc		= &omap2_clksel_recalc,
+	.round_rate     = &omap2_clksel_round_rate,
+	.set_rate	= &omap2_clksel_set_rate
 };
-
+#ifdef OLD_CK
 /*
  * DSP (2430-IVA2.1) (2420-UMA+IVA1) clock domain
  * Clocks:
@@ -1933,7 +2028,7 @@ static struct clk mmchsdb2_fck = {
 	.enable_bit	= 17,
 	.recalc		= &omap2_followparent_recalc,
 };
-
+#endif	/* OLD_CK */
 /*
  * This clock is a composite clock which does entire set changes then
  * forces a rebalance. It keys on the MPU speed, but it really could
@@ -1953,11 +2048,10 @@ static struct clk virt_prcm_set = {
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				VIRTUAL_CLOCK | ALWAYS_ENABLED | DELAYED_APP,
 	.parent		= &mpu_ck,	/* Indexed by mpu speed, no parent */
-	.recalc		= &omap2_mpu_recalc,	/* sets are keyed on mpu rate */
 	.set_rate	= &omap2_select_table_rate,
 	.round_rate	= &omap2_round_to_table_rate,
 };
-
+#ifdef OLD_CK
 static struct clk *onchip_clks[] = {
 	/* external root sources */
 	&func_32k_ck,
@@ -2107,5 +2201,17 @@ static struct clk *onchip_clks[] = {
 	&mmchsdb1_fck,
 	&mmchsdb2_fck,
 };
+#endif	/* OLD_CK */
+
+static struct clk *onchip_24xx_clks[] __initdata = {
+	/* external root sources */
+	&osc_ck,
+	&sys_ck,
+	/* internal analog sources */
+	&dpll_ck,
+	&apll96_ck,
+	&apll54_ck,
+};
 
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
