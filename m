From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV5 1/4] OMAP3: introduce DPLL4 Jtype
Date: Mon, 18 Jan 2010 13:59:19 +0530
Message-ID: <1263803362-7083-2-git-send-email-vishwanath.bs@ti.com>
References: <1263803362-7083-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60347 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932108Ab0ARI0H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 18 Jan 2010 03:26:07 -0500
In-Reply-To: <1263803362-7083-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Nishanth Menon <nm@ti.com>, Vishwanath BS <Vishwanath.bs@ti.com>

DPLL4 for 3630 introduces a changed block called j type dpll, requiring
special divisor bits and additional reg fields. To allow for silicons to
use this, this is introduced as a flag and is enabled for 3630 silicon.
OMAP4 also has j type dpll for usb.

Tested with 3630 ZOOM3 and OMAP3430 ZOOM2

Cc: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock.h             |    4 ++
 arch/arm/mach-omap2/clock34xx_data.c    |   32 ++++++++++++++++++++-
 arch/arm/mach-omap2/clock44xx_data.c    |    1 +
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    6 +++-
 arch/arm/mach-omap2/dpll.c              |   48 ++++++++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/clock.h |    5 +++
 6 files changed, 93 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 93c48df..3216f9c
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -47,6 +47,10 @@
 #define DPLL_LOW_POWER_BYPASS	0x5
 #define DPLL_LOCKED		0x7
 
+/* DPLL Type and DCO Selection Flags */
+#define DPLL_J_TYPE	0x1
+#define DPLL_NO_DCO_SEL	0x2
+
 int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index f5ef08d..152cd3c
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -529,7 +529,8 @@ static struct clk emu_core_alwon_ck = {
 /* DPLL4 */
 /* Supplies 96MHz, 54Mhz TV DAC, DSS fclk, CAM sensor clock, emul trace clk */
 /* Type: DPLL */
-static struct dpll_data dpll4_dd = {
+static struct dpll_data dpll4_dd;
+static struct dpll_data dpll4_dd_34xx __initdata = {
 	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
 	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
 	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
@@ -552,6 +553,30 @@ static struct dpll_data dpll4_dd = {
 	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE
 };
 
+static struct dpll_data dpll4_dd_3630 __initdata = {
+	.mult_div1_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKSEL2),
+	.mult_mask	= OMAP3430_PERIPH_DPLL_MULT_MASK,
+	.div1_mask	= OMAP3430_PERIPH_DPLL_DIV_MASK,
+	.clk_bypass	= &sys_ck,
+	.clk_ref	= &sys_ck,
+	.freqsel_mask	= OMAP3430_PERIPH_DPLL_FREQSEL_MASK,
+	.control_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_CLKEN),
+	.enable_mask	= OMAP3430_EN_PERIPH_DPLL_MASK,
+	.modes		= (1 << DPLL_LOW_POWER_STOP) | (1 << DPLL_LOCKED),
+	.auto_recal_bit	= OMAP3430_EN_PERIPH_DPLL_DRIFTGUARD_SHIFT,
+	.recal_en_bit	= OMAP3430_PERIPH_DPLL_RECAL_EN_SHIFT,
+	.recal_st_bit	= OMAP3430_PERIPH_DPLL_ST_SHIFT,
+	.autoidle_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_AUTOIDLE),
+	.autoidle_mask	= OMAP3430_AUTO_PERIPH_DPLL_MASK,
+	.idlest_reg	= OMAP_CM_REGADDR(PLL_MOD, CM_IDLEST),
+	.idlest_mask	= OMAP3430_ST_PERIPH_CLK_MASK,
+	.max_multiplier = OMAP3_MAX_DPLL_MULT,
+	.min_divider	= 1,
+	.max_divider	= OMAP3_MAX_DPLL_DIV,
+	.rate_tolerance = DEFAULT_DPLL_RATE_TOLERANCE,
+	.flags		= DPLL_J_TYPE
+};
+
 static struct clk dpll4_ck = {
 	.name		= "dpll4_ck",
 	.ops		= &clkops_noncore_dpll_ops,
@@ -3246,6 +3271,11 @@ int __init omap2_clk_init(void)
 		}
 	}
 
+	if (cpu_is_omap3630())
+		dpll4_dd = dpll4_dd_3630;
+	else
+		dpll4_dd = dpll4_dd_34xx;
+
 	clk_init(&omap2_clk_functions);
 
 	for (c = omap3xxx_clks; c < omap3xxx_clks + ARRAY_SIZE(omap3xxx_clks); c++)
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2210e22..a95930e 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -980,6 +980,7 @@ static struct dpll_data dpll_usb_dd = {
 	.max_multiplier	= OMAP4430_MAX_DPLL_MULT,
 	.max_divider	= OMAP4430_MAX_DPLL_DIV,
 	.min_divider	= 1,
+	.flags		= DPLL_J_TYPE | DPLL_NO_DCO_SEL
 };
 
 
diff --git a/arch/arm/mach-omap2/cm-regbits-34xx.h b/arch/arm/mach-omap2/cm-regbits-34xx.h
index 6923deb..6f2802b 100644
--- a/arch/arm/mach-omap2/cm-regbits-34xx.h
+++ b/arch/arm/mach-omap2/cm-regbits-34xx.h
@@ -516,9 +516,13 @@
 
 /* CM_CLKSEL2_PLL */
 #define OMAP3430_PERIPH_DPLL_MULT_SHIFT			8
-#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0x7ff << 8)
+#define OMAP3430_PERIPH_DPLL_MULT_MASK			(0xfff << 8)
 #define OMAP3430_PERIPH_DPLL_DIV_SHIFT			0
 #define OMAP3430_PERIPH_DPLL_DIV_MASK			(0x7f << 0)
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_SHIFT		21
+#define OMAP3630_PERIPH_DPLL_DCO_SEL_MASK		(0x7 << 21)
+#define OMAP3630_PERIPH_DPLL_SD_DIV_SHIFT		24
+#define OMAP3630_PERIPH_DPLL_SD_DIV_MASK		(0xff << 24)
 
 /* CM_CLKSEL3_PLL */
 #define OMAP3430_DIV_96M_SHIFT				0
diff --git a/arch/arm/mach-omap2/dpll.c b/arch/arm/mach-omap2/dpll.c
index f6055b4..87a5529
--- a/arch/arm/mach-omap2/dpll.c
+++ b/arch/arm/mach-omap2/dpll.c
@@ -238,6 +238,42 @@ static int _omap3_noncore_dpll_stop(struct clk *clk)
 }
 
 /**
+ * lookup_dco_sddiv -  Set j-type DPLL4 compensation variables
+ * @clk: pointer to a DPLL struct clk
+ * @dco: digital control oscillator selector
+ * @sd_div: target sigma-delta divider
+ * @m: DPLL multiplier to set
+ * @n: DPLL divider to set
+ */
+static void lookup_dco_sddiv(struct clk *clk, u8 *dco, u8 *sd_div, u16
+								m, u8 n)
+	{
+	unsigned long fint, clkinp, sd; /* watch out for overflow */
+	int mod1, mod2;
+
+	clkinp = clk->parent->rate;
+	fint = (clkinp / n) * m;
+
+	if (fint < 1000000000)
+		*dco = 2;
+	else
+		*dco = 4;
+	/*
+	 * target sigma-delta to near 250MHz
+	 * sd = ceil[(m/(n+1)) * (clkinp_MHz / 250)]
+	 */
+	clkinp /= 100000; /* shift from MHz to 10*Hz for 38.4 and 19.2*/
+	mod1 = (clkinp * m) % (250 * n);
+	sd = (clkinp * m) / (250 * n);
+	mod2 = sd % 10;
+	sd /= 10;
+
+	if (mod1 || mod2)
+		sd++;
+	*sd_div = sd;
+}
+
+/**
  * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock mode
  * @clk: pointer to a DPLL struct clk
  *
@@ -323,6 +359,16 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	v &= ~(dd->mult_mask | dd->div1_mask);
 	v |= m << __ffs(dd->mult_mask);
 	v |= (n - 1) << __ffs(dd->div1_mask);
+
+      if ((dd->flags & DPLL_J_TYPE) && !(dd->flags & DPLL_NO_DCO_SEL)) {
+		u8 dco, sd_div;
+		lookup_dco_sddiv(clk, &dco, &sd_div, m, n);
+		v &= ~(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK
+			| OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+		v |=  dco << __ffs(OMAP3630_PERIPH_DPLL_DCO_SEL_MASK);
+		v |=  sd_div << __ffs(OMAP3630_PERIPH_DPLL_SD_DIV_MASK);
+	}
+
 	__raw_writel(v, dd->mult_div1_reg);
 
 	/* We let the clock framework set the other output dividers later */
@@ -530,7 +576,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
-	if (v != OMAP3XXX_EN_DPLL_LOCKED)
+	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate = clk->parent->rate;
 	else
 		rate = clk->parent->rate * 2;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 94fe2a0..064267a
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -40,6 +40,10 @@ struct clksel {
 	const struct clksel_rate *rates;
 };
 
+/* A new flag called flag has been added which indiciates what is the type
+  * of dpll (like j_type, no_dco_sel)
+  */
+
 struct dpll_data {
 	void __iomem		*mult_div1_reg;
 	u32			mult_mask;
@@ -62,6 +66,7 @@ struct dpll_data {
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
 	u32			freqsel_mask;
+	u8			flags;
 	u32			idlest_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
-- 
1.5.6.3

