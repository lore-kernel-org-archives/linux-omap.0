From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCHV4 1/3] OMAP3: introduce DPLL4 Jtype
Date: Tue,  5 Jan 2010 12:06:08 +0530
Message-ID: <1262673370-5757-2-git-send-email-vishwanath.bs@ti.com>
References: <1262673370-5757-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35752 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752382Ab0AEGdh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Jan 2010 01:33:37 -0500
In-Reply-To: <1262673370-5757-1-git-send-email-vishwanath.bs@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>, Paul Walmsley <paul@pwsan.com>, Richard Woodruff <r-woodruff2@ti.com>, Nishanth Menon <nm@ti.com>, Vishwanath BS <Vishwanath.bs@ti.com>

DPLL4 for 3630 introduces a changed block requiring special divisor
bits and additional reg fields. To allow for silicons to use this, this
is introduced as a omap3_has_jtype_dpll4() and is enabled for 3630
silicon. Also FREQSEL field is no longer valid for OMAP3630. So reference
to this is removed for 3630.

Tested with 3630 ZOOM3 and OMAP3430 ZOOM2

Cc: Paul Walmsley <paul@pwsan.com>

Signed-off-by: Richard Woodruff <r-woodruff2@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Vishwanath BS <Vishwanath.bs@ti.com>
---
 arch/arm/mach-omap2/clock.h             |    3 ++
 arch/arm/mach-omap2/clock34xx_data.c    |    2 +
 arch/arm/mach-omap2/clock44xx_data.c    |    1 +
 arch/arm/mach-omap2/cm-regbits-34xx.h   |    6 +++-
 arch/arm/mach-omap2/dpll.c              |   53 ++++++++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/clock.h |    1 +
 6 files changed, 61 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
index 93c48df..14f73e7 100644
--- a/arch/arm/mach-omap2/clock.h
+++ b/arch/arm/mach-omap2/clock.h
@@ -47,6 +47,9 @@
 #define DPLL_LOW_POWER_BYPASS	0x5
 #define DPLL_LOCKED		0x7
 
+/*DPLL Type and DCO Selection Flags*/
+#define DPLL_J_TYPE	0x1
+#define DPLL_NO_DCO_SEL	0x2
 int omap2_clk_init(void);
 int omap2_clk_enable(struct clk *clk);
 void omap2_clk_disable(struct clk *clk);
diff --git a/arch/arm/mach-omap2/clock34xx_data.c b/arch/arm/mach-omap2/clock34xx_data.c
index 043caed..9aac354 100644
--- a/arch/arm/mach-omap2/clock34xx_data.c
+++ b/arch/arm/mach-omap2/clock34xx_data.c
@@ -3241,6 +3241,8 @@ int __init omap2_clk_init(void)
 			cpu_clkflg |= CK_3430ES2;
 		}
 	}
+	if (cpu_is_omap3630())
+		dpll4_ck.dpll_data->flags |= DPLL_J_TYPE;
 
 	clk_init(&omap2_clk_functions);
 
diff --git a/arch/arm/mach-omap2/clock44xx_data.c b/arch/arm/mach-omap2/clock44xx_data.c
index 2210e22..7347246 100644
--- a/arch/arm/mach-omap2/clock44xx_data.c
+++ b/arch/arm/mach-omap2/clock44xx_data.c
@@ -2736,6 +2736,7 @@ int __init omap2_clk_init(void)
 	if (cpu_is_omap44xx()) {
 		cpu_mask = RATE_IN_4430;
 		cpu_clkflg = CK_443X;
+		dpll_usb_ck.dpll_data->flags |= DPLL_NO_DCO_SEL | DPLL_J_TYPE;
 	}
 
 	clk_init(&omap2_clk_functions);
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
index f6055b4..d52ab37 100644
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
+	if (mod1 + mod2)
+		sd++;
+	*sd_div = sd;
+}
+
+/**
  * omap3_noncore_dpll_enable - instruct a DPLL to enter bypass or lock mode
  * @clk: pointer to a DPLL struct clk
  *
@@ -311,7 +347,7 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
 	_omap3_noncore_dpll_bypass(clk);
 
 	/* Set jitter correction */
-	if (!cpu_is_omap44xx()) {
+	if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 		v = __raw_readl(dd->control_reg);
 		v &= ~dd->freqsel_mask;
 		v |= freqsel << __ffs(dd->freqsel_mask);
@@ -323,6 +359,15 @@ int omap3_noncore_dpll_program(struct clk *clk, u16 m, u8 n, u16 freqsel)
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
 	__raw_writel(v, dd->mult_div1_reg);
 
 	/* We let the clock framework set the other output dividers later */
@@ -384,8 +429,8 @@ int omap3_noncore_dpll_set_rate(struct clk *clk, unsigned long rate)
 		if (dd->last_rounded_rate == 0)
 			return -EINVAL;
 
-		/* No freqsel on OMAP4 */
-		if (!cpu_is_omap44xx()) {
+		/* No freqsel on OMAP4 and OMAP3630 */
+		if (!cpu_is_omap44xx() && !cpu_is_omap3630()) {
 			freqsel = _omap3_dpll_compute_freqsel(clk,
 						dd->last_rounded_n);
 			if (!freqsel)
@@ -530,7 +575,7 @@ unsigned long omap3_clkoutx2_recalc(struct clk *clk)
 
 	v = __raw_readl(dd->control_reg) & dd->enable_mask;
 	v >>= __ffs(dd->enable_mask);
-	if (v != OMAP3XXX_EN_DPLL_LOCKED)
+	if ((v != OMAP3XXX_EN_DPLL_LOCKED) || (dd->flags & DPLL_J_TYPE))
 		rate = clk->parent->rate;
 	else
 		rate = clk->parent->rate * 2;
diff --git a/arch/arm/plat-omap/include/plat/clock.h b/arch/arm/plat-omap/include/plat/clock.h
index 309b6d1..15d0d9a 100644
--- a/arch/arm/plat-omap/include/plat/clock.h
+++ b/arch/arm/plat-omap/include/plat/clock.h
@@ -62,6 +62,7 @@ struct dpll_data {
 	void __iomem		*idlest_reg;
 	u32			autoidle_mask;
 	u32			freqsel_mask;
+	u8			flags;
 	u32			idlest_mask;
 	u8			auto_recal_bit;
 	u8			recal_en_bit;
-- 
1.5.6.3

