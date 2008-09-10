From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 02/12] OMAP2/3 clock: convert wkup_clkdm PRM clocks to
	prm_clkdm
Date: Wed, 10 Sep 2008 10:47:39 -0600
Message-ID: <20080910164736.17024.88034.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58251 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753451AbYIJQsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:48:51 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Convert existing wkup_clkdm clocks that should be in the PRM clockdomain
to prm_clkdm.  (A later patch will add PRM clockdomain associations for
unassociated clocks.)


References for the OMAP2xxx clocks:

OMAP2420 Multimedia Processor Silicon Revision 2.1.1, 2.2 TRM Version Q
  Figure 4-11:
      - alt_ck
  Figure 5-7:
      - func_32k_ck, osc_ck, sys_ck
  Figure 5-8 (assumes that "Level 0" = PRM)
      - dpll_ck, apll96_ck, apll54_ck, func_54m_ck
  Section 5.4.1.1:
      - sys_clkout_src, sys_clkout
  Section 29.3.1.1:
      - gpios_fck, mpu_wdt_fck, mpu_wdt_ick


References for the OMAP3xxx clocks:

OMAP34xx Multimedia Device Silicon Revision 3.0 Version I TRM
  Figure 4-54:
      - gpt1_fck, wkup_32k_fck, wdt2_fck, wkup_l4_fck, omap_32ksync_ick,
        gpt1_ick
  Section 25.3.1.1.3:
      - gpio1_fck, gpio1_ick

OMAP34xx Multimedia High Security (HS) Device Silicon Revision 3.0 Security
Addendum Version B TRM
  Table 2-5:
      - usim_ick
  Figure 3-29:
      - wdt1_ick, gpt12_ick

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clock24xx.h |   29 ++++++++++++++++-------------
 arch/arm/mach-omap2/clock34xx.h |   25 ++++++++++++-------------
 2 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/arch/arm/mach-omap2/clock24xx.h b/arch/arm/mach-omap2/clock24xx.h
index 4de6d9b..7224450 100644
--- a/arch/arm/mach-omap2/clock24xx.h
+++ b/arch/arm/mach-omap2/clock24xx.h
@@ -635,7 +635,7 @@ static struct clk func_32k_ck = {
 	.rate		= 32000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -644,7 +644,7 @@ static struct clk osc_ck = {		/* (*12, *13, 19.2, *26, 38.4)MHz */
 	.name		= "osc_ck",
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable		= &omap2_enable_osc_ck,
 	.disable	= &omap2_disable_osc_ck,
 	.recalc		= &omap2_osc_clk_recalc,
@@ -656,7 +656,7 @@ static struct clk sys_ck = {		/* (*12, *13, 19.2, 26, 38.4)MHz */
 	.parent		= &osc_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				ALWAYS_ENABLED | RATE_PROPAGATES,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_sys_clk_recalc,
 };
 
@@ -665,7 +665,7 @@ static struct clk alt_ck = {		/* Typical 54M or 48M, may not exist */
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | ALWAYS_ENABLED | RATE_PROPAGATES,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &propagate_rate,
 };
 
@@ -697,7 +697,7 @@ static struct clk dpll_ck = {
 	.dpll_data	= &dpll_dd,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | ALWAYS_ENABLED,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_dpllcore_recalc,
 	.set_rate	= &omap2_reprogram_dpllcore,
 };
@@ -708,7 +708,7 @@ static struct clk apll96_ck = {
 	.rate		= 96000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_96M_PLL_SHIFT,
 	.enable		= &omap2_clk_fixed_enable,
@@ -722,7 +722,7 @@ static struct clk apll54_ck = {
 	.rate		= 54000000,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_FIXED | RATE_PROPAGATES | ENABLE_ON_INIT,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(PLL_MOD, CM_CLKEN),
 	.enable_bit	= OMAP24XX_EN_54M_PLL_SHIFT,
 	.enable		= &omap2_clk_fixed_enable,
@@ -899,7 +899,7 @@ static struct clk sys_clkout_src = {
 	.parent		= &func_54m_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				RATE_PROPAGATES | OFFSET_GR_MOD,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.enable_bit	= OMAP24XX_CLKOUT_EN_SHIFT,
 	.init		= &omap2_init_clksel_parent,
@@ -930,7 +930,7 @@ static struct clk sys_clkout = {
 	.parent		= &sys_clkout_src,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X |
 				PARENT_CONTROLS_CLOCK | OFFSET_GR_MOD,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.clksel_reg	= _GR_MOD_OFFSET(OMAP24XX_PRCM_CLKOUT_CTRL_OFFSET),
 	.clksel_mask	= OMAP24XX_CLKOUT_DIV_MASK,
 	.clksel		= sys_clkout_clksel,
@@ -2079,27 +2079,29 @@ static struct clk gpios_fck = {
 	.name		= "gpios_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_GPIOS_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
+/* aka WDT2 - REVISIT: we should split wu_l4_iclk from l4_ck */
 static struct clk mpu_wdt_ick = {
 	.name		= "mpu_wdt_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.clkdm		= { .name = "core_l4_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
 };
 
+/* aka WDT2 */
 static struct clk mpu_wdt_fck = {
 	.name		= "mpu_wdt_fck",
 	.parent		= &func_32k_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP24XX_EN_MPU_WDT_SHIFT,
 	.recalc		= &followparent_recalc,
@@ -2116,11 +2118,12 @@ static struct clk sync_32k_ick = {
 	.recalc		= &followparent_recalc,
 };
 
+/* REVISIT: parent is really wu_l4_iclk */
 static struct clk wdt1_ick = {
 	.name		= "wdt1_ick",
 	.parent		= &l4_ck,
 	.flags		= CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
-	.clkdm		= { .name = "core_l4_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.enable_reg	= _CM_REG_OFFSET(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP24XX_EN_WDT1_SHIFT,
 	.recalc		= &followparent_recalc,
diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
index 4d16f56..c825a37 100644
--- a/arch/arm/mach-omap2/clock34xx.h
+++ b/arch/arm/mach-omap2/clock34xx.h
@@ -2323,7 +2323,7 @@ static struct clk gpt1_fck = {
 	.clksel_mask	= OMAP3430_CLKSEL_GPT1_MASK,
 	.clksel		= omap343x_gpt_clksel,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &omap2_clksel_recalc,
 };
 
@@ -2332,7 +2332,7 @@ static struct clk wkup_32k_fck = {
 	.init		= &omap2_init_clk_clkdm,
 	.parent		= &omap_32k_fck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2342,7 +2342,7 @@ static struct clk gpio1_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2352,7 +2352,7 @@ static struct clk wdt2_fck = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2360,7 +2360,7 @@ static struct clk wkup_l4_ick = {
 	.name		= "wkup_l4_ick",
 	.parent		= &sys_ck,
 	.flags		= CLOCK_IN_OMAP343X | RATE_PROPAGATES | ALWAYS_ENABLED,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2372,7 +2372,7 @@ static struct clk usim_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430ES2_EN_USIMOCP_SHIFT,
 	.flags		= CLOCK_IN_OMAP3430ES2,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2382,7 +2382,7 @@ static struct clk wdt2_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT2_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2392,7 +2392,7 @@ static struct clk wdt1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_WDT1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2402,7 +2402,7 @@ static struct clk gpio1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPIO1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2412,18 +2412,17 @@ static struct clk omap_32ksync_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_32KSYNC_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
-/* XXX This clock no longer exists in 3430 TRM rev F */
 static struct clk gpt12_ick = {
 	.name		= "gpt12_ick",
 	.parent		= &wkup_l4_ick,
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT12_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 
@@ -2433,7 +2432,7 @@ static struct clk gpt1_ick = {
 	.enable_reg	= _OMAP34XX_CM_REGADDR(WKUP_MOD, CM_ICLKEN),
 	.enable_bit	= OMAP3430_EN_GPT1_SHIFT,
 	.flags		= CLOCK_IN_OMAP343X,
-	.clkdm		= { .name = "wkup_clkdm" },
+	.clkdm		= { .name = "prm_clkdm" },
 	.recalc		= &followparent_recalc,
 };
 


