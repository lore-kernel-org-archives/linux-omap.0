From: Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 2/2] clk: Convert __clk_get_name(hw->clk) to clk_hw_get_name(hw)
Date: Wed, 12 Aug 2015 16:12:41 -0700
Message-ID: <1439421161-17868-2-git-send-email-sboyd@codeaurora.org>
References: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1439421161-17868-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Tomasz Figa <tomasz.figa@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Alexandre Courbot <gnurou@gmail.com>, Tero Kristo <t-kristo@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Andrew Bresticker <abrestic@chromium.org>, Ezequiel Garcia <ezequiel.garcia@imgtec.com>, Ralf Baechle <ralf@linux-mips.org>, Kevin Cernekee <cernekee@chromium.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-samsung-soc@vger.kernel.orglin
List-Id: linux-omap@vger.kernel.org

Use the provider based method to get a clock's name so that we
can get rid of the clk member in struct clk_hw one day. Mostly
converted with the following coccinelle script.

@@
struct clk_hw *E;
@@

-__clk_get_name(E->clk)
+clk_hw_get_name(E)

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Prashant Gaikwad <pgaikwad@nvidia.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Kevin Cernekee <cernekee@chromium.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linux-tegra@vger.kernel.org
Cc: linux-omap@vger.kernel.org
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/berlin/berlin2-pll.c     |  4 ++--
 drivers/clk/clk-xgene.c              | 22 +++++++++++-----------
 drivers/clk/pistachio/clk-pll.c      |  4 ++--
 drivers/clk/qcom/clk-branch.c        |  2 +-
 drivers/clk/rockchip/clk-inverter.c  |  2 +-
 drivers/clk/rockchip/clk-mmc-phase.c |  2 +-
 drivers/clk/samsung/clk-pll.c        | 18 +++++++++---------
 drivers/clk/shmobile/clk-div6.c      |  2 +-
 drivers/clk/st/clk-flexgen.c         |  4 ++--
 drivers/clk/st/clkgen-fsyn.c         | 18 +++++++++---------
 drivers/clk/st/clkgen-mux.c          |  2 +-
 drivers/clk/st/clkgen-pll.c          |  8 ++++----
 drivers/clk/tegra/clk-pll.c          |  8 ++++----
 drivers/clk/ti/apll.c                |  4 ++--
 drivers/clk/ti/clkt_dflt.c           |  8 ++++----
 drivers/clk/ti/clockdomain.c         | 14 +++++++-------
 drivers/clk/ux500/clk-prcmu.c        | 16 ++++++++--------
 drivers/clk/ux500/clk-sysctrl.c      |  2 +-
 18 files changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/clk/berlin/berlin2-pll.c b/drivers/clk/berlin/berlin2-pll.c
index f4b8d324b083..1c2294d3ba85 100644
--- a/drivers/clk/berlin/berlin2-pll.c
+++ b/drivers/clk/berlin/berlin2-pll.c
@@ -61,7 +61,7 @@ berlin2_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	fbdiv = (val >> map->fbdiv_shift) & FBDIV_MASK;
 	rfdiv = (val >> map->rfdiv_shift) & RFDIV_MASK;
 	if (rfdiv == 0) {
-		pr_warn("%s has zero rfdiv\n", __clk_get_name(hw->clk));
+		pr_warn("%s has zero rfdiv\n", clk_hw_get_name(hw));
 		rfdiv = 1;
 	}
 
@@ -70,7 +70,7 @@ berlin2_pll_recalc_rate(struct clk_hw *hw, unsigned long parent_rate)
 	vcodiv = map->vcodiv[vcodivsel];
 	if (vcodiv == 0) {
 		pr_warn("%s has zero vcodiv (index %d)\n",
-			__clk_get_name(hw->clk), vcodivsel);
+			clk_hw_get_name(hw), vcodivsel);
 		vcodiv = 1;
 	}
 
diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index 4caee9356407..96a6190acac2 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -74,7 +74,7 @@ static int xgene_clk_pll_is_enabled(struct clk_hw *hw)
 	u32 data;
 
 	data = xgene_clk_read(pllclk->reg + pllclk->pll_offset);
-	pr_debug("%s pll %s\n", __clk_get_name(hw->clk),
+	pr_debug("%s pll %s\n", clk_hw_get_name(hw),
 		data & REGSPEC_RESET_F1_MASK ? "disabled" : "enabled");
 
 	return data & REGSPEC_RESET_F1_MASK ? 0 : 1;
@@ -112,7 +112,7 @@ static unsigned long xgene_clk_pll_recalc_rate(struct clk_hw *hw,
 		fref = parent_rate / nref;
 		fvco = fref * nfb;
 	}
-	pr_debug("%s pll recalc rate %ld parent %ld\n", __clk_get_name(hw->clk),
+	pr_debug("%s pll recalc rate %ld parent %ld\n", clk_hw_get_name(hw),
 		fvco / nout, parent_rate);
 
 	return fvco / nout;
@@ -225,7 +225,7 @@ static int xgene_clk_enable(struct clk_hw *hw)
 		spin_lock_irqsave(pclk->lock, flags);
 
 	if (pclk->param.csr_reg != NULL) {
-		pr_debug("%s clock enabled\n", __clk_get_name(hw->clk));
+		pr_debug("%s clock enabled\n", clk_hw_get_name(hw));
 		reg = __pa(pclk->param.csr_reg);
 		/* First enable the clock */
 		data = xgene_clk_read(pclk->param.csr_reg +
@@ -234,7 +234,7 @@ static int xgene_clk_enable(struct clk_hw *hw)
 		xgene_clk_write(data, pclk->param.csr_reg +
 					pclk->param.reg_clk_offset);
 		pr_debug("%s clock PADDR base %pa clk offset 0x%08X mask 0x%08X value 0x%08X\n",
-			__clk_get_name(hw->clk), &reg,
+			clk_hw_get_name(hw), &reg,
 			pclk->param.reg_clk_offset, pclk->param.reg_clk_mask,
 			data);
 
@@ -245,7 +245,7 @@ static int xgene_clk_enable(struct clk_hw *hw)
 		xgene_clk_write(data, pclk->param.csr_reg +
 					pclk->param.reg_csr_offset);
 		pr_debug("%s CSR RESET PADDR base %pa csr offset 0x%08X mask 0x%08X value 0x%08X\n",
-			__clk_get_name(hw->clk), &reg,
+			clk_hw_get_name(hw), &reg,
 			pclk->param.reg_csr_offset, pclk->param.reg_csr_mask,
 			data);
 	}
@@ -266,7 +266,7 @@ static void xgene_clk_disable(struct clk_hw *hw)
 		spin_lock_irqsave(pclk->lock, flags);
 
 	if (pclk->param.csr_reg != NULL) {
-		pr_debug("%s clock disabled\n", __clk_get_name(hw->clk));
+		pr_debug("%s clock disabled\n", clk_hw_get_name(hw));
 		/* First put the CSR in reset */
 		data = xgene_clk_read(pclk->param.csr_reg +
 					pclk->param.reg_csr_offset);
@@ -292,10 +292,10 @@ static int xgene_clk_is_enabled(struct clk_hw *hw)
 	u32 data = 0;
 
 	if (pclk->param.csr_reg != NULL) {
-		pr_debug("%s clock checking\n", __clk_get_name(hw->clk));
+		pr_debug("%s clock checking\n", clk_hw_get_name(hw));
 		data = xgene_clk_read(pclk->param.csr_reg +
 					pclk->param.reg_clk_offset);
-		pr_debug("%s clock is %s\n", __clk_get_name(hw->clk),
+		pr_debug("%s clock is %s\n", clk_hw_get_name(hw),
 			data & pclk->param.reg_clk_mask ? "enabled" :
 							"disabled");
 	}
@@ -318,13 +318,13 @@ static unsigned long xgene_clk_recalc_rate(struct clk_hw *hw,
 		data &= (1 << pclk->param.reg_divider_width) - 1;
 
 		pr_debug("%s clock recalc rate %ld parent %ld\n",
-			__clk_get_name(hw->clk),
+			clk_hw_get_name(hw),
 			parent_rate / data, parent_rate);
 
 		return parent_rate / data;
 	} else {
 		pr_debug("%s clock recalc rate %ld parent %ld\n",
-			__clk_get_name(hw->clk), parent_rate, parent_rate);
+			clk_hw_get_name(hw), parent_rate, parent_rate);
 		return parent_rate;
 	}
 }
@@ -356,7 +356,7 @@ static int xgene_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		data |= divider;
 		xgene_clk_write(data, pclk->param.divider_reg +
 					pclk->param.reg_divider_offset);
-		pr_debug("%s clock set rate %ld\n", __clk_get_name(hw->clk),
+		pr_debug("%s clock set rate %ld\n", clk_hw_get_name(hw),
 			parent_rate / divider_save);
 	} else {
 		divider_save = 1;
diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index e17dada0dd21..addfec731333 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -174,7 +174,7 @@ static int pll_gf40lp_frac_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct pistachio_pll_rate_table *params;
 	int enabled = pll_gf40lp_frac_is_enabled(hw);
 	u32 val, vco, old_postdiv1, old_postdiv2;
-	const char *name = __clk_get_name(hw->clk);
+	const char *name = clk_hw_get_name(hw);
 
 	if (rate < MIN_OUTPUT_FRAC || rate > MAX_OUTPUT_FRAC)
 		return -EINVAL;
@@ -316,7 +316,7 @@ static int pll_gf40lp_laint_set_rate(struct clk_hw *hw, unsigned long rate,
 	struct pistachio_pll_rate_table *params;
 	int enabled = pll_gf40lp_laint_is_enabled(hw);
 	u32 val, vco, old_postdiv1, old_postdiv2;
-	const char *name = __clk_get_name(hw->clk);
+	const char *name = clk_hw_get_name(hw);
 
 	if (rate < MIN_OUTPUT_LA || rate > MAX_OUTPUT_LA)
 		return -EINVAL;
diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index 6b4d2bcb1a53..26f7af315066 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -75,7 +75,7 @@ static int clk_branch_wait(const struct clk_branch *br, bool enabling,
 		bool (check_halt)(const struct clk_branch *, bool))
 {
 	bool voted = br->halt_check & BRANCH_VOTED;
-	const char *name = __clk_get_name(br->clkr.hw.clk);
+	const char *name = clk_hw_get_name(&br->clkr.hw);
 
 	/* Skip checking halt bit if the clock is in hardware gated mode */
 	if (clk_branch_in_hwcg_mode(br))
diff --git a/drivers/clk/rockchip/clk-inverter.c b/drivers/clk/rockchip/clk-inverter.c
index 8054fdb5effb..7cbf43beb3c6 100644
--- a/drivers/clk/rockchip/clk-inverter.c
+++ b/drivers/clk/rockchip/clk-inverter.c
@@ -50,7 +50,7 @@ static int rockchip_inv_set_phase(struct clk_hw *hw, int degrees)
 		val = !!degrees;
 	} else {
 		pr_err("%s: unsupported phase %d for %s\n",
-		       __func__, degrees, __clk_get_name(hw->clk));
+		       __func__, degrees, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
diff --git a/drivers/clk/rockchip/clk-mmc-phase.c b/drivers/clk/rockchip/clk-mmc-phase.c
index 77e19097bdc7..9b613426e968 100644
--- a/drivers/clk/rockchip/clk-mmc-phase.c
+++ b/drivers/clk/rockchip/clk-mmc-phase.c
@@ -108,7 +108,7 @@ static int rockchip_mmc_set_phase(struct clk_hw *hw, int degrees)
 	writel(HIWORD_UPDATE(raw_value, 0x07ff, mmc_clock->shift), mmc_clock->reg);
 
 	pr_debug("%s->set_phase(%d) delay_nums=%u reg[0x%p]=0x%03x actual_degrees=%d\n",
-		__clk_get_name(hw->clk), degrees, delay_num,
+		clk_hw_get_name(hw), degrees, delay_num,
 		mmc_clock->reg, raw_value>>(mmc_clock->shift),
 		rockchip_mmc_get_phase(hw)
 	);
diff --git a/drivers/clk/samsung/clk-pll.c b/drivers/clk/samsung/clk-pll.c
index e9394261f80f..b7dd396100d8 100644
--- a/drivers/clk/samsung/clk-pll.c
+++ b/drivers/clk/samsung/clk-pll.c
@@ -182,7 +182,7 @@ static int samsung_pll35xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -290,7 +290,7 @@ static int samsung_pll36xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -405,7 +405,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -457,7 +457,7 @@ static int samsung_pll45xx_set_rate(struct clk_hw *hw, unsigned long drate,
 
 		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
 			pr_err("%s: could not lock PLL %s\n",
-					__func__, __clk_get_name(hw->clk));
+					__func__, clk_hw_get_name(hw));
 			return -EFAULT;
 		}
 
@@ -556,7 +556,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -616,7 +616,7 @@ static int samsung_pll46xx_set_rate(struct clk_hw *hw, unsigned long drate,
 
 		if (ktime_to_ms(delta) > PLL_TIMEOUT_MS) {
 			pr_err("%s: could not lock PLL %s\n",
-					__func__, __clk_get_name(hw->clk));
+					__func__, clk_hw_get_name(hw));
 			return -EFAULT;
 		}
 
@@ -774,7 +774,7 @@ static int samsung_s3c2410_pll_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -1015,7 +1015,7 @@ static int samsung_pll2550xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
@@ -1113,7 +1113,7 @@ static int samsung_pll2650xx_set_rate(struct clk_hw *hw, unsigned long drate,
 	rate = samsung_get_pll_settings(pll, drate);
 	if (!rate) {
 		pr_err("%s: Invalid rate : %lu for pll clk %s\n", __func__,
-			drate, __clk_get_name(hw->clk));
+			drate, clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
diff --git a/drivers/clk/shmobile/clk-div6.c b/drivers/clk/shmobile/clk-div6.c
index ee66f49812df..b4c8d6746f68 100644
--- a/drivers/clk/shmobile/clk-div6.c
+++ b/drivers/clk/shmobile/clk-div6.c
@@ -139,7 +139,7 @@ static u8 cpg_div6_clock_get_parent(struct clk_hw *hw)
 	}
 
 	pr_err("%s: %s DIV6 clock set to invalid parent %u\n",
-	       __func__, __clk_get_name(hw->clk), hw_index);
+	       __func__, clk_hw_get_name(hw), hw_index);
 	return 0;
 }
 
diff --git a/drivers/clk/st/clk-flexgen.c b/drivers/clk/st/clk-flexgen.c
index 965b13ba3515..bd355ee33766 100644
--- a/drivers/clk/st/clk-flexgen.c
+++ b/drivers/clk/st/clk-flexgen.c
@@ -45,7 +45,7 @@ static int flexgen_enable(struct clk_hw *hw)
 
 	clk_gate_ops.enable(fgate_hw);
 
-	pr_debug("%s: flexgen output enabled\n", __clk_get_name(hw->clk));
+	pr_debug("%s: flexgen output enabled\n", clk_hw_get_name(hw));
 	return 0;
 }
 
@@ -59,7 +59,7 @@ static void flexgen_disable(struct clk_hw *hw)
 
 	clk_gate_ops.disable(fgate_hw);
 
-	pr_debug("%s: flexgen output disabled\n", __clk_get_name(hw->clk));
+	pr_debug("%s: flexgen output disabled\n", clk_hw_get_name(hw));
 }
 
 static int flexgen_is_enabled(struct clk_hw *hw)
diff --git a/drivers/clk/st/clkgen-fsyn.c b/drivers/clk/st/clkgen-fsyn.c
index aa3117db4514..83ccf142ff2a 100644
--- a/drivers/clk/st/clkgen-fsyn.c
+++ b/drivers/clk/st/clkgen-fsyn.c
@@ -513,7 +513,7 @@ static unsigned long quadfs_pll_fs660c32_recalc_rate(struct clk_hw *hw,
 	params.ndiv = CLKGEN_READ(pll, ndiv);
 	if (clk_fs660c32_vco_get_rate(parent_rate, &params, &rate))
 		pr_err("%s:%s error calculating rate\n",
-		       __clk_get_name(hw->clk), __func__);
+		       clk_hw_get_name(hw), __func__);
 
 	pll->ndiv = params.ndiv;
 
@@ -558,7 +558,7 @@ static long quadfs_pll_fs660c32_round_rate(struct clk_hw *hw, unsigned long rate
 		clk_fs660c32_vco_get_rate(*prate, &params, &rate);
 
 	pr_debug("%s: %s new rate %ld [sdiv=0x%x,md=0x%x,pe=0x%x,nsdiv3=%u]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 rate, (unsigned int)params.sdiv,
 		 (unsigned int)params.mdiv,
 		 (unsigned int)params.pe, (unsigned int)params.nsdiv);
@@ -581,7 +581,7 @@ static int quadfs_pll_fs660c32_set_rate(struct clk_hw *hw, unsigned long rate,
 		clk_fs660c32_vco_get_rate(parent_rate, &params, &hwrate);
 
 	pr_debug("%s: %s new rate %ld [ndiv=0x%x]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 hwrate, (unsigned int)params.ndiv);
 
 	if (!hwrate)
@@ -745,7 +745,7 @@ static int quadfs_fsynth_enable(struct clk_hw *hw)
 	struct st_clk_quadfs_fsynth *fs = to_quadfs_fsynth(hw);
 	unsigned long flags = 0;
 
-	pr_debug("%s: %s\n", __func__, __clk_get_name(hw->clk));
+	pr_debug("%s: %s\n", __func__, clk_hw_get_name(hw));
 
 	quadfs_fsynth_program_rate(fs);
 
@@ -770,7 +770,7 @@ static void quadfs_fsynth_disable(struct clk_hw *hw)
 	struct st_clk_quadfs_fsynth *fs = to_quadfs_fsynth(hw);
 	unsigned long flags = 0;
 
-	pr_debug("%s: %s\n", __func__, __clk_get_name(hw->clk));
+	pr_debug("%s: %s\n", __func__, clk_hw_get_name(hw));
 
 	if (fs->lock)
 		spin_lock_irqsave(fs->lock, flags);
@@ -787,7 +787,7 @@ static int quadfs_fsynth_is_enabled(struct clk_hw *hw)
 	u32 nsb = CLKGEN_READ(fs, nsb[fs->chan]);
 
 	pr_debug("%s: %s enable bit = 0x%x\n",
-		 __func__, __clk_get_name(hw->clk), nsb);
+		 __func__, clk_hw_get_name(hw), nsb);
 
 	return fs->data->standby_polarity ? !nsb : !!nsb;
 }
@@ -946,10 +946,10 @@ static unsigned long quadfs_recalc_rate(struct clk_hw *hw,
 
 	if (clk_fs_get_rate(parent_rate, &params, &rate)) {
 		pr_err("%s:%s error calculating rate\n",
-		       __clk_get_name(hw->clk), __func__);
+		       clk_hw_get_name(hw), __func__);
 	}
 
-	pr_debug("%s:%s rate %lu\n", __clk_get_name(hw->clk), __func__, rate);
+	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
 
 	return rate;
 }
@@ -962,7 +962,7 @@ static long quadfs_round_rate(struct clk_hw *hw, unsigned long rate,
 	rate = quadfs_find_best_rate(hw, rate, *prate, &params);
 
 	pr_debug("%s: %s new rate %ld [sdiv=0x%x,md=0x%x,pe=0x%x,nsdiv3=%u]\n",
-		 __func__, __clk_get_name(hw->clk),
+		 __func__, clk_hw_get_name(hw),
 		 rate, (unsigned int)params.sdiv, (unsigned int)params.mdiv,
 			 (unsigned int)params.pe, (unsigned int)params.nsdiv);
 
diff --git a/drivers/clk/st/clkgen-mux.c b/drivers/clk/st/clkgen-mux.c
index 81f2372b97ff..4f7f6c00b219 100644
--- a/drivers/clk/st/clkgen-mux.c
+++ b/drivers/clk/st/clkgen-mux.c
@@ -139,7 +139,7 @@ static u8 clkgena_divmux_get_parent(struct clk_hw *hw)
 	genamux->muxsel = clk_mux_ops.get_parent(mux_hw);
 	if ((s8)genamux->muxsel < 0) {
 		pr_debug("%s: %s: Invalid parent, setting to default.\n",
-		      __func__, __clk_get_name(hw->clk));
+		      __func__, clk_hw_get_name(hw));
 		genamux->muxsel = 0;
 	}
 
diff --git a/drivers/clk/st/clkgen-pll.c b/drivers/clk/st/clkgen-pll.c
index cc2b52ec730a..47a38a994cac 100644
--- a/drivers/clk/st/clkgen-pll.c
+++ b/drivers/clk/st/clkgen-pll.c
@@ -292,7 +292,7 @@ static unsigned long recalc_stm_pll800c65(struct clk_hw *hw,
 	res = (uint64_t)2 * (uint64_t)parent_rate * (uint64_t)ndiv;
 	rate = (unsigned long)div64_u64(res, mdiv * (1 << pdiv));
 
-	pr_debug("%s:%s rate %lu\n", __clk_get_name(hw->clk), __func__, rate);
+	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
 
 	return rate;
 
@@ -317,7 +317,7 @@ static unsigned long recalc_stm_pll1600c65(struct clk_hw *hw,
 	/* Note: input is divided by 1000 to avoid overflow */
 	rate = ((2 * (parent_rate / 1000) * ndiv) / mdiv) * 1000;
 
-	pr_debug("%s:%s rate %lu\n", __clk_get_name(hw->clk), __func__, rate);
+	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
 
 	return rate;
 }
@@ -339,7 +339,7 @@ static unsigned long recalc_stm_pll3200c32(struct clk_hw *hw,
 		/* Note: input is divided to avoid overflow */
 		rate = ((2 * (parent_rate/1000) * ndiv) / idf) * 1000;
 
-	pr_debug("%s:%s rate %lu\n", __clk_get_name(hw->clk), __func__, rate);
+	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
 
 	return rate;
 }
@@ -366,7 +366,7 @@ static unsigned long recalc_stm_pll1200c32(struct clk_hw *hw,
 	/* Note: input is divided by 1000 to avoid overflow */
 	rate = (((parent_rate / 1000) * ldf) / (odf * idf)) * 1000;
 
-	pr_debug("%s:%s rate %lu\n", __clk_get_name(hw->clk), __func__, rate);
+	pr_debug("%s:%s rate %lu\n", clk_hw_get_name(hw), __func__, rate);
 
 	return rate;
 }
diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
index 69fea7d08681..d6d4ecb88e94 100644
--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -264,7 +264,7 @@ static int clk_pll_wait_for_lock(struct tegra_clk_pll *pll)
 	}
 
 	pr_err("%s: Timed out waiting for pll %s lock\n", __func__,
-	       __clk_get_name(pll->hw.clk));
+	       clk_hw_get_name(&pll->hw));
 
 	return -1;
 }
@@ -595,7 +595,7 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (pll->params->flags & TEGRA_PLL_FIXED) {
 		if (rate != pll->params->fixed_rate) {
 			pr_err("%s: Can not change %s fixed rate %lu to %lu\n",
-				__func__, __clk_get_name(hw->clk),
+				__func__, clk_hw_get_name(hw),
 				pll->params->fixed_rate, rate);
 			return -EINVAL;
 		}
@@ -605,7 +605,7 @@ static int clk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	if (_get_table_rate(hw, &cfg, rate, parent_rate) &&
 	    _calc_rate(hw, &cfg, rate, parent_rate)) {
 		pr_err("%s: Failed to set %s rate %lu\n", __func__,
-		       __clk_get_name(hw->clk), rate);
+		       clk_hw_get_name(hw), rate);
 		WARN_ON(1);
 		return -EINVAL;
 	}
@@ -663,7 +663,7 @@ static unsigned long clk_pll_recalc_rate(struct clk_hw *hw,
 		if (_get_table_rate(hw, &sel, pll->params->fixed_rate,
 					parent_rate)) {
 			pr_err("Clock %s has unknown fixed frequency\n",
-			       __clk_get_name(hw->clk));
+			       clk_hw_get_name(hw));
 			BUG();
 		}
 		return pll->params->fixed_rate;
diff --git a/drivers/clk/ti/apll.c b/drivers/clk/ti/apll.c
index 24febd4fe324..f3eab6e79027 100644
--- a/drivers/clk/ti/apll.c
+++ b/drivers/clk/ti/apll.c
@@ -50,7 +50,7 @@ static int dra7_apll_enable(struct clk_hw *hw)
 	if (!ad)
 		return -EINVAL;
 
-	clk_name = __clk_get_name(clk->hw.clk);
+	clk_name = clk_hw_get_name(&clk->hw);
 
 	state <<= __ffs(ad->idlest_mask);
 
@@ -273,7 +273,7 @@ static int omap2_apll_enable(struct clk_hw *hw)
 
 	if (i == MAX_APLL_WAIT_TRIES) {
 		pr_warn("%s failed to transition to locked\n",
-			__clk_get_name(clk->hw.clk));
+			clk_hw_get_name(&clk->hw));
 		return -EBUSY;
 	}
 
diff --git a/drivers/clk/ti/clkt_dflt.c b/drivers/clk/ti/clkt_dflt.c
index a176b8ac8dd0..90d7d8a21c49 100644
--- a/drivers/clk/ti/clkt_dflt.c
+++ b/drivers/clk/ti/clkt_dflt.c
@@ -110,7 +110,7 @@ static void _omap2_module_wait_ready(struct clk_hw_omap *clk)
 	if (r) {
 		/* IDLEST register not in the CM module */
 		_wait_idlest_generic(clk, idlest_reg, (1 << idlest_bit),
-				     idlest_val, __clk_get_name(clk->hw.clk));
+				     idlest_val, clk_hw_get_name(&clk->hw));
 	} else {
 		ti_clk_ll_ops->cm_wait_module_ready(0, prcm_mod, idlest_reg_id,
 						    idlest_bit);
@@ -216,7 +216,7 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
 		if (ret) {
 			WARN(1,
 			     "%s: could not enable %s's clockdomain %s: %d\n",
-			     __func__, __clk_get_name(hw->clk),
+			     __func__, clk_hw_get_name(hw),
 			     clk->clkdm_name, ret);
 			return ret;
 		}
@@ -224,7 +224,7 @@ int omap2_dflt_clk_enable(struct clk_hw *hw)
 
 	if (unlikely(!clk->enable_reg)) {
 		pr_err("%s: %s missing enable_reg\n", __func__,
-		       __clk_get_name(hw->clk));
+		       clk_hw_get_name(hw));
 		ret = -EINVAL;
 		goto err;
 	}
@@ -270,7 +270,7 @@ void omap2_dflt_clk_disable(struct clk_hw *hw)
 		 * controlled by its parent.
 		 */
 		pr_err("%s: independent clock %s has no enable_reg\n",
-		       __func__, __clk_get_name(hw->clk));
+		       __func__, clk_hw_get_name(hw));
 		return;
 	}
 
diff --git a/drivers/clk/ti/clockdomain.c b/drivers/clk/ti/clockdomain.c
index 362a62c10311..b9bc3b8df659 100644
--- a/drivers/clk/ti/clockdomain.c
+++ b/drivers/clk/ti/clockdomain.c
@@ -48,23 +48,23 @@ int omap2_clkops_enable_clkdm(struct clk_hw *hw)
 
 	if (unlikely(!clk->clkdm)) {
 		pr_err("%s: %s: no clkdm set ?!\n", __func__,
-		       __clk_get_name(hw->clk));
+		       clk_hw_get_name(hw));
 		return -EINVAL;
 	}
 
 	if (unlikely(clk->enable_reg))
 		pr_err("%s: %s: should use dflt_clk_enable ?!\n", __func__,
-		       __clk_get_name(hw->clk));
+		       clk_hw_get_name(hw));
 
 	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
 		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
-		       __func__, __clk_get_name(hw->clk));
+		       __func__, clk_hw_get_name(hw));
 		return 0;
 	}
 
 	ret = ti_clk_ll_ops->clkdm_clk_enable(clk->clkdm, hw->clk);
 	WARN(ret, "%s: could not enable %s's clockdomain %s: %d\n",
-	     __func__, __clk_get_name(hw->clk), clk->clkdm_name, ret);
+	     __func__, clk_hw_get_name(hw), clk->clkdm_name, ret);
 
 	return ret;
 }
@@ -86,17 +86,17 @@ void omap2_clkops_disable_clkdm(struct clk_hw *hw)
 
 	if (unlikely(!clk->clkdm)) {
 		pr_err("%s: %s: no clkdm set ?!\n", __func__,
-		       __clk_get_name(hw->clk));
+		       clk_hw_get_name(hw));
 		return;
 	}
 
 	if (unlikely(clk->enable_reg))
 		pr_err("%s: %s: should use dflt_clk_disable ?!\n", __func__,
-		       __clk_get_name(hw->clk));
+		       clk_hw_get_name(hw));
 
 	if (ti_clk_get_features()->flags & TI_CLK_DISABLE_CLKDM_CONTROL) {
 		pr_err("%s: %s: clkfw-based clockdomain control disabled ?!\n",
-		       __func__, __clk_get_name(hw->clk));
+		       __func__, clk_hw_get_name(hw));
 		return;
 	}
 
diff --git a/drivers/clk/ux500/clk-prcmu.c b/drivers/clk/ux500/clk-prcmu.c
index bf63c96acb1a..7f343821f4e4 100644
--- a/drivers/clk/ux500/clk-prcmu.c
+++ b/drivers/clk/ux500/clk-prcmu.c
@@ -43,7 +43,7 @@ static void clk_prcmu_unprepare(struct clk_hw *hw)
 	struct clk_prcmu *clk = to_clk_prcmu(hw);
 	if (prcmu_request_clock(clk->cg_sel, false))
 		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
-			__clk_get_name(hw->clk));
+			clk_hw_get_name(hw));
 	else
 		clk->is_prepared = 0;
 }
@@ -101,11 +101,11 @@ static int clk_prcmu_opp_prepare(struct clk_hw *hw)
 
 	if (!clk->opp_requested) {
 		err = prcmu_qos_add_requirement(PRCMU_QOS_APE_OPP,
-						(char *)__clk_get_name(hw->clk),
+						(char *)clk_hw_get_name(hw),
 						100);
 		if (err) {
 			pr_err("clk_prcmu: %s fail req APE OPP for %s.\n",
-				__func__, __clk_get_name(hw->clk));
+				__func__, clk_hw_get_name(hw));
 			return err;
 		}
 		clk->opp_requested = 1;
@@ -114,7 +114,7 @@ static int clk_prcmu_opp_prepare(struct clk_hw *hw)
 	err = prcmu_request_clock(clk->cg_sel, true);
 	if (err) {
 		prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP,
-					(char *)__clk_get_name(hw->clk));
+					(char *)clk_hw_get_name(hw));
 		clk->opp_requested = 0;
 		return err;
 	}
@@ -129,13 +129,13 @@ static void clk_prcmu_opp_unprepare(struct clk_hw *hw)
 
 	if (prcmu_request_clock(clk->cg_sel, false)) {
 		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
-			__clk_get_name(hw->clk));
+			clk_hw_get_name(hw));
 		return;
 	}
 
 	if (clk->opp_requested) {
 		prcmu_qos_remove_requirement(PRCMU_QOS_APE_OPP,
-					(char *)__clk_get_name(hw->clk));
+					(char *)clk_hw_get_name(hw));
 		clk->opp_requested = 0;
 	}
 
@@ -151,7 +151,7 @@ static int clk_prcmu_opp_volt_prepare(struct clk_hw *hw)
 		err = prcmu_request_ape_opp_100_voltage(true);
 		if (err) {
 			pr_err("clk_prcmu: %s fail req APE OPP VOLT for %s.\n",
-				__func__, __clk_get_name(hw->clk));
+				__func__, clk_hw_get_name(hw));
 			return err;
 		}
 		clk->opp_requested = 1;
@@ -174,7 +174,7 @@ static void clk_prcmu_opp_volt_unprepare(struct clk_hw *hw)
 
 	if (prcmu_request_clock(clk->cg_sel, false)) {
 		pr_err("clk_prcmu: %s failed to disable %s.\n", __func__,
-			__clk_get_name(hw->clk));
+			clk_hw_get_name(hw));
 		return;
 	}
 
diff --git a/drivers/clk/ux500/clk-sysctrl.c b/drivers/clk/ux500/clk-sysctrl.c
index e364c9d4aa60..266ddea630d2 100644
--- a/drivers/clk/ux500/clk-sysctrl.c
+++ b/drivers/clk/ux500/clk-sysctrl.c
@@ -52,7 +52,7 @@ static void clk_sysctrl_unprepare(struct clk_hw *hw)
 	struct clk_sysctrl *clk = to_clk_sysctrl(hw);
 	if (ab8500_sysctrl_clear(clk->reg_sel[0], clk->reg_mask[0]))
 		dev_err(clk->dev, "clk_sysctrl: %s fail to clear %s.\n",
-			__func__, __clk_get_name(hw->clk));
+			__func__, clk_hw_get_name(hw));
 }
 
 static unsigned long clk_sysctrl_recalc_rate(struct clk_hw *hw,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
