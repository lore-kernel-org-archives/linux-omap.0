From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 81/86] [ARM] omap: arrange for clock recalc methods to return the rate
Date: Thu, 12 Mar 2009 11:28:31 -0700
Message-ID: <1236882516-29403-82-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-79-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-80-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-81-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.250]:55744 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757267AbZCLSeb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:31 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1107479agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:29 -0700 (PDT)
In-Reply-To: <1236882516-29403-81-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Russell King <rmk@dyn-67.arm.linux.org.uk>

linux-omap source commit 33d000c99ee393fe2042f93e8422f94976d276ce
introduces a way to "dry run" clock changes before they're committed.
However, this involves putting logic to handle this into each and
every recalc function, and unfortunately due to the caching, led to
some bugs.

Solve both of issues by making the recalc methods always return the
clock rate for the clock, which the caller decides what to do with.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap1/clock.c             |   32 +++++++++++-------------------
 arch/arm/mach-omap1/clock.h             |   10 ++++----
 arch/arm/mach-omap2/clock.c             |   17 ++++++++-------
 arch/arm/mach-omap2/clock.h             |    4 +-
 arch/arm/mach-omap2/clock24xx.c         |   20 +++++++++---------
 arch/arm/mach-omap2/clock24xx.h         |   10 ++++----
 arch/arm/mach-omap2/clock34xx.c         |   12 ++++++----
 arch/arm/mach-omap2/clock34xx.h         |    4 +-
 arch/arm/plat-omap/clock.c              |   15 +++++--------
 arch/arm/plat-omap/include/mach/clock.h |    4 +-
 10 files changed, 60 insertions(+), 68 deletions(-)

diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
index ccf989f..dafe4f7 100644
--- a/arch/arm/mach-omap1/clock.c
+++ b/arch/arm/mach-omap1/clock.c
@@ -156,27 +156,25 @@ __u32 arm_idlect1_mask;
  * Omap1 specific clock functions
  *-------------------------------------------------------------------------*/
 
-static void omap1_watchdog_recalc(struct clk * clk)
+static unsigned long omap1_watchdog_recalc(struct clk *clk)
 {
-	clk->rate = clk->parent->rate / 14;
+	return clk->parent->rate / 14;
 }
 
-static void omap1_uart_recalc(struct clk * clk)
+static unsigned long omap1_uart_recalc(struct clk *clk)
 {
 	unsigned int val = __raw_readl(clk->enable_reg);
-	if (val & clk->enable_bit)
-		clk->rate = 48000000;
-	else
-		clk->rate = 12000000;
+	return val & clk->enable_bit ? 48000000 : 12000000;
 }
 
-static void omap1_sossi_recalc(struct clk *clk)
+static unsigned long omap1_sossi_recalc(struct clk *clk)
 {
 	u32 div = omap_readl(MOD_CONF_CTRL_1);
 
 	div = (div >> 17) & 0x7;
 	div++;
-	clk->rate = clk->parent->rate / div;
+
+	return clk->parent->rate / div;
 }
 
 static int omap1_clk_enable_dsp_domain(struct clk *clk)
@@ -344,19 +342,15 @@ static int calc_dsor_exp(struct clk *clk, unsigned long rate)
 	return dsor_exp;
 }
 
-static void omap1_ckctl_recalc(struct clk * clk)
+static unsigned long omap1_ckctl_recalc(struct clk *clk)
 {
-	int dsor;
-
 	/* Calculate divisor encoded as 2-bit exponent */
-	dsor = 1 << (3 & (omap_readw(ARM_CKCTL) >> clk->rate_offset));
+	int dsor = 1 << (3 & (omap_readw(ARM_CKCTL) >> clk->rate_offset));
 
-	if (unlikely(clk->rate == clk->parent->rate / dsor))
-		return; /* No change, quick exit */
-	clk->rate = clk->parent->rate / dsor;
+	return clk->parent->rate / dsor;
 }
 
-static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
+static unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk)
 {
 	int dsor;
 
@@ -371,9 +365,7 @@ static void omap1_ckctl_recalc_dsp_domain(struct clk * clk)
 	dsor = 1 << (3 & (__raw_readw(DSP_CKCTL) >> clk->rate_offset));
 	omap1_clk_disable(&api_ck.clk);
 
-	if (unlikely(clk->rate == clk->parent->rate / dsor))
-		return; /* No change, quick exit */
-	clk->rate = clk->parent->rate / dsor;
+	return clk->parent->rate / dsor;
 }
 
 /* MPU virtual clock functions */
diff --git a/arch/arm/mach-omap1/clock.h b/arch/arm/mach-omap1/clock.h
index 28bc74e..17f8742 100644
--- a/arch/arm/mach-omap1/clock.h
+++ b/arch/arm/mach-omap1/clock.h
@@ -13,14 +13,14 @@
 #ifndef __ARCH_ARM_MACH_OMAP1_CLOCK_H
 #define __ARCH_ARM_MACH_OMAP1_CLOCK_H
 
-static void omap1_ckctl_recalc(struct clk * clk);
-static void omap1_watchdog_recalc(struct clk * clk);
+static unsigned long omap1_ckctl_recalc(struct clk *clk);
+static unsigned long omap1_watchdog_recalc(struct clk *clk);
 static int omap1_set_sossi_rate(struct clk *clk, unsigned long rate);
-static void omap1_sossi_recalc(struct clk *clk);
-static void omap1_ckctl_recalc_dsp_domain(struct clk * clk);
+static unsigned long omap1_sossi_recalc(struct clk *clk);
+static unsigned long omap1_ckctl_recalc_dsp_domain(struct clk *clk);
 static int omap1_clk_set_rate_dsp_domain(struct clk * clk, unsigned long rate);
 static int omap1_set_uart_rate(struct clk * clk, unsigned long rate);
-static void omap1_uart_recalc(struct clk * clk);
+static unsigned long omap1_uart_recalc(struct clk *clk);
 static int omap1_set_ext_clk_rate(struct clk * clk, unsigned long rate);
 static long omap1_round_ext_clk_rate(struct clk * clk, unsigned long rate);
 static void omap1_init_ext_clk(struct clk * clk);
diff --git a/arch/arm/mach-omap2/clock.c b/arch/arm/mach-omap2/clock.c
index 1b40d75..5020cb1 100644
--- a/arch/arm/mach-omap2/clock.c
+++ b/arch/arm/mach-omap2/clock.c
@@ -239,11 +239,11 @@ u32 omap2_get_dpll_rate(struct clk *clk)
  * Used for clocks that have the same value as the parent clock,
  * divided by some factor
  */
-void omap2_fixed_divisor_recalc(struct clk *clk)
+unsigned long omap2_fixed_divisor_recalc(struct clk *clk)
 {
 	WARN_ON(!clk->fixed_div);
 
-	clk->rate = clk->parent->rate / clk->fixed_div;
+	return clk->parent->rate / clk->fixed_div;
 }
 
 /**
@@ -449,21 +449,22 @@ err:
  * Used for clocks that are part of CLKSEL_xyz governed clocks.
  * REVISIT: Maybe change to use clk->enable() functions like on omap1?
  */
-void omap2_clksel_recalc(struct clk *clk)
+unsigned long omap2_clksel_recalc(struct clk *clk)
 {
+	unsigned long rate;
 	u32 div = 0;
 
 	pr_debug("clock: recalc'ing clksel clk %s\n", clk->name);
 
 	div = omap2_clksel_get_divisor(clk);
 	if (div == 0)
-		return;
+		return clk->rate;
 
-	if (clk->rate == (clk->parent->rate / div))
-		return;
-	clk->rate = clk->parent->rate / div;
+	rate = clk->parent->rate / div;
+
+	pr_debug("clock: new clock rate is %ld (div %d)\n", rate, div);
 
-	pr_debug("clock: new clock rate is %ld (div %d)\n", clk->rate, div);
+	return rate;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 90077f0..ca6bf22 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -36,7 +36,7 @@ void omap2_clk_disable_unused(struct clk *clk);
 #define omap2_clk_disable_unused	NULL
 #endif
 
-void omap2_clksel_recalc(struct clk *clk);
+unsigned long omap2_clksel_recalc(struct clk *clk);
 void omap2_init_clk_clkdm(struct clk *clk);
 void omap2_init_clksel_parent(struct clk *clk);
 u32 omap2_clksel_get_divisor(struct clk *clk);
@@ -44,7 +44,7 @@ u32 omap2_clksel_round_rate_div(struct clk *clk, unsigned long target_rate,
 				u32 *new_div);
 u32 omap2_clksel_to_divisor(struct clk *clk, u32 field_val);
 u32 omap2_divisor_to_clksel(struct clk *clk, u32 div);
-void omap2_fixed_divisor_recalc(struct clk *clk);
+unsigned long omap2_fixed_divisor_recalc(struct clk *clk);
 long omap2_clksel_round_rate(struct clk *clk, unsigned long target_rate);
 int omap2_clksel_set_rate(struct clk *clk, unsigned long rate);
 u32 omap2_get_dpll_rate(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
index 069f3e1..f2b74e9 100644
--- a/arch/arm/mach-omap2/clock24xx.c
+++ b/arch/arm/mach-omap2/clock24xx.c
@@ -369,9 +369,9 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 
 }
 
-static void omap2_dpllcore_recalc(struct clk *clk)
+static unsigned long omap2_dpllcore_recalc(struct clk *clk)
 {
-	clk->rate = omap2_get_dpll_rate_24xx(clk);
+	return omap2_get_dpll_rate_24xx(clk);
 }
 
 static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
@@ -448,9 +448,9 @@ static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
  *
  * Set virt_prcm_set's rate to the mpu_speed field of the current PRCM set.
  */
-static void omap2_table_mpu_recalc(struct clk *clk)
+static unsigned long omap2_table_mpu_recalc(struct clk *clk)
 {
-	clk->rate = curr_prcm_set->mpu_speed;
+	return curr_prcm_set->mpu_speed;
 }
 
 /*
@@ -647,14 +647,14 @@ static u32 omap2_get_sysclkdiv(void)
 	return div;
 }
 
-static void omap2_osc_clk_recalc(struct clk *clk)
+static unsigned long omap2_osc_clk_recalc(struct clk *clk)
 {
-	clk->rate = omap2_get_apll_clkin() * omap2_get_sysclkdiv();
+	return omap2_get_apll_clkin() * omap2_get_sysclkdiv();
 }
 
-static void omap2_sys_clk_recalc(struct clk *clk)
+static unsigned long omap2_sys_clk_recalc(struct clk *clk)
 {
-	clk->rate = clk->parent->rate / omap2_get_sysclkdiv();
+	return clk->parent->rate / omap2_get_sysclkdiv();
 }
 
 /*
@@ -707,9 +707,9 @@ int __init omap2_clk_init(void)
 
 	clk_init(&omap2_clk_functions);
 
-	omap2_osc_clk_recalc(&osc_ck);
+	osc_ck.rate = omap2_osc_clk_recalc(&osc_ck);
 	propagate_rate(&osc_ck);
-	omap2_sys_clk_recalc(&sys_ck);
+	sys_ck.rate = omap2_sys_clk_recalc(&sys_ck);
 	propagate_rate(&sys_ck);
 
 	for (c = omap24xx_clks; c < omap24xx_clks + ARRAY_SIZE(omap24xx_clks); c++)
diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 7594898..11da621 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -24,13 +24,13 @@
 #include "cm-regbits-24xx.h"
 #include "sdrc.h"
 
-static void omap2_table_mpu_recalc(struct clk *clk);
+static unsigned long omap2_table_mpu_recalc(struct clk *clk);
 static int omap2_select_table_rate(struct clk *clk, unsigned long rate);
 static long omap2_round_to_table_rate(struct clk *clk, unsigned long rate);
-static void omap2_sys_clk_recalc(struct clk *clk);
-static void omap2_osc_clk_recalc(struct clk *clk);
-static void omap2_sys_clk_recalc(struct clk *clk);
-static void omap2_dpllcore_recalc(struct clk *clk);
+static unsigned long omap2_sys_clk_recalc(struct clk *clk);
+static unsigned long omap2_osc_clk_recalc(struct clk *clk);
+static unsigned long omap2_sys_clk_recalc(struct clk *clk);
+static unsigned long omap2_dpllcore_recalc(struct clk *clk);
 static int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate);
 
 /* Key dividers which make up a PRCM set. Ratio's for a PRCM are mandated.
diff --git a/arch/arm/mach-omap2/clock34xx.c b/arch/arm/mach-omap2/clock34xx.c
index 3b6e27b..fb0f53b 100644
--- a/arch/arm/mach-omap2/clock34xx.c
+++ b/arch/arm/mach-omap2/clock34xx.c
@@ -289,9 +289,9 @@ static struct omap_clk omap34xx_clks[] = {
  *
  * Recalculate and propagate the DPLL rate.
  */
-static void omap3_dpll_recalc(struct clk *clk)
+static unsigned long omap3_dpll_recalc(struct clk *clk)
 {
-	clk->rate = omap2_get_dpll_rate(clk);
+	return omap2_get_dpll_rate(clk);
 }
 
 /* _omap3_dpll_write_clken - write clken_bits arg to a DPLL's enable bits */
@@ -787,9 +787,10 @@ static void omap3_dpll_deny_idle(struct clk *clk)
  * Using parent clock DPLL data, look up DPLL state.  If locked, set our
  * rate to the dpll_clk * 2; otherwise, just use dpll_clk.
  */
-static void omap3_clkoutx2_recalc(struct clk *clk)
+static unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 {
 	const struct dpll_data *dd;
+	unsigned long rate;
 	u32 v;
 	struct clk *pclk;
 
@@ -808,9 +809,10 @@ static void omap3_clkoutx2_recalc(struct clk *clk)
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
 	if (v != DPLL_LOCKED)
-		clk->rate = clk->parent->rate;
+		rate = clk->parent->rate;
 	else
-		clk->rate = clk->parent->rate * 2;
+		rate = clk->parent->rate * 2;
+	return rate;
 }
 
 /* Common clock code */
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 2138a58..764c7cd 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -27,8 +27,8 @@
 #include "prm.h"
 #include "prm-regbits-34xx.h"
 
-static void omap3_dpll_recalc(struct clk *clk);
-static void omap3_clkoutx2_recalc(struct clk *clk);
+static unsigned long omap3_dpll_recalc(struct clk *clk);
+static unsigned long omap3_clkoutx2_recalc(struct clk *clk);
 static void omap3_dpll_allow_idle(struct clk *clk);
 static void omap3_dpll_deny_idle(struct clk *clk);
 static u32 omap3_dpll_autoidle_read(struct clk *clk);
diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 9833d73..08baa18 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -126,7 +126,7 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 		ret = arch_clock->clk_set_rate(clk, rate);
 	if (ret == 0) {
 		if (clk->recalc)
-			clk->recalc(clk);
+			clk->rate = clk->recalc(clk);
 		propagate_rate(clk);
 	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
@@ -148,7 +148,7 @@ int clk_set_parent(struct clk *clk, struct clk *parent)
 		ret = arch_clock->clk_set_parent(clk, parent);
 	if (ret == 0) {
 		if (clk->recalc)
-			clk->recalc(clk);
+			clk->rate = clk->recalc(clk);
 		propagate_rate(clk);
 	}
 	spin_unlock_irqrestore(&clockfw_lock, flags);
@@ -188,12 +188,9 @@ static int __init omap_clk_setup(char *str)
 __setup("mpurate=", omap_clk_setup);
 
 /* Used for clocks that always have same value as the parent clock */
-void followparent_recalc(struct clk *clk)
+unsigned long followparent_recalc(struct clk *clk)
 {
-	if (clk == NULL || IS_ERR(clk))
-		return;
-
-	clk->rate = clk->parent->rate;
+	return clk->parent->rate;
 }
 
 void clk_reparent(struct clk *child, struct clk *parent)
@@ -214,7 +211,7 @@ void propagate_rate(struct clk * tclk)
 
 	list_for_each_entry(clkp, &tclk->children, sibling) {
 		if (clkp->recalc)
-			clkp->recalc(clkp);
+			clkp->rate = clkp->recalc(clkp);
 		propagate_rate(clkp);
 	}
 }
@@ -234,7 +231,7 @@ void recalculate_root_clocks(void)
 
 	list_for_each_entry(clkp, &root_clks, sibling) {
 		if (clkp->recalc)
-			clkp->recalc(clkp);
+			clkp->rate = clkp->recalc(clkp);
 		propagate_rate(clkp);
 	}
 }
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-omap/include/mach/clock.h
index 0ba2846..7b6f6bc 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -75,7 +75,7 @@ struct clk {
 	unsigned long		rate;
 	__u32			flags;
 	void __iomem		*enable_reg;
-	void			(*recalc)(struct clk *);
+	unsigned long		(*recalc)(struct clk *);
 	int			(*set_rate)(struct clk *, unsigned long);
 	long			(*round_rate)(struct clk *, unsigned long);
 	void			(*init)(struct clk *);
@@ -123,7 +123,7 @@ extern void clk_reparent(struct clk *child, struct clk *parent);
 extern void clk_unregister(struct clk *clk);
 extern void propagate_rate(struct clk *clk);
 extern void recalculate_root_clocks(void);
-extern void followparent_recalc(struct clk *clk);
+extern unsigned long followparent_recalc(struct clk *clk);
 extern void clk_enable_init_clocks(void);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
-- 
1.6.1.2

