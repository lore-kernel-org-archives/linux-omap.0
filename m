From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] 3430 clock: add emulation clocks
Date: Mon, 12 Nov 2007 03:57:28 -0700
Message-ID: <20071112110147.888074620@pwsan.com>
References: <20071112105726.514186925@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline; filename=add_emu_clks.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add clocks for the EMU domain for OMAP3430.  Richard Woodruff mentions that
documentation for these clocks, beyond the register bit settings found
in the main 3430 TRM, can be found in several other documents: the 3430 
Emulation TRM; also SPRU893 and SPRU928; and some documents from 
ARM Ltd including CoreSight, ETM, and ARM debug v5 architecture.  
Some information is also available in the ARM Cortex-A8 TRM, section 10.1.  

Also, rename existing emul_* clocks to emu_* to conform with recent TRMs.

Signed-off-by: Paul Walmsley <paul@pwsan.com>

---
 arch/arm/mach-omap2/clock34xx.h |  173 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 8 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/clock34xx.h
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/clock34xx.h	2007-11-08 13:05:47.000000000 -0700
+++ linux-omap/arch/arm/mach-omap2/clock34xx.h	2007-11-08 13:05:58.000000000 -0700
@@ -235,6 +235,17 @@
 	.recalc		= &omap3_dpll_recalc,
 };
 
+/*
+ * REVISIT: This clock is never specifically defined in the 3430 TRM,
+ * although it is referenced - so this is a guess
+ */
+static struct clk emu_mpu_alwon_ck = {
+	.name		= "emu_mpu_alwon_ck",
+	.parent		= &dpll1_ck,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
+	.recalc		= &followparent_recalc,
+};
+
 /* DPLL2 */
 /* IVA2 clock source */
 /* Type: DPLL */
@@ -371,14 +382,14 @@
 	{ .parent = NULL }
 };
 
-static struct clk emul_core_alwon_ck = {
-	.name		= "emul_core_alwon_ck",
+static struct clk emu_core_alwon_ck = {
+	.name		= "emu_core_alwon_ck",
 	.parent		= &dpll3_x2_ck,
 	.init		= &omap2_init_clksel_parent,
 	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
 	.clksel_mask	= OMAP3430_DIV_DPLL3_MASK,
 	.clksel		= div16_dpll3_clksel,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -571,10 +582,10 @@
 	.recalc		= &omap2_clksel_recalc,
 };
 
-static struct clk emul_per_alwon_ck = {
-	.name		= "emul_per_alwon_ck",
+static struct clk emu_per_alwon_ck = {
+	.name		= "emu_per_alwon_ck",
 	.parent		= &dpll4_m6x2_ck,
-	.flags		= CLOCK_IN_OMAP343X,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES,
 	.recalc		= &followparent_recalc,
 };
 
@@ -2001,6 +2012,145 @@
 	.recalc		= &omap2_clksel_recalc,
 };
 
+/* EMU clocks */
+
+/* More information: ARM Cortex-A8 Technical Reference Manual, sect 10.1 */
+
+static const struct clksel_rate emu_src_sys_rates[] = {
+	{ .div = 1, .val = 0, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate emu_src_core_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate emu_src_per_rates[] = {
+	{ .div = 1, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel_rate emu_src_mpu_rates[] = {
+	{ .div = 1, .val = 3, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 0 },
+};
+
+static const struct clksel emu_src_clksel[] = {
+	{ .parent = &sys_ck,		.rates = emu_src_sys_rates },
+	{ .parent = &emu_core_alwon_ck, .rates = emu_src_core_rates },
+	{ .parent = &emu_per_alwon_ck,	.rates = emu_src_per_rates },
+	{ .parent = &emu_mpu_alwon_ck,	.rates = emu_src_mpu_rates },
+	{ .parent = NULL },
+};
+
+/*
+ * Like the clkout_src clocks, emu_src_clk is a virtual clock, existing only
+ * to switch the source of some of the EMU clocks.
+ * XXX Are there CLKEN bits for these EMU clks?
+ */
+static struct clk emu_src_ck = {
+	.name		= "emu_src_ck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_MUX_CTRL_MASK,
+	.clksel		= emu_src_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate pclk_emu_rates[] = {
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 6, .val = 6, .flags = RATE_IN_343X },
+	{ .div = 0 },
+};
+
+static const struct clksel pclk_emu_clksel[] = {
+	{ .parent = &emu_src_ck, .rates = pclk_emu_rates },
+	{ .parent = NULL },
+};
+
+static struct clk pclk_fck = {
+	.name		= "pclk_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_CLKSEL_PCLK_MASK,
+	.clksel		= pclk_emu_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate pclkx2_emu_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 3, .val = 3, .flags = RATE_IN_343X },
+	{ .div = 0 },
+};
+
+static const struct clksel pclkx2_emu_clksel[] = {
+	{ .parent = &emu_src_ck, .rates = pclkx2_emu_rates },
+	{ .parent = NULL },
+};
+
+static struct clk pclkx2_fck = {
+	.name		= "pclkx2_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_CLKSEL_PCLKX2_MASK,
+	.clksel		= pclkx2_emu_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel atclk_emu_clksel[] = {
+	{ .parent = &emu_src_ck, .rates = div2_rates },
+	{ .parent = NULL },
+};
+
+static struct clk atclk_fck = {
+	.name		= "atclk_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_CLKSEL_ATCLK_MASK,
+	.clksel		= atclk_emu_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static struct clk traceclk_src_fck = {
+	.name		= "traceclk_src_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_TRACE_MUX_CTRL_MASK,
+	.clksel		= emu_src_clksel,
+	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
+static const struct clksel_rate traceclk_rates[] = {
+	{ .div = 1, .val = 1, .flags = RATE_IN_343X | DEFAULT_RATE },
+	{ .div = 2, .val = 2, .flags = RATE_IN_343X },
+	{ .div = 4, .val = 4, .flags = RATE_IN_343X },
+	{ .div = 0 },
+};
+
+static const struct clksel traceclk_clksel[] = {
+	{ .parent = &traceclk_src_fck, .rates = traceclk_rates },
+	{ .parent = NULL },
+};
+
+static struct clk traceclk_fck = {
+	.name		= "traceclk_fck",
+	.init		= &omap2_init_clksel_parent,
+	.clksel_reg	= OMAP_CM_REGADDR(OMAP3430_EMU_MOD, CM_CLKSEL1),
+	.clksel_mask	= OMAP3430_CLKSEL_TRACECLK_MASK,
+	.clksel		= traceclk_clksel,
+	.flags		= CLOCK_IN_OMAP343X | ALWAYS_ENABLED,
+	.recalc		= &omap2_clksel_recalc,
+};
+
 /* SR clocks */
 
 /* SmartReflex fclk (VDD1) */
@@ -2060,6 +2210,7 @@
 	&sys_altclk,
 	&sys_clkout1,
 	&dpll1_ck,
+	&emu_mpu_alwon_ck,
 	&dpll2_ck,
 	&dpll3_ck,
 	&core_ck,
@@ -2067,7 +2218,7 @@
 	&dpll3_m2_ck,
 	&dpll3_m2x2_ck,
 	&dpll3_m3x2_ck,
-	&emul_core_alwon_ck,
+	&emu_core_alwon_ck,
 	&dpll4_ck,
 	&dpll4_x2_ck,
 	&omap_96m_alwon_fck,
@@ -2081,7 +2232,7 @@
 	&dpll4_m4x2_ck,
 	&dpll4_m5x2_ck,
 	&dpll4_m6x2_ck,
-	&emul_per_alwon_ck,
+	&emu_per_alwon_ck,
 	&clkout2_src_ck,
 	&sys_clkout2,
 	&corex2_fck,
@@ -2216,6 +2367,12 @@
 	&mcbsp2_fck,
 	&mcbsp3_fck,
 	&mcbsp4_fck,
+	&emu_src_ck,
+	&pclk_fck,
+	&pclkx2_fck,
+	&atclk_fck,
+	&traceclk_src_fck,
+	&traceclk_fck,
 	&sr1_fck,
 	&sr2_fck,
 	&sr_l4_ick,

-- 
