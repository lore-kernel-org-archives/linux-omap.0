From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 01/11] ARM: OMAP2: CM/PM: remove direct register accesses outside CM code
Date: Fri, 11 Oct 2013 19:15:31 +0300
Message-ID: <1381508141-15244-2-git-send-email-t-kristo@ti.com>
References: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54095 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754845Ab3JKQQX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Oct 2013 12:16:23 -0400
In-Reply-To: <1381508141-15244-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@linaro.org, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Users of the CM funtionality should not access the CM registers directly
by themselves. Thus, added new CM driver APIs for the OMAP2 specific
functionalities which support the existing direct register accesses, and
changed the platform code to use these. This is done in preparation
for moving the CM code into its own individual driver.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c          |    4 +-
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |   11 ++---
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   24 +++------
 arch/arm/mach-omap2/cm2xxx.c                 |   67 ++++++++++++++++++++++++++
 arch/arm/mach-omap2/cm2xxx.h                 |    8 +++
 arch/arm/mach-omap2/pm24xx.c                 |   24 +--------
 6 files changed, 89 insertions(+), 49 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index 25b1fee..c78e893 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -52,7 +52,7 @@ static bool omap2xxx_clk_apll_locked(struct clk_hw *hw)
 
 	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
 
-	r = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	r = omap2xxx_cm_get_pll_status();
 
 	return ((r & apll_mask) == apll_mask) ? true : false;
 }
@@ -126,7 +126,7 @@ u32 omap2xxx_get_apll_clkin(void)
 {
 	u32 aplls, srate = 0;
 
-	aplls = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls = omap2xxx_cm_get_pll_config();
 	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
 	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index d862010..3ff3254 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -60,8 +60,7 @@ unsigned long omap2xxx_clk_get_core_rate(void)
 
 	core_clk = omap2_get_dpll_rate(dpll_core_ck);
 
-	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	v &= OMAP24XX_CORE_CLK_SRC_MASK;
+	v = omap2xxx_cm_get_core_clk_src();
 
 	if (v == CORE_CLK_SRC_32K)
 		core_clk = 32768;
@@ -79,8 +78,7 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 {
 	u32 high, low, core_clk_src;
 
-	core_clk_src = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
+	core_clk_src = omap2xxx_cm_get_core_clk_src();
 
 	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
 		high = curr_prcm_set->dpll_speed * 2;
@@ -120,8 +118,7 @@ int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
 	const struct dpll_data *dd;
 
 	cur_rate = omap2xxx_clk_get_core_rate();
-	mult = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
-	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
+	mult = omap2xxx_cm_get_core_clk_src();
 
 	if ((rate == (cur_rate / 2)) && (mult == 2)) {
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL, 1);
@@ -145,7 +142,7 @@ int omap2_reprogram_dpllcore(struct clk_hw *hw, unsigned long rate,
 		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
 					   dd->div1_mask);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll = omap2xxx_cm_get_core_pll_config();
 		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
 		if (rate > low) {
 			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index ae2b35e..b935ed2 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -98,7 +98,7 @@ long omap2_round_to_table_rate(struct clk_hw *hw, unsigned long rate,
 int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
 			    unsigned long parent_rate)
 {
-	u32 cur_rate, done_rate, bypass = 0, tmp;
+	u32 cur_rate, done_rate, bypass = 0;
 	const struct prcm_config *prcm;
 	unsigned long found_speed = 0;
 	unsigned long flags;
@@ -141,23 +141,11 @@ int omap2_select_table_rate(struct clk_hw *hw, unsigned long rate,
 		else
 			done_rate = CORE_CLK_SRC_DPLL;
 
-		/* MPU divider */
-		omap2_cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
-
-		/* dsp + iva1 div(2420), iva2.1(2430) */
-		omap2_cm_write_mod_reg(prcm->cm_clksel_dsp,
-				 OMAP24XX_DSP_MOD, CM_CLKSEL);
-
-		omap2_cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
-
-		/* Major subsystem dividers */
-		tmp = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		omap2_cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
-				 CM_CLKSEL1);
-
-		if (cpu_is_omap2430())
-			omap2_cm_write_mod_reg(prcm->cm_clksel_mdm,
-					 OMAP2430_MDM_MOD, CM_CLKSEL);
+		omap2xxx_cm_set_mod_dividers(prcm->cm_clksel_mpu,
+					     prcm->cm_clksel_dsp,
+					     prcm->cm_clksel_gfx,
+					     prcm->cm_clksel1_core,
+					     prcm->cm_clksel_mdm);
 
 		/* x2 to enter omap2xxx_sdrc_init_params() */
 		omap2xxx_sdrc_reprogram(CORE_CLK_SRC_DPLL_X2, 1);
diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index 6774a53..ce25abb 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -327,6 +327,73 @@ struct clkdm_ops omap2_clkdm_operations = {
 	.clkdm_clk_disable	= omap2xxx_clkdm_clk_disable,
 };
 
+int omap2xxx_cm_fclks_active(void)
+{
+	u32 f1, f2;
+
+	f1 = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	f2 = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+
+	return (f1 | f2) ? 1 : 0;
+}
+
+int omap2xxx_cm_mpu_retention_allowed(void)
+{
+	u32 l;
+
+	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
+	l = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	if (l & (OMAP2420_EN_MMC_MASK | OMAP24XX_EN_UART2_MASK |
+		 OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_MCSPI2_MASK |
+		 OMAP24XX_EN_MCSPI1_MASK | OMAP24XX_EN_DSS1_MASK))
+		return 0;
+	/* Check for UART3. */
+	l = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+	if (l & OMAP24XX_EN_UART3_MASK)
+		return 0;
+
+	return 1;
+}
+
+u32 omap2xxx_cm_get_core_clk_src(void)
+{
+	u32 v;
+
+	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	v &= OMAP24XX_CORE_CLK_SRC_MASK;
+
+	return v;
+}
+
+u32 omap2xxx_cm_get_core_pll_config(void)
+{
+	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+}
+
+u32 omap2xxx_cm_get_pll_config(void)
+{
+	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+}
+
+u32 omap2xxx_cm_get_pll_status(void)
+{
+	return omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+}
+
+void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core, u32 mdm)
+{
+	u32 tmp;
+
+	omap2_cm_write_mod_reg(mpu, MPU_MOD, CM_CLKSEL);
+	omap2_cm_write_mod_reg(dsp, OMAP24XX_DSP_MOD, CM_CLKSEL);
+	omap2_cm_write_mod_reg(gfx, GFX_MOD, CM_CLKSEL);
+	tmp = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) &
+		OMAP24XX_CLKSEL_DSS2_MASK;
+	omap2_cm_write_mod_reg(core | tmp, CORE_MOD, CM_CLKSEL1);
+	if (cpu_is_omap2430())
+		omap2_cm_write_mod_reg(mdm, OMAP2430_MDM_MOD, CM_CLKSEL);
+}
+
 /*
  *
  */
diff --git a/arch/arm/mach-omap2/cm2xxx.h b/arch/arm/mach-omap2/cm2xxx.h
index 4cbb39b..891d81c 100644
--- a/arch/arm/mach-omap2/cm2xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx.h
@@ -62,6 +62,14 @@ extern int omap2xxx_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
 					 u8 idlest_shift);
 extern int omap2xxx_cm_split_idlest_reg(void __iomem *idlest_reg,
 					s16 *prcm_inst, u8 *idlest_reg_id);
+extern int omap2xxx_cm_fclks_active(void);
+extern int omap2xxx_cm_mpu_retention_allowed(void);
+extern u32 omap2xxx_cm_get_core_clk_src(void);
+extern u32 omap2xxx_cm_get_core_pll_config(void);
+extern u32 omap2xxx_cm_get_pll_config(void);
+extern u32 omap2xxx_cm_get_pll_status(void);
+extern void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core,
+					 u32 mdm);
 
 extern int __init omap2xxx_cm_init(void);
 
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index ce956b0..8c07594 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -62,16 +62,6 @@ static struct clockdomain *dsp_clkdm, *mpu_clkdm, *wkup_clkdm, *gfx_clkdm;
 
 static struct clk *osc_ck, *emul_ck;
 
-static int omap2_fclks_active(void)
-{
-	u32 f1, f2;
-
-	f1 = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	f2 = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
-
-	return (f1 | f2) ? 1 : 0;
-}
-
 static int omap2_enter_full_retention(void)
 {
 	u32 l;
@@ -142,17 +132,7 @@ static int sti_console_enabled;
 
 static int omap2_allow_mpu_retention(void)
 {
-	u32 l;
-
-	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
-	l = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	if (l & (OMAP2420_EN_MMC_MASK | OMAP24XX_EN_UART2_MASK |
-		 OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_MCSPI2_MASK |
-		 OMAP24XX_EN_MCSPI1_MASK | OMAP24XX_EN_DSS1_MASK))
-		return 0;
-	/* Check for UART3. */
-	l = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
-	if (l & OMAP24XX_EN_UART3_MASK)
+	if (!omap2xxx_cm_mpu_retention_allowed())
 		return 0;
 	if (sti_console_enabled)
 		return 0;
@@ -188,7 +168,7 @@ static void omap2_enter_mpu_retention(void)
 
 static int omap2_can_sleep(void)
 {
-	if (omap2_fclks_active())
+	if (omap2xxx_cm_fclks_active())
 		return 0;
 	if (__clk_is_enabled(osc_ck))
 		return 0;
-- 
1.7.9.5

