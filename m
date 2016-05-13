From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] clk: ti: Add support for basic clk_set_rate for dm814x and j5-eco ADPLL
Date: Fri, 13 May 2016 09:40:53 -0700
Message-ID: <1463157653-9404-1-git-send-email-tony@atomide.com>
Return-path: <linux-clk-owner@vger.kernel.org>
Sender: linux-clk-owner@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Tero Kristo <t-kristo@ti.com>
Cc: linux-clk@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Brian Hutchinson <b.hutchman@gmail.com>, Delio Brignoli <dbrignoli@audioscience.com>, Neil Armstrong <narmstrong@baylibre.com>, Nicolas Chauvet <kwizart@gmail.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Philipp Rosenberger <ilu@linutronix.de>
List-Id: linux-omap@vger.kernel.org

Here's basic clk_set_rate support for the dm814x and j5-eco ADPLL.

Note that to clk_get the ADPLL clocks without a DTS phandle, you need to
use the generated names like "pll1a0dco", "pll1a0m2" and "pll1a0clkout".
The ADPLL driver is now enabled for dm814x and j5-eco starting with
v4.6-rc6, so there are no longer other pending dependencies.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/clk/ti/adpll.c | 182 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/clk/ti/adpll.c b/drivers/clk/ti/adpll.c
index 255cafb..ff8ecfa 100644
--- a/drivers/clk/ti/adpll.c
+++ b/drivers/clk/ti/adpll.c
@@ -17,6 +17,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
+#include <linux/rational.h>
 #include <linux/string.h>
 
 #define ADPLL_PLLSS_MMR_LOCK_OFFSET	0x00	/* Managed by MPPULL */
@@ -54,12 +55,17 @@
 #define ADPLL_M2NDIV_M2			16
 #define ADPLL_M2NDIV_M2_ADPLL_S_WIDTH	5
 #define ADPLL_M2NDIV_M2_ADPLL_LJ_WIDTH	7
+#define TI_ADPLL_DIV_N_MAX		GENMASK(7, 0)
 
 #define ADPLL_MN2DIV_OFFSET		0x14
 #define ADPLL_MN2DIV_N2			16
+#define TI_ADPLL_MIN_MULT_M		2
+#define TI_ADPLL_MULT_M_MAX		(GENMASK(11, 0) + 1)
 
 #define ADPLL_FRACDIV_OFFSET		0x18
 #define ADPLL_FRACDIV_REGSD		24
+#define TI814X_ADPLLJ_MIN_SD_DIV	2
+#define TI814X_ADPLLJ_MAX_SD_DIV	255
 #define ADPLL_FRACDIV_FRACTIONALM	0
 #define ADPLL_FRACDIV_FRACTIONALM_MASK	0x3ffff
 
@@ -480,6 +486,180 @@ static unsigned long ti_adpll_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
+static long ti_adpll_calc_n_m(struct ti_adpll_dco_data *dco,
+			      unsigned long rate,
+			      unsigned long parent_rate,
+			      u8 *div_n, u16 *mult_m, u16 *frac_m)
+{
+	struct ti_adpll_data *d = to_adpll(dco);
+	unsigned long dcorate, m, n;
+	u32 v;
+	u64 tmp64;
+
+	if (!rate)
+		return 0;
+
+	dcorate = parent_rate;
+	if (d->c->is_type_s) {
+		v = readl_relaxed(d->regs + ADPLL_CLKCTRL_OFFSET);
+		if (v & BIT(ADPLL_CLKCTRL_REGM4XEN_ADPLL_S))
+			dcorate /= 4;
+		dcorate /= 2;
+	}
+
+	/* TRM table "DPLLLJ Frequency Factors" sets the minimum M at 2 */
+	if (rate < TI_ADPLL_MIN_MULT_M * dcorate)
+		return 0;
+
+	/* Ratio for integer multiplier M and pre-divider N */
+	rational_best_approximation(rate, dcorate, TI_ADPLL_MULT_M_MAX,
+				    TI_ADPLL_DIV_N_MAX, &m, &n);
+	if (m < TI_ADPLL_MIN_MULT_M) {
+		m = TI_ADPLL_MIN_MULT_M;
+		n = rate / (dcorate * m);
+		if (n > TI_ADPLL_DIV_N_MAX) {
+			dev_err(d->dev, "div_n overflow for rate %li\n", rate);
+			return 0;
+		}
+	}
+
+	/* Calculate fractional part for multiplier M */
+	dcorate /= n;
+	tmp64 = rate % dcorate;
+	tmp64 *= 10000000;
+	do_div(tmp64, dcorate);
+
+	*div_n = n - 1;
+	*mult_m = m;
+	*frac_m = tmp64;
+
+	return rate;
+}
+
+/*
+ * Sets the sigma-delta divider targeting near 250Mhz. Adapted
+ * from TI 2.6.37 kernel tree adpll_ti814x.c. Maybe we can
+ * make the SD_DIV_TARGET_MHZ configurable also?
+ */
+#define SD_DIV_TARGET_MHZ	250
+static int ti_adpll_lookup_sddiv(struct ti_adpll_data *d,
+				 unsigned long parent_rate,
+				 u8 *sd_div, u16 m, u8 n)
+{
+	unsigned long clkinp, sd;
+	int mod1, mod2;
+
+	clkinp = parent_rate / 100000;
+	mod1 = (clkinp * m) % (SD_DIV_TARGET_MHZ * n);
+	sd = (clkinp * m) / (SD_DIV_TARGET_MHZ * n);
+	mod2 = sd % 10;
+	sd /= 10;
+
+	if (mod1 || mod2)
+		sd++;
+	if ((sd >= TI814X_ADPLLJ_MIN_SD_DIV) &&
+	    (sd <= TI814X_ADPLLJ_MAX_SD_DIV)) {
+		*sd_div = sd;
+		return 0;
+	}
+
+	*sd_div = 0;
+	dev_err(d->dev, "sigma-delta out of range: %li\n", sd);
+
+	return -EINVAL;
+}
+
+static long ti_adpll_round_rate(struct clk_hw *hw, unsigned long rate,
+				unsigned long *parent_rate)
+{
+	struct ti_adpll_dco_data *dco = to_dco(hw);
+	struct ti_adpll_data *d = to_adpll(dco);
+	long sd_min_rate;
+	u16 mult_m, frac_m;
+	u8 div_n;
+
+	sd_min_rate = (SD_DIV_TARGET_MHZ + 10) * 1000000;
+	/* Limited by sigma-delta somewhere, see above */
+	if (!d->c->is_type_s && rate < sd_min_rate) {
+		dev_warn(d->dev, "unsupported rate: %lu\n", rate);
+		return sd_min_rate;
+	}
+
+	return ti_adpll_calc_n_m(dco, rate, *parent_rate, &div_n,
+				 &mult_m, &frac_m);
+}
+
+static int ti_adpll_set_rate(struct clk_hw *hw, unsigned long rate,
+			     unsigned long parent_rate)
+{
+	struct ti_adpll_dco_data *dco = to_dco(hw);
+	struct ti_adpll_data *d = to_adpll(dco);
+	u16 mult_m, frac_m = 0;
+	u8 div_n, div_sd = 0;
+	unsigned long flags;
+	long new_rate;
+	int err;
+	u32 v;
+
+	new_rate = ti_adpll_calc_n_m(dco, rate, parent_rate,
+				     &div_n, &mult_m, &frac_m);
+	ti_adpll_set_idle_bypass(d);
+
+	spin_lock_irqsave(&d->lock, flags);
+	writeb_relaxed(0, d->regs + ADPLL_CLKCTRL_OFFSET);
+
+	/* Check sigma-delta divider, otherwise PLL won't lock */
+	if (!d->c->is_type_s) {
+		err = ti_adpll_lookup_sddiv(d, parent_rate,
+					    &div_sd, mult_m, div_n + 1);
+		if (err)
+			goto fail;
+	}
+
+	/* Set integer multiplier M */
+	writew_relaxed(mult_m, d->regs + ADPLL_MN2DIV_OFFSET);
+
+	/* Set ractional multiplier M and sigma-delta divider */
+	v = frac_m;
+	v |= (div_sd << 24);
+	writel_relaxed(v, d->regs + ADPLL_FRACDIV_OFFSET);
+
+	/* Configure SELFREQDCO */
+	if (!d->c->is_type_s) {
+		if (rate < 1000000000)
+			v = 2;
+		else
+			v = 4;
+		writeb_relaxed(v << 2, d->regs + ADPLL_CLKCTRL_OFFSET + 1);
+	}
+
+	dev_info(d->dev,
+		 "clkin: dco: %lu %lu N: %i + 1 M: %i Mf: %i sddiv: %i r: %i\n",
+		 parent_rate, rate, div_n, mult_m, frac_m, div_sd, v);
+
+	/* Set pre-devider N */
+	writeb_relaxed(div_n, d->regs + ADPLL_M2NDIV_OFFSET);
+
+	writeb_relaxed(1, d->regs + ADPLL_TENABLE_OFFSET);
+	writeb_relaxed(0, d->regs + ADPLL_TENABLE_OFFSET);
+	writeb_relaxed(1, d->regs + ADPLL_TENABLEDIV_OFFSET);
+	writeb_relaxed(0, d->regs + ADPLL_TENABLEDIV_OFFSET);
+	writeb_relaxed(1, d->regs + ADPLL_CLKCTRL_OFFSET);
+	spin_unlock_irqrestore(&d->lock, flags);
+
+	ti_adpll_clear_idle_bypass(d);
+
+	return ti_adpll_wait_lock(d);
+
+fail:
+	writeb_relaxed(1, d->regs + ADPLL_CLKCTRL_OFFSET);
+	spin_unlock_irqrestore(&d->lock, flags);
+	ti_adpll_clear_idle_bypass(d);
+	ti_adpll_wait_lock(d);
+
+	return err;
+}
+
 /* PLL parent is always clkinp, bypass only affects the children */
 static u8 ti_adpll_get_parent(struct clk_hw *hw)
 {
@@ -491,6 +671,8 @@ static struct clk_ops ti_adpll_ops = {
 	.unprepare = ti_adpll_unprepare,
 	.is_prepared = ti_adpll_is_prepared,
 	.recalc_rate = ti_adpll_recalc_rate,
+	.round_rate = ti_adpll_round_rate,
+	.set_rate = ti_adpll_set_rate,
 	.get_parent = ti_adpll_get_parent,
 };
 
-- 
2.8.1

