From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 03/11] OMAP2/3: PRM/CM: prefix OMAP2 PRM/CM functions with
	"omap2_"
Date: Tue, 07 Dec 2010 23:18:37 -0700
Message-ID: <20101208061836.30541.72763.stgit@twilight.localdomain>
References: <20101208061657.30541.79824.stgit@twilight.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:37177 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161Ab0LHGTy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Dec 2010 01:19:54 -0500
In-Reply-To: <20101208061657.30541.79824.stgit@twilight.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jarkko Nikula <jhnikula@gmail.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>

Now that OMAP4-specific PRCM functions have been added, distinguish the
existing OMAP2/3-specific PRCM functions by prefixing them with "omap2_".

This patch should not result in any functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>
Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-omap2/clkt2xxx_apll.c          |   10 -
 arch/arm/mach-omap2/clkt2xxx_dpllcore.c      |    8 -
 arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c |   12 -
 arch/arm/mach-omap2/clockdomain.c            |   22 +-
 arch/arm/mach-omap2/cm2xxx_3xxx.c            |  352 +++++++++++++-------------
 arch/arm/mach-omap2/cm2xxx_3xxx.h            |   10 -
 arch/arm/mach-omap2/control.c                |   40 ++-
 arch/arm/mach-omap2/pm-debug.c               |    8 -
 arch/arm/mach-omap2/pm24xx.c                 |  194 +++++++-------
 arch/arm/mach-omap2/pm34xx.c                 |  143 +++++------
 arch/arm/mach-omap2/powerdomain2xxx_3xxx.c   |   66 +++--
 arch/arm/mach-omap2/powerdomain44xx.c        |   33 +-
 arch/arm/mach-omap2/prcm.c                   |   16 +
 arch/arm/mach-omap2/prm2xxx_3xxx.c           |   34 +--
 arch/arm/mach-omap2/prm2xxx_3xxx.h           |   12 -
 arch/arm/mach-omap2/sdrc2xxx.c               |    4 
 arch/arm/mach-omap2/serial.c                 |    1 
 arch/arm/plat-omap/mcbsp.c                   |    8 -
 18 files changed, 501 insertions(+), 472 deletions(-)

diff --git a/arch/arm/mach-omap2/clkt2xxx_apll.c b/arch/arm/mach-omap2/clkt2xxx_apll.c
index 954d11f..f51cffd 100644
--- a/arch/arm/mach-omap2/clkt2xxx_apll.c
+++ b/arch/arm/mach-omap2/clkt2xxx_apll.c
@@ -49,14 +49,14 @@ static int omap2_clk_apll_enable(struct clk *clk, u32 status_mask)
 
 	apll_mask = EN_APLL_LOCKED << clk->enable_bit;
 
-	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	cval = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 
 	if ((cval & apll_mask) == apll_mask)
 		return 0;   /* apll already enabled */
 
 	cval &= ~apll_mask;
 	cval |= apll_mask;
-	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 
 	omap2_cm_wait_idlest(cm_idlest_pll, status_mask,
 			     OMAP24XX_CM_IDLEST_VAL, clk->name);
@@ -83,9 +83,9 @@ static void omap2_clk_apll_disable(struct clk *clk)
 {
 	u32 cval;
 
-	cval = cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+	cval = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	cval &= ~(EN_APLL_LOCKED << clk->enable_bit);
-	cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
+	omap2_cm_write_mod_reg(cval, PLL_MOD, CM_CLKEN);
 }
 
 /* Public data */
@@ -106,7 +106,7 @@ u32 omap2xxx_get_apll_clkin(void)
 {
 	u32 aplls, srate = 0;
 
-	aplls = cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
+	aplls = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL1);
 	aplls &= OMAP24XX_APLLS_CLKIN_MASK;
 	aplls >>= OMAP24XX_APLLS_CLKIN_SHIFT;
 
diff --git a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
index 530a76b..4ae4392 100644
--- a/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
+++ b/arch/arm/mach-omap2/clkt2xxx_dpllcore.c
@@ -54,7 +54,7 @@ unsigned long omap2xxx_clk_get_core_rate(struct clk *clk)
 
 	core_clk = omap2_get_dpll_rate(clk);
 
-	v = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	v = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	v &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if (v == CORE_CLK_SRC_32K)
@@ -73,7 +73,7 @@ static long omap2_dpllcore_round_rate(unsigned long target_rate)
 {
 	u32 high, low, core_clk_src;
 
-	core_clk_src = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	core_clk_src = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	core_clk_src &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if (core_clk_src == CORE_CLK_SRC_DPLL) {	/* DPLL clockout */
@@ -111,7 +111,7 @@ int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 	const struct dpll_data *dd;
 
 	cur_rate = omap2xxx_clk_get_core_rate(dclk);
-	mult = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+	mult = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 	mult &= OMAP24XX_CORE_CLK_SRC_MASK;
 
 	if ((rate == (cur_rate / 2)) && (mult == 2)) {
@@ -136,7 +136,7 @@ int omap2_reprogram_dpllcore(struct clk *clk, unsigned long rate)
 		tmpset.cm_clksel1_pll &= ~(dd->mult_mask |
 					   dd->div1_mask);
 		div = ((curr_prcm_set->xtal_speed / 1000000) - 1);
-		tmpset.cm_clksel2_pll = cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
+		tmpset.cm_clksel2_pll = omap2_cm_read_mod_reg(PLL_MOD, CM_CLKSEL2);
 		tmpset.cm_clksel2_pll &= ~OMAP24XX_CORE_CLK_SRC_MASK;
 		if (rate > low) {
 			tmpset.cm_clksel2_pll |= CORE_CLK_SRC_DPLL_X2;
diff --git a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
index f49f47d..39f9d5a 100644
--- a/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
+++ b/arch/arm/mach-omap2/clkt2xxx_virt_prcm_set.c
@@ -133,21 +133,21 @@ int omap2_select_table_rate(struct clk *clk, unsigned long rate)
 			done_rate = CORE_CLK_SRC_DPLL;
 
 		/* MPU divider */
-		cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
+		omap2_cm_write_mod_reg(prcm->cm_clksel_mpu, MPU_MOD, CM_CLKSEL);
 
 		/* dsp + iva1 div(2420), iva2.1(2430) */
-		cm_write_mod_reg(prcm->cm_clksel_dsp,
+		omap2_cm_write_mod_reg(prcm->cm_clksel_dsp,
 				 OMAP24XX_DSP_MOD, CM_CLKSEL);
 
-		cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
+		omap2_cm_write_mod_reg(prcm->cm_clksel_gfx, GFX_MOD, CM_CLKSEL);
 
 		/* Major subsystem dividers */
-		tmp = cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
-		cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
+		tmp = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) & OMAP24XX_CLKSEL_DSS2_MASK;
+		omap2_cm_write_mod_reg(prcm->cm_clksel1_core | tmp, CORE_MOD,
 				 CM_CLKSEL1);
 
 		if (cpu_is_omap2430())
-			cm_write_mod_reg(prcm->cm_clksel_mdm,
+			omap2_cm_write_mod_reg(prcm->cm_clksel_mdm,
 					 OMAP2430_MDM_MOD, CM_CLKSEL);
 
 		/* x2 to enter omap2xxx_sdrc_init_params() */
diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index a2142e0..da74f71 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -13,7 +13,6 @@
  */
 #undef DEBUG
 
-#include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/device.h>
 #include <linux/list.h>
@@ -30,7 +29,6 @@
 #include "prm2xxx_3xxx.h"
 #include "prm-regbits-24xx.h"
 #include "cm2xxx_3xxx.h"
-#include "cm2xxx_3xxx.h"
 
 #include <plat/clock.h>
 #include <plat/powerdomain.h>
@@ -410,7 +408,7 @@ int clkdm_add_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: hardware will wake up %s when %s wakes "
 			 "up\n", clkdm1->name, clkdm2->name);
 
-		prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+		omap2_prm_set_mod_reg_bits((1 << clkdm2->dep_bit),
 				     clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
 	}
 
@@ -445,7 +443,7 @@ int clkdm_del_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: hardware will no longer wake up %s "
 			 "after %s wakes up\n", clkdm1->name, clkdm2->name);
 
-		prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+		omap2_prm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
 				       clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP);
 	}
 
@@ -481,7 +479,7 @@ int clkdm_read_wkdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	}
 
 	/* XXX It's faster to return the atomic wkdep_usecount */
-	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs, PM_WKDEP,
 				       (1 << clkdm2->dep_bit));
 }
 
@@ -515,7 +513,7 @@ int clkdm_clear_all_wkdeps(struct clockdomain *clkdm)
 		atomic_set(&cd->wkdep_usecount, 0);
 	}
 
-	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs, PM_WKDEP);
 
 	return 0;
 }
@@ -554,7 +552,7 @@ int clkdm_add_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 		pr_debug("clockdomain: will prevent %s from sleeping if %s "
 			 "is active\n", clkdm1->name, clkdm2->name);
 
-		cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
+		omap2_cm_set_mod_reg_bits((1 << clkdm2->dep_bit),
 				    clkdm1->pwrdm.ptr->prcm_offs,
 				    OMAP3430_CM_SLEEPDEP);
 	}
@@ -597,7 +595,7 @@ int clkdm_del_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 			 "sleeping if %s is active\n", clkdm1->name,
 			 clkdm2->name);
 
-		cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
+		omap2_cm_clear_mod_reg_bits((1 << clkdm2->dep_bit),
 				      clkdm1->pwrdm.ptr->prcm_offs,
 				      OMAP3430_CM_SLEEPDEP);
 	}
@@ -640,7 +638,7 @@ int clkdm_read_sleepdep(struct clockdomain *clkdm1, struct clockdomain *clkdm2)
 	}
 
 	/* XXX It's faster to return the atomic sleepdep_usecount */
-	return prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(clkdm1->pwrdm.ptr->prcm_offs,
 				       OMAP3430_CM_SLEEPDEP,
 				       (1 << clkdm2->dep_bit));
 }
@@ -678,7 +676,7 @@ int clkdm_clear_all_sleepdeps(struct clockdomain *clkdm)
 		atomic_set(&cd->sleepdep_usecount, 0);
 	}
 
-	prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
+	omap2_prm_clear_mod_reg_bits(mask, clkdm->pwrdm.ptr->prcm_offs,
 			       OMAP3430_CM_SLEEPDEP);
 
 	return 0;
@@ -730,7 +728,7 @@ int omap2_clkdm_sleep(struct clockdomain *clkdm)
 
 	if (cpu_is_omap24xx()) {
 
-		cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
+		omap2_cm_set_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			    clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
@@ -774,7 +772,7 @@ int omap2_clkdm_wakeup(struct clockdomain *clkdm)
 
 	if (cpu_is_omap24xx()) {
 
-		cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
+		omap2_cm_clear_mod_reg_bits(OMAP24XX_FORCESTATE_MASK,
 			      clkdm->pwrdm.ptr->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	} else if (cpu_is_omap34xx() || cpu_is_omap44xx()) {
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index 1c98dfc..e3d598a 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -29,37 +29,37 @@ static const u8 cm_idlest_offs[] = {
 	CM_IDLEST1, CM_IDLEST2, OMAP2430_CM_IDLEST3
 };
 
-u32 cm_read_mod_reg(s16 module, u16 idx)
+u32 omap2_cm_read_mod_reg(s16 module, u16 idx)
 {
 	return __raw_readl(cm_base + module + idx);
 }
 
-void cm_write_mod_reg(u32 val, s16 module, u16 idx)
+void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	__raw_writel(val, cm_base + module + idx);
 }
 
 /* Read-modify-write a register in a CM module. Caller must lock */
-u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 {
 	u32 v;
 
-	v = cm_read_mod_reg(module, idx);
+	v = omap2_cm_read_mod_reg(module, idx);
 	v &= ~mask;
 	v |= bits;
-	cm_write_mod_reg(v, module, idx);
+	omap2_cm_write_mod_reg(v, module, idx);
 
 	return v;
 }
 
-u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
-	return cm_rmw_mod_reg_bits(bits, bits, module, idx);
+	return omap2_cm_rmw_mod_reg_bits(bits, bits, module, idx);
 }
 
-u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
-	return cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+	return omap2_cm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
 /**
@@ -90,7 +90,7 @@ int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id, u8 idlest_shift)
 	else
 		BUG();
 
-	omap_test_timeout(((cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
+	omap_test_timeout(((omap2_cm_read_mod_reg(prcm_mod, cm_idlest_reg) & mask) == ena),
 			  MAX_MODULE_READY_TIME, i);
 
 	return (i < MAX_MODULE_READY_TIME) ? 0 : -EBUSY;
@@ -166,228 +166,238 @@ static struct omap3_cm_regs cm_context;
 void omap3_cm_save_context(void)
 {
 	cm_context.iva2_cm_clksel1 =
-		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
+		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL1);
 	cm_context.iva2_cm_clksel2 =
-		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
+		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_CLKSEL2);
 	cm_context.cm_sysconfig = __raw_readl(OMAP3430_CM_SYSCONFIG);
 	cm_context.sgx_cm_clksel =
-		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
+		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_CLKSEL);
 	cm_context.dss_cm_clksel =
-		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
+		omap2_cm_read_mod_reg(OMAP3430_DSS_MOD, CM_CLKSEL);
 	cm_context.cam_cm_clksel =
-		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
+		omap2_cm_read_mod_reg(OMAP3430_CAM_MOD, CM_CLKSEL);
 	cm_context.per_cm_clksel =
-		cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
+		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_CLKSEL);
 	cm_context.emu_cm_clksel =
-		cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
+		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, CM_CLKSEL1);
 	cm_context.emu_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430_EMU_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.pll_cm_autoidle2 =
-		cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
+		omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE2);
 	cm_context.pll_cm_clksel4 =
-		cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
+		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL4);
 	cm_context.pll_cm_clksel5 =
-		cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
+		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKSEL5);
 	cm_context.pll_cm_clken2 =
-		cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
+		omap2_cm_read_mod_reg(PLL_MOD, OMAP3430ES2_CM_CLKEN2);
 	cm_context.cm_polctrl = __raw_readl(OMAP3430_CM_POLCTRL);
 	cm_context.iva2_cm_fclken =
-		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
-	cm_context.iva2_cm_clken_pll = cm_read_mod_reg(OMAP3430_IVA2_MOD,
-						       OMAP3430_CM_CLKEN_PLL);
+		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_FCLKEN);
+	cm_context.iva2_cm_clken_pll =
+		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKEN_PLL);
 	cm_context.core_cm_fclken1 =
-		cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	cm_context.core_cm_fclken3 =
-		cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
+		omap2_cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3);
 	cm_context.sgx_cm_fclken =
-		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
+		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN);
 	cm_context.wkup_cm_fclken =
-		cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
+		omap2_cm_read_mod_reg(WKUP_MOD, CM_FCLKEN);
 	cm_context.dss_cm_fclken =
-		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
+		omap2_cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN);
 	cm_context.cam_cm_fclken =
-		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
+		omap2_cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN);
 	cm_context.per_cm_fclken =
-		cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
+		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN);
 	cm_context.usbhost_cm_fclken =
-		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+		omap2_cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
 	cm_context.core_cm_iclken1 =
-		cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_ICLKEN1);
 	cm_context.core_cm_iclken2 =
-		cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_ICLKEN2);
 	cm_context.core_cm_iclken3 =
-		cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_ICLKEN3);
 	cm_context.sgx_cm_iclken =
-		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
+		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_ICLKEN);
 	cm_context.wkup_cm_iclken =
-		cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
+		omap2_cm_read_mod_reg(WKUP_MOD, CM_ICLKEN);
 	cm_context.dss_cm_iclken =
-		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
+		omap2_cm_read_mod_reg(OMAP3430_DSS_MOD, CM_ICLKEN);
 	cm_context.cam_cm_iclken =
-		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
+		omap2_cm_read_mod_reg(OMAP3430_CAM_MOD, CM_ICLKEN);
 	cm_context.per_cm_iclken =
-		cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
+		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_ICLKEN);
 	cm_context.usbhost_cm_iclken =
-		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
+		omap2_cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
 	cm_context.iva2_cm_autoidle2 =
-		cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
+		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
 	cm_context.mpu_cm_autoidle2 =
-		cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
+		omap2_cm_read_mod_reg(MPU_MOD, CM_AUTOIDLE2);
 	cm_context.iva2_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.mpu_cm_clkstctrl =
-		cm_read_mod_reg(MPU_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(MPU_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.core_cm_clkstctrl =
-		cm_read_mod_reg(CORE_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(CORE_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.sgx_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.dss_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.cam_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.per_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430_PER_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.neon_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430_NEON_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430_NEON_MOD, OMAP2_CM_CLKSTCTRL);
 	cm_context.usbhost_cm_clkstctrl =
-		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP2_CM_CLKSTCTRL);
+		omap2_cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+				      OMAP2_CM_CLKSTCTRL);
 	cm_context.core_cm_autoidle1 =
-		cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE1);
 	cm_context.core_cm_autoidle2 =
-		cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE2);
 	cm_context.core_cm_autoidle3 =
-		cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
+		omap2_cm_read_mod_reg(CORE_MOD, CM_AUTOIDLE3);
 	cm_context.wkup_cm_autoidle =
-		cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
+		omap2_cm_read_mod_reg(WKUP_MOD, CM_AUTOIDLE);
 	cm_context.dss_cm_autoidle =
-		cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
+		omap2_cm_read_mod_reg(OMAP3430_DSS_MOD, CM_AUTOIDLE);
 	cm_context.cam_cm_autoidle =
-		cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
+		omap2_cm_read_mod_reg(OMAP3430_CAM_MOD, CM_AUTOIDLE);
 	cm_context.per_cm_autoidle =
-		cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
 	cm_context.usbhost_cm_autoidle =
-		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+		omap2_cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
 	cm_context.sgx_cm_sleepdep =
-		cm_read_mod_reg(OMAP3430ES2_SGX_MOD, OMAP3430_CM_SLEEPDEP);
+		omap2_cm_read_mod_reg(OMAP3430ES2_SGX_MOD,
+				      OMAP3430_CM_SLEEPDEP);
 	cm_context.dss_cm_sleepdep =
-		cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP3430_CM_SLEEPDEP);
+		omap2_cm_read_mod_reg(OMAP3430_DSS_MOD, OMAP3430_CM_SLEEPDEP);
 	cm_context.cam_cm_sleepdep =
-		cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP3430_CM_SLEEPDEP);
+		omap2_cm_read_mod_reg(OMAP3430_CAM_MOD, OMAP3430_CM_SLEEPDEP);
 	cm_context.per_cm_sleepdep =
-		cm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_CM_SLEEPDEP);
+		omap2_cm_read_mod_reg(OMAP3430_PER_MOD, OMAP3430_CM_SLEEPDEP);
 	cm_context.usbhost_cm_sleepdep =
-		cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+		omap2_cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD,
+				      OMAP3430_CM_SLEEPDEP);
 	cm_context.cm_clkout_ctrl =
-		cm_read_mod_reg(OMAP3430_CCR_MOD, OMAP3_CM_CLKOUT_CTRL_OFFSET);
+		omap2_cm_read_mod_reg(OMAP3430_CCR_MOD,
+				      OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
 
 void omap3_cm_restore_context(void)
 {
-	cm_write_mod_reg(cm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
-			 CM_CLKSEL1);
-	cm_write_mod_reg(cm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
-			 CM_CLKSEL2);
+	omap2_cm_write_mod_reg(cm_context.iva2_cm_clksel1, OMAP3430_IVA2_MOD,
+			       CM_CLKSEL1);
+	omap2_cm_write_mod_reg(cm_context.iva2_cm_clksel2, OMAP3430_IVA2_MOD,
+			       CM_CLKSEL2);
 	__raw_writel(cm_context.cm_sysconfig, OMAP3430_CM_SYSCONFIG);
-	cm_write_mod_reg(cm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
-			 CM_CLKSEL);
-	cm_write_mod_reg(cm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
-			 CM_CLKSEL);
-	cm_write_mod_reg(cm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
-			 CM_CLKSEL);
-	cm_write_mod_reg(cm_context.per_cm_clksel, OMAP3430_PER_MOD,
-			 CM_CLKSEL);
-	cm_write_mod_reg(cm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
-			 CM_CLKSEL1);
-	cm_write_mod_reg(cm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.pll_cm_autoidle2, PLL_MOD,
-			 CM_AUTOIDLE2);
-	cm_write_mod_reg(cm_context.pll_cm_clksel4, PLL_MOD,
-			 OMAP3430ES2_CM_CLKSEL4);
-	cm_write_mod_reg(cm_context.pll_cm_clksel5, PLL_MOD,
-			 OMAP3430ES2_CM_CLKSEL5);
-	cm_write_mod_reg(cm_context.pll_cm_clken2, PLL_MOD,
-			 OMAP3430ES2_CM_CLKEN2);
+	omap2_cm_write_mod_reg(cm_context.sgx_cm_clksel, OMAP3430ES2_SGX_MOD,
+			       CM_CLKSEL);
+	omap2_cm_write_mod_reg(cm_context.dss_cm_clksel, OMAP3430_DSS_MOD,
+			       CM_CLKSEL);
+	omap2_cm_write_mod_reg(cm_context.cam_cm_clksel, OMAP3430_CAM_MOD,
+			       CM_CLKSEL);
+	omap2_cm_write_mod_reg(cm_context.per_cm_clksel, OMAP3430_PER_MOD,
+			       CM_CLKSEL);
+	omap2_cm_write_mod_reg(cm_context.emu_cm_clksel, OMAP3430_EMU_MOD,
+			       CM_CLKSEL1);
+	omap2_cm_write_mod_reg(cm_context.emu_cm_clkstctrl, OMAP3430_EMU_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.pll_cm_autoidle2, PLL_MOD,
+			       CM_AUTOIDLE2);
+	omap2_cm_write_mod_reg(cm_context.pll_cm_clksel4, PLL_MOD,
+			       OMAP3430ES2_CM_CLKSEL4);
+	omap2_cm_write_mod_reg(cm_context.pll_cm_clksel5, PLL_MOD,
+			       OMAP3430ES2_CM_CLKSEL5);
+	omap2_cm_write_mod_reg(cm_context.pll_cm_clken2, PLL_MOD,
+			       OMAP3430ES2_CM_CLKEN2);
 	__raw_writel(cm_context.cm_polctrl, OMAP3430_CM_POLCTRL);
-	cm_write_mod_reg(cm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
-			 CM_FCLKEN);
-	cm_write_mod_reg(cm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
-			 OMAP3430_CM_CLKEN_PLL);
-	cm_write_mod_reg(cm_context.core_cm_fclken1, CORE_MOD, CM_FCLKEN1);
-	cm_write_mod_reg(cm_context.core_cm_fclken3, CORE_MOD,
-			 OMAP3430ES2_CM_FCLKEN3);
-	cm_write_mod_reg(cm_context.sgx_cm_fclken, OMAP3430ES2_SGX_MOD,
-			 CM_FCLKEN);
-	cm_write_mod_reg(cm_context.wkup_cm_fclken, WKUP_MOD, CM_FCLKEN);
-	cm_write_mod_reg(cm_context.dss_cm_fclken, OMAP3430_DSS_MOD,
-			 CM_FCLKEN);
-	cm_write_mod_reg(cm_context.cam_cm_fclken, OMAP3430_CAM_MOD,
-			 CM_FCLKEN);
-	cm_write_mod_reg(cm_context.per_cm_fclken, OMAP3430_PER_MOD,
-			 CM_FCLKEN);
-	cm_write_mod_reg(cm_context.usbhost_cm_fclken,
-			 OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
-	cm_write_mod_reg(cm_context.core_cm_iclken1, CORE_MOD, CM_ICLKEN1);
-	cm_write_mod_reg(cm_context.core_cm_iclken2, CORE_MOD, CM_ICLKEN2);
-	cm_write_mod_reg(cm_context.core_cm_iclken3, CORE_MOD, CM_ICLKEN3);
-	cm_write_mod_reg(cm_context.sgx_cm_iclken, OMAP3430ES2_SGX_MOD,
-			 CM_ICLKEN);
-	cm_write_mod_reg(cm_context.wkup_cm_iclken, WKUP_MOD, CM_ICLKEN);
-	cm_write_mod_reg(cm_context.dss_cm_iclken, OMAP3430_DSS_MOD,
-			 CM_ICLKEN);
-	cm_write_mod_reg(cm_context.cam_cm_iclken, OMAP3430_CAM_MOD,
-			 CM_ICLKEN);
-	cm_write_mod_reg(cm_context.per_cm_iclken, OMAP3430_PER_MOD,
-			 CM_ICLKEN);
-	cm_write_mod_reg(cm_context.usbhost_cm_iclken,
-			 OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
-	cm_write_mod_reg(cm_context.iva2_cm_autoidle2, OMAP3430_IVA2_MOD,
-			 CM_AUTOIDLE2);
-	cm_write_mod_reg(cm_context.mpu_cm_autoidle2, MPU_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(cm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.mpu_cm_clkstctrl, MPU_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.core_cm_clkstctrl, CORE_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.sgx_cm_clkstctrl, OMAP3430ES2_SGX_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.dss_cm_clkstctrl, OMAP3430_DSS_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.cam_cm_clkstctrl, OMAP3430_CAM_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.per_cm_clkstctrl, OMAP3430_PER_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.neon_cm_clkstctrl, OMAP3430_NEON_MOD,
-			 OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.usbhost_cm_clkstctrl,
-			 OMAP3430ES2_USBHOST_MOD, OMAP2_CM_CLKSTCTRL);
-	cm_write_mod_reg(cm_context.core_cm_autoidle1, CORE_MOD,
-			 CM_AUTOIDLE1);
-	cm_write_mod_reg(cm_context.core_cm_autoidle2, CORE_MOD,
-			 CM_AUTOIDLE2);
-	cm_write_mod_reg(cm_context.core_cm_autoidle3, CORE_MOD,
-			 CM_AUTOIDLE3);
-	cm_write_mod_reg(cm_context.wkup_cm_autoidle, WKUP_MOD, CM_AUTOIDLE);
-	cm_write_mod_reg(cm_context.dss_cm_autoidle, OMAP3430_DSS_MOD,
-			 CM_AUTOIDLE);
-	cm_write_mod_reg(cm_context.cam_cm_autoidle, OMAP3430_CAM_MOD,
-			 CM_AUTOIDLE);
-	cm_write_mod_reg(cm_context.per_cm_autoidle, OMAP3430_PER_MOD,
-			 CM_AUTOIDLE);
-	cm_write_mod_reg(cm_context.usbhost_cm_autoidle,
-			 OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
-	cm_write_mod_reg(cm_context.sgx_cm_sleepdep, OMAP3430ES2_SGX_MOD,
-			 OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(cm_context.dss_cm_sleepdep, OMAP3430_DSS_MOD,
-			 OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(cm_context.cam_cm_sleepdep, OMAP3430_CAM_MOD,
-			 OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(cm_context.per_cm_sleepdep, OMAP3430_PER_MOD,
-			 OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(cm_context.usbhost_cm_sleepdep,
-			 OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
-	cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
-			 OMAP3_CM_CLKOUT_CTRL_OFFSET);
+	omap2_cm_write_mod_reg(cm_context.iva2_cm_fclken, OMAP3430_IVA2_MOD,
+			       CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.iva2_cm_clken_pll, OMAP3430_IVA2_MOD,
+			       OMAP3430_CM_CLKEN_PLL);
+	omap2_cm_write_mod_reg(cm_context.core_cm_fclken1, CORE_MOD,
+			       CM_FCLKEN1);
+	omap2_cm_write_mod_reg(cm_context.core_cm_fclken3, CORE_MOD,
+			       OMAP3430ES2_CM_FCLKEN3);
+	omap2_cm_write_mod_reg(cm_context.sgx_cm_fclken, OMAP3430ES2_SGX_MOD,
+			       CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.wkup_cm_fclken, WKUP_MOD, CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.dss_cm_fclken, OMAP3430_DSS_MOD,
+			       CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.cam_cm_fclken, OMAP3430_CAM_MOD,
+			       CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.per_cm_fclken, OMAP3430_PER_MOD,
+			       CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.usbhost_cm_fclken,
+			       OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+	omap2_cm_write_mod_reg(cm_context.core_cm_iclken1, CORE_MOD,
+			       CM_ICLKEN1);
+	omap2_cm_write_mod_reg(cm_context.core_cm_iclken2, CORE_MOD,
+			       CM_ICLKEN2);
+	omap2_cm_write_mod_reg(cm_context.core_cm_iclken3, CORE_MOD,
+			       CM_ICLKEN3);
+	omap2_cm_write_mod_reg(cm_context.sgx_cm_iclken, OMAP3430ES2_SGX_MOD,
+			       CM_ICLKEN);
+	omap2_cm_write_mod_reg(cm_context.wkup_cm_iclken, WKUP_MOD, CM_ICLKEN);
+	omap2_cm_write_mod_reg(cm_context.dss_cm_iclken, OMAP3430_DSS_MOD,
+			       CM_ICLKEN);
+	omap2_cm_write_mod_reg(cm_context.cam_cm_iclken, OMAP3430_CAM_MOD,
+			       CM_ICLKEN);
+	omap2_cm_write_mod_reg(cm_context.per_cm_iclken, OMAP3430_PER_MOD,
+			       CM_ICLKEN);
+	omap2_cm_write_mod_reg(cm_context.usbhost_cm_iclken,
+			       OMAP3430ES2_USBHOST_MOD, CM_ICLKEN);
+	omap2_cm_write_mod_reg(cm_context.iva2_cm_autoidle2, OMAP3430_IVA2_MOD,
+			       CM_AUTOIDLE2);
+	omap2_cm_write_mod_reg(cm_context.mpu_cm_autoidle2, MPU_MOD,
+			       CM_AUTOIDLE2);
+	omap2_cm_write_mod_reg(cm_context.iva2_cm_clkstctrl, OMAP3430_IVA2_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.mpu_cm_clkstctrl, MPU_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.core_cm_clkstctrl, CORE_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.sgx_cm_clkstctrl, OMAP3430ES2_SGX_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.dss_cm_clkstctrl, OMAP3430_DSS_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.cam_cm_clkstctrl, OMAP3430_CAM_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.per_cm_clkstctrl, OMAP3430_PER_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.neon_cm_clkstctrl, OMAP3430_NEON_MOD,
+			       OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.usbhost_cm_clkstctrl,
+			       OMAP3430ES2_USBHOST_MOD, OMAP2_CM_CLKSTCTRL);
+	omap2_cm_write_mod_reg(cm_context.core_cm_autoidle1, CORE_MOD,
+			       CM_AUTOIDLE1);
+	omap2_cm_write_mod_reg(cm_context.core_cm_autoidle2, CORE_MOD,
+			       CM_AUTOIDLE2);
+	omap2_cm_write_mod_reg(cm_context.core_cm_autoidle3, CORE_MOD,
+			       CM_AUTOIDLE3);
+	omap2_cm_write_mod_reg(cm_context.wkup_cm_autoidle, WKUP_MOD,
+			       CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(cm_context.dss_cm_autoidle, OMAP3430_DSS_MOD,
+			       CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(cm_context.cam_cm_autoidle, OMAP3430_CAM_MOD,
+			       CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(cm_context.per_cm_autoidle, OMAP3430_PER_MOD,
+			       CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(cm_context.usbhost_cm_autoidle,
+			       OMAP3430ES2_USBHOST_MOD, CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(cm_context.sgx_cm_sleepdep, OMAP3430ES2_SGX_MOD,
+			       OMAP3430_CM_SLEEPDEP);
+	omap2_cm_write_mod_reg(cm_context.dss_cm_sleepdep, OMAP3430_DSS_MOD,
+			       OMAP3430_CM_SLEEPDEP);
+	omap2_cm_write_mod_reg(cm_context.cam_cm_sleepdep, OMAP3430_CAM_MOD,
+			       OMAP3430_CM_SLEEPDEP);
+	omap2_cm_write_mod_reg(cm_context.per_cm_sleepdep, OMAP3430_PER_MOD,
+			       OMAP3430_CM_SLEEPDEP);
+	omap2_cm_write_mod_reg(cm_context.usbhost_cm_sleepdep,
+			       OMAP3430ES2_USBHOST_MOD, OMAP3430_CM_SLEEPDEP);
+	omap2_cm_write_mod_reg(cm_context.cm_clkout_ctrl, OMAP3430_CCR_MOD,
+			       OMAP3_CM_CLKOUT_CTRL_OFFSET);
 }
 #endif
diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.h b/arch/arm/mach-omap2/cm2xxx_3xxx.h
index ce2582c1..ff24edf 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.h
@@ -104,14 +104,14 @@
 
 #ifndef __ASSEMBLER__
 
-extern u32 cm_read_mod_reg(s16 module, u16 idx);
-extern void cm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+extern u32 omap2_cm_read_mod_reg(s16 module, u16 idx);
+extern void omap2_cm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 omap2_cm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
 
 extern int omap2_cm_wait_module_ready(s16 prcm_mod, u8 idlest_id,
 				      u8 idlest_shift);
-extern u32 cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
-extern u32 cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 omap2_cm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 omap2_cm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
 
 #endif
 
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index fee6620..16bde76 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -252,13 +252,13 @@ void omap3_clear_scratchpad_contents(void)
 	void __iomem *v_addr;
 	u32 offset = 0;
 	v_addr = OMAP2_L4_IO_ADDRESS(OMAP343X_SCRATCHPAD_ROM);
-	if (prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
+	if (omap2_prm_read_mod_reg(OMAP3430_GR_MOD, OMAP3_PRM_RSTST_OFFSET) &
 	    OMAP3430_GLOBAL_COLD_RST_MASK) {
 		for ( ; offset <= max_offset; offset += 0x4)
 			__raw_writel(0x0, (v_addr + offset));
-		prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
-				     OMAP3430_GR_MOD,
-				     OMAP3_PRM_RSTST_OFFSET);
+		omap2_prm_set_mod_reg_bits(OMAP3430_GLOBAL_COLD_RST_MASK,
+					   OMAP3430_GR_MOD,
+					   OMAP3_PRM_RSTST_OFFSET);
 	}
 }
 
@@ -290,32 +290,34 @@ void omap3_save_scratchpad_contents(void)
 	scratchpad_contents.sdrc_block_offset = 0x64;
 
 	/* Populate the PRCM block contents */
-	prcm_block_contents.prm_clksrc_ctrl = prm_read_mod_reg(OMAP3430_GR_MOD,
-			OMAP3_PRM_CLKSRC_CTRL_OFFSET);
-	prcm_block_contents.prm_clksel = prm_read_mod_reg(OMAP3430_CCR_MOD,
-			OMAP3_PRM_CLKSEL_OFFSET);
+	prcm_block_contents.prm_clksrc_ctrl =
+		omap2_prm_read_mod_reg(OMAP3430_GR_MOD,
+				       OMAP3_PRM_CLKSRC_CTRL_OFFSET);
+	prcm_block_contents.prm_clksel =
+		omap2_prm_read_mod_reg(OMAP3430_CCR_MOD,
+				       OMAP3_PRM_CLKSEL_OFFSET);
 	prcm_block_contents.cm_clksel_core =
-			cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
+			omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clksel_wkup =
-			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
+			omap2_cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clken_pll =
-			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
+			omap2_cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 	prcm_block_contents.cm_clksel1_pll =
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
+			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
 	prcm_block_contents.cm_clksel2_pll =
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL2_PLL);
+			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL2_PLL);
 	prcm_block_contents.cm_clksel3_pll =
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL3);
+			omap2_cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL3);
 	prcm_block_contents.cm_clken_pll_mpu =
-			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKEN_PLL);
+			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKEN_PLL);
 	prcm_block_contents.cm_autoidle_pll_mpu =
-			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL);
+			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 	prcm_block_contents.cm_clksel1_pll_mpu =
-			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL);
+			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL1_PLL);
 	prcm_block_contents.cm_clksel2_pll_mpu =
-			cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
+			omap2_cm_read_mod_reg(MPU_MOD, OMAP3430_CM_CLKSEL2_PLL);
 	prcm_block_contents.prcm_block_size = 0x0;
 
 	/* Populate the SDRC block contents */
diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
index 26eda02..73f8ec0 100644
--- a/arch/arm/mach-omap2/pm-debug.c
+++ b/arch/arm/mach-omap2/pm-debug.c
@@ -45,10 +45,10 @@ u32 wakeup_timer_milliseconds;
 
 #define DUMP_PRM_MOD_REG(mod, reg)    \
 	regs[reg_count].name = #mod "." #reg; \
-	regs[reg_count++].val = prm_read_mod_reg(mod, reg)
+	regs[reg_count++].val = omap2_prm_read_mod_reg(mod, reg)
 #define DUMP_CM_MOD_REG(mod, reg)     \
 	regs[reg_count].name = #mod "." #reg; \
-	regs[reg_count++].val = cm_read_mod_reg(mod, reg)
+	regs[reg_count++].val = omap2_cm_read_mod_reg(mod, reg)
 #define DUMP_PRM_REG(reg) \
 	regs[reg_count].name = #reg; \
 	regs[reg_count++].val = __raw_readl(reg)
@@ -311,10 +311,10 @@ static void pm_dbg_regset_store(u32 *ptr)
 		for (j = pm_dbg_reg_modules[i].low;
 			j <= pm_dbg_reg_modules[i].high; j += 4) {
 			if (pm_dbg_reg_modules[i].type == MOD_CM)
-				val = cm_read_mod_reg(
+				val = omap2_cm_read_mod_reg(
 					pm_dbg_reg_modules[i].offset, j);
 			else
-				val = prm_read_mod_reg(
+				val = omap2_prm_read_mod_reg(
 					pm_dbg_reg_modules[i].offset, j);
 			*(ptr++) = val;
 		}
diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
index de89d89..f13e2ca 100644
--- a/arch/arm/mach-omap2/pm24xx.c
+++ b/arch/arm/mach-omap2/pm24xx.c
@@ -66,8 +66,8 @@ static int omap2_fclks_active(void)
 {
 	u32 f1, f2;
 
-	f1 = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
-	f2 = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+	f1 = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	f2 = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
 
 	/* Ignore UART clocks.  These are handled by UART core (serial.c) */
 	f1 &= ~(OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_UART2_MASK);
@@ -92,9 +92,9 @@ static void omap2_enter_full_retention(void)
 
 	/* Clear old wake-up events */
 	/* REVISIT: These write to reserved bits? */
-	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
-	prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 	/*
 	 * Set MPU powerdomain's next power state to RETENTION;
@@ -152,30 +152,30 @@ no_sleep:
 	clk_enable(osc_ck);
 
 	/* clear CORE wake-up events */
-	prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
 
 	/* wakeup domain events - bit 1: GPT1, bit5 GPIO */
-	prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
+	omap2_prm_clear_mod_reg_bits(0x4 | 0x1, WKUP_MOD, PM_WKST);
 
 	/* MPU domain wake events */
-	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
+	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x01)
-		prm_write_mod_reg(0x01, OCP_MOD,
+		omap2_prm_write_mod_reg(0x01, OCP_MOD,
 				  OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 	if (l & 0x20)
-		prm_write_mod_reg(0x20, OCP_MOD,
+		omap2_prm_write_mod_reg(0x20, OCP_MOD,
 				  OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 
 	/* Mask future PRCM-to-MPU interrupts */
-	prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
+	omap2_prm_write_mod_reg(0x0, OCP_MOD, OMAP2_PRCM_IRQSTATUS_MPU_OFFSET);
 }
 
 static int omap2_i2c_active(void)
 {
 	u32 l;
 
-	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	l = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	return l & (OMAP2420_EN_I2C2_MASK | OMAP2420_EN_I2C1_MASK);
 }
 
@@ -186,13 +186,13 @@ static int omap2_allow_mpu_retention(void)
 	u32 l;
 
 	/* Check for MMC, UART2, UART1, McSPI2, McSPI1 and DSS1. */
-	l = cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
+	l = omap2_cm_read_mod_reg(CORE_MOD, CM_FCLKEN1);
 	if (l & (OMAP2420_EN_MMC_MASK | OMAP24XX_EN_UART2_MASK |
 		 OMAP24XX_EN_UART1_MASK | OMAP24XX_EN_MCSPI2_MASK |
 		 OMAP24XX_EN_MCSPI1_MASK | OMAP24XX_EN_DSS1_MASK))
 		return 0;
 	/* Check for UART3. */
-	l = cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
+	l = omap2_cm_read_mod_reg(CORE_MOD, OMAP24XX_CM_FCLKEN2);
 	if (l & OMAP24XX_EN_UART3_MASK)
 		return 0;
 	if (sti_console_enabled)
@@ -215,18 +215,18 @@ static void omap2_enter_mpu_retention(void)
 	 * it is in retention mode. */
 	if (omap2_allow_mpu_retention()) {
 		/* REVISIT: These write to reserved bits? */
-		prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
-		prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
-		prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
+		omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, PM_WKST1);
+		omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP24XX_PM_WKST2);
+		omap2_prm_write_mod_reg(0xffffffff, WKUP_MOD, PM_WKST);
 
 		/* Try to enter MPU retention */
-		prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
+		omap2_prm_write_mod_reg((0x01 << OMAP_POWERSTATE_SHIFT) |
 				  OMAP_LOGICRETSTATE_MASK,
 				  MPU_MOD, OMAP2_PM_PWSTCTRL);
 	} else {
 		/* Block MPU retention */
 
-		prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
+		omap2_prm_write_mod_reg(OMAP_LOGICRETSTATE_MASK, MPU_MOD,
 						 OMAP2_PM_PWSTCTRL);
 		only_idle = 1;
 	}
@@ -295,9 +295,9 @@ static int omap2_pm_suspend(void)
 {
 	u32 wken_wkup, mir1;
 
-	wken_wkup = prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+	wken_wkup = omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 	wken_wkup &= ~OMAP24XX_EN_GPT1_MASK;
-	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	/* Mask GPT1 */
 	mir1 = omap_readl(0x480fe0a4);
@@ -307,7 +307,7 @@ static int omap2_pm_suspend(void)
 	omap2_enter_full_retention();
 
 	omap_writel(mir1, 0x480fe0a4);
-	prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(wken_wkup, WKUP_MOD, PM_WKEN);
 
 	return 0;
 }
@@ -360,7 +360,7 @@ static void __init prcm_setup_regs(void)
 	struct powerdomain *pwrdm;
 
 	/* Enable autoidle */
-	prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
+	omap2_prm_write_mod_reg(OMAP24XX_AUTOIDLE_MASK, OCP_MOD,
 			  OMAP2_PRCM_SYSCONFIG_OFFSET);
 
 	/*
@@ -399,87 +399,87 @@ static void __init prcm_setup_regs(void)
 	clkdm_add_wkdep(mpu_clkdm, wkup_clkdm);
 
 	/* Enable clock autoidle for all domains */
-	cm_write_mod_reg(OMAP24XX_AUTO_CAM_MASK |
-			 OMAP24XX_AUTO_MAILBOXES_MASK |
-			 OMAP24XX_AUTO_WDT4_MASK |
-			 OMAP2420_AUTO_WDT3_MASK |
-			 OMAP24XX_AUTO_MSPRO_MASK |
-			 OMAP2420_AUTO_MMC_MASK |
-			 OMAP24XX_AUTO_FAC_MASK |
-			 OMAP2420_AUTO_EAC_MASK |
-			 OMAP24XX_AUTO_HDQ_MASK |
-			 OMAP24XX_AUTO_UART2_MASK |
-			 OMAP24XX_AUTO_UART1_MASK |
-			 OMAP24XX_AUTO_I2C2_MASK |
-			 OMAP24XX_AUTO_I2C1_MASK |
-			 OMAP24XX_AUTO_MCSPI2_MASK |
-			 OMAP24XX_AUTO_MCSPI1_MASK |
-			 OMAP24XX_AUTO_MCBSP2_MASK |
-			 OMAP24XX_AUTO_MCBSP1_MASK |
-			 OMAP24XX_AUTO_GPT12_MASK |
-			 OMAP24XX_AUTO_GPT11_MASK |
-			 OMAP24XX_AUTO_GPT10_MASK |
-			 OMAP24XX_AUTO_GPT9_MASK |
-			 OMAP24XX_AUTO_GPT8_MASK |
-			 OMAP24XX_AUTO_GPT7_MASK |
-			 OMAP24XX_AUTO_GPT6_MASK |
-			 OMAP24XX_AUTO_GPT5_MASK |
-			 OMAP24XX_AUTO_GPT4_MASK |
-			 OMAP24XX_AUTO_GPT3_MASK |
-			 OMAP24XX_AUTO_GPT2_MASK |
-			 OMAP2420_AUTO_VLYNQ_MASK |
-			 OMAP24XX_AUTO_DSS_MASK,
-			 CORE_MOD, CM_AUTOIDLE1);
-	cm_write_mod_reg(OMAP24XX_AUTO_UART3_MASK |
-			 OMAP24XX_AUTO_SSI_MASK |
-			 OMAP24XX_AUTO_USB_MASK,
-			 CORE_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(OMAP24XX_AUTO_SDRC_MASK |
-			 OMAP24XX_AUTO_GPMC_MASK |
-			 OMAP24XX_AUTO_SDMA_MASK,
-			 CORE_MOD, CM_AUTOIDLE3);
-	cm_write_mod_reg(OMAP24XX_AUTO_PKA_MASK |
-			 OMAP24XX_AUTO_AES_MASK |
-			 OMAP24XX_AUTO_RNG_MASK |
-			 OMAP24XX_AUTO_SHA_MASK |
-			 OMAP24XX_AUTO_DES_MASK,
-			 CORE_MOD, OMAP24XX_CM_AUTOIDLE4);
-
-	cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI_MASK, OMAP24XX_DSP_MOD,
-			 CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(OMAP24XX_AUTO_CAM_MASK |
+			       OMAP24XX_AUTO_MAILBOXES_MASK |
+			       OMAP24XX_AUTO_WDT4_MASK |
+			       OMAP2420_AUTO_WDT3_MASK |
+			       OMAP24XX_AUTO_MSPRO_MASK |
+			       OMAP2420_AUTO_MMC_MASK |
+			       OMAP24XX_AUTO_FAC_MASK |
+			       OMAP2420_AUTO_EAC_MASK |
+			       OMAP24XX_AUTO_HDQ_MASK |
+			       OMAP24XX_AUTO_UART2_MASK |
+			       OMAP24XX_AUTO_UART1_MASK |
+			       OMAP24XX_AUTO_I2C2_MASK |
+			       OMAP24XX_AUTO_I2C1_MASK |
+			       OMAP24XX_AUTO_MCSPI2_MASK |
+			       OMAP24XX_AUTO_MCSPI1_MASK |
+			       OMAP24XX_AUTO_MCBSP2_MASK |
+			       OMAP24XX_AUTO_MCBSP1_MASK |
+			       OMAP24XX_AUTO_GPT12_MASK |
+			       OMAP24XX_AUTO_GPT11_MASK |
+			       OMAP24XX_AUTO_GPT10_MASK |
+			       OMAP24XX_AUTO_GPT9_MASK |
+			       OMAP24XX_AUTO_GPT8_MASK |
+			       OMAP24XX_AUTO_GPT7_MASK |
+			       OMAP24XX_AUTO_GPT6_MASK |
+			       OMAP24XX_AUTO_GPT5_MASK |
+			       OMAP24XX_AUTO_GPT4_MASK |
+			       OMAP24XX_AUTO_GPT3_MASK |
+			       OMAP24XX_AUTO_GPT2_MASK |
+			       OMAP2420_AUTO_VLYNQ_MASK |
+			       OMAP24XX_AUTO_DSS_MASK,
+			       CORE_MOD, CM_AUTOIDLE1);
+	omap2_cm_write_mod_reg(OMAP24XX_AUTO_UART3_MASK |
+			       OMAP24XX_AUTO_SSI_MASK |
+			       OMAP24XX_AUTO_USB_MASK,
+			       CORE_MOD, CM_AUTOIDLE2);
+	omap2_cm_write_mod_reg(OMAP24XX_AUTO_SDRC_MASK |
+			       OMAP24XX_AUTO_GPMC_MASK |
+			       OMAP24XX_AUTO_SDMA_MASK,
+			       CORE_MOD, CM_AUTOIDLE3);
+	omap2_cm_write_mod_reg(OMAP24XX_AUTO_PKA_MASK |
+			       OMAP24XX_AUTO_AES_MASK |
+			       OMAP24XX_AUTO_RNG_MASK |
+			       OMAP24XX_AUTO_SHA_MASK |
+			       OMAP24XX_AUTO_DES_MASK,
+			       CORE_MOD, OMAP24XX_CM_AUTOIDLE4);
+
+	omap2_cm_write_mod_reg(OMAP2420_AUTO_DSP_IPI_MASK, OMAP24XX_DSP_MOD,
+			       CM_AUTOIDLE);
 
 	/* Put DPLL and both APLLs into autoidle mode */
-	cm_write_mod_reg((0x03 << OMAP24XX_AUTO_DPLL_SHIFT) |
-			 (0x03 << OMAP24XX_AUTO_96M_SHIFT) |
-			 (0x03 << OMAP24XX_AUTO_54M_SHIFT),
-			 PLL_MOD, CM_AUTOIDLE);
-
-	cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL_MASK |
-			 OMAP24XX_AUTO_WDT1_MASK |
-			 OMAP24XX_AUTO_MPU_WDT_MASK |
-			 OMAP24XX_AUTO_GPIOS_MASK |
-			 OMAP24XX_AUTO_32KSYNC_MASK |
-			 OMAP24XX_AUTO_GPT1_MASK,
-			 WKUP_MOD, CM_AUTOIDLE);
+	omap2_cm_write_mod_reg((0x03 << OMAP24XX_AUTO_DPLL_SHIFT) |
+			       (0x03 << OMAP24XX_AUTO_96M_SHIFT) |
+			       (0x03 << OMAP24XX_AUTO_54M_SHIFT),
+			       PLL_MOD, CM_AUTOIDLE);
+
+	omap2_cm_write_mod_reg(OMAP24XX_AUTO_OMAPCTRL_MASK |
+			       OMAP24XX_AUTO_WDT1_MASK |
+			       OMAP24XX_AUTO_MPU_WDT_MASK |
+			       OMAP24XX_AUTO_GPIOS_MASK |
+			       OMAP24XX_AUTO_32KSYNC_MASK |
+			       OMAP24XX_AUTO_GPT1_MASK,
+			       WKUP_MOD, CM_AUTOIDLE);
 
 	/* REVISIT: Configure number of 32 kHz clock cycles for sys_clk
 	 * stabilisation */
-	prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
-			  OMAP2_PRCM_CLKSSETUP_OFFSET);
+	omap2_prm_write_mod_reg(15 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+				OMAP2_PRCM_CLKSSETUP_OFFSET);
 
 	/* Configure automatic voltage transition */
-	prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
-			  OMAP2_PRCM_VOLTSETUP_OFFSET);
-	prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
-			  (0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
-			  OMAP24XX_MEMRETCTRL_MASK |
-			  (0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
-			  (0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
-			  OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
+	omap2_prm_write_mod_reg(2 << OMAP_SETUP_TIME_SHIFT, OMAP24XX_GR_MOD,
+				OMAP2_PRCM_VOLTSETUP_OFFSET);
+	omap2_prm_write_mod_reg(OMAP24XX_AUTO_EXTVOLT_MASK |
+				(0x1 << OMAP24XX_SETOFF_LEVEL_SHIFT) |
+				OMAP24XX_MEMRETCTRL_MASK |
+				(0x1 << OMAP24XX_SETRET_LEVEL_SHIFT) |
+				(0x0 << OMAP24XX_VOLT_LEVEL_SHIFT),
+				OMAP24XX_GR_MOD, OMAP2_PRCM_VOLTCTRL_OFFSET);
 
 	/* Enable wake-up events */
-	prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
-			  WKUP_MOD, PM_WKEN);
+	omap2_prm_write_mod_reg(OMAP24XX_EN_GPIOS_MASK | OMAP24XX_EN_GPT1_MASK,
+				WKUP_MOD, PM_WKEN);
 }
 
 static int __init omap2_pm_init(void)
@@ -490,7 +490,7 @@ static int __init omap2_pm_init(void)
 		return -ENODEV;
 
 	printk(KERN_INFO "Power Management for OMAP2 initializing\n");
-	l = prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
+	l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
 	printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
 
 	/* Look up important powerdomains */
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a776241..8ea8051 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -89,12 +89,12 @@ static void omap3_enable_io_chain(void)
 	int timeout = 0;
 
 	if (omap_rev() >= OMAP3430_REV_ES3_1) {
-		prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
 				     PM_WKEN);
 		/* Do a readback to assure write has been done */
-		prm_read_mod_reg(WKUP_MOD, PM_WKEN);
+		omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN);
 
-		while (!(prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
+		while (!(omap2_prm_read_mod_reg(WKUP_MOD, PM_WKEN) &
 			 OMAP3430_ST_IO_CHAIN_MASK)) {
 			timeout++;
 			if (timeout > 1000) {
@@ -102,7 +102,7 @@ static void omap3_enable_io_chain(void)
 				       "activation failed.\n");
 				return;
 			}
-			prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
+			omap2_prm_set_mod_reg_bits(OMAP3430_ST_IO_CHAIN_MASK,
 					     WKUP_MOD, PM_WKEN);
 		}
 	}
@@ -111,7 +111,7 @@ static void omap3_enable_io_chain(void)
 static void omap3_disable_io_chain(void)
 {
 	if (omap_rev() >= OMAP3430_REV_ES3_1)
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_CHAIN_MASK, WKUP_MOD,
 				       PM_WKEN);
 }
 
@@ -205,27 +205,27 @@ static int prcm_clear_mod_irqs(s16 module, u8 regs)
 		OMAP3430ES2_PM_MPUGRPSEL3 : OMAP3430_PM_MPUGRPSEL;
 	int c = 0;
 
-	wkst = prm_read_mod_reg(module, wkst_off);
-	wkst &= prm_read_mod_reg(module, grpsel_off);
+	wkst = omap2_prm_read_mod_reg(module, wkst_off);
+	wkst &= omap2_prm_read_mod_reg(module, grpsel_off);
 	if (wkst) {
-		iclk = cm_read_mod_reg(module, iclk_off);
-		fclk = cm_read_mod_reg(module, fclk_off);
+		iclk = omap2_cm_read_mod_reg(module, iclk_off);
+		fclk = omap2_cm_read_mod_reg(module, fclk_off);
 		while (wkst) {
 			clken = wkst;
-			cm_set_mod_reg_bits(clken, module, iclk_off);
+			omap2_cm_set_mod_reg_bits(clken, module, iclk_off);
 			/*
 			 * For USBHOST, we don't know whether HOST1 or
 			 * HOST2 woke us up, so enable both f-clocks
 			 */
 			if (module == OMAP3430ES2_USBHOST_MOD)
 				clken |= 1 << OMAP3430ES2_EN_USBHOST2_SHIFT;
-			cm_set_mod_reg_bits(clken, module, fclk_off);
-			prm_write_mod_reg(wkst, module, wkst_off);
-			wkst = prm_read_mod_reg(module, wkst_off);
+			omap2_cm_set_mod_reg_bits(clken, module, fclk_off);
+			omap2_prm_write_mod_reg(wkst, module, wkst_off);
+			wkst = omap2_prm_read_mod_reg(module, wkst_off);
 			c++;
 		}
-		cm_write_mod_reg(iclk, module, iclk_off);
-		cm_write_mod_reg(fclk, module, fclk_off);
+		omap2_cm_write_mod_reg(iclk, module, iclk_off);
+		omap2_cm_write_mod_reg(fclk, module, fclk_off);
 	}
 
 	return c;
@@ -268,9 +268,9 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 	u32 irqenable_mpu, irqstatus_mpu;
 	int c = 0;
 
-	irqenable_mpu = prm_read_mod_reg(OCP_MOD,
+	irqenable_mpu = omap2_prm_read_mod_reg(OCP_MOD,
 					 OMAP3_PRM_IRQENABLE_MPU_OFFSET);
-	irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+	irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
 					 OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 	irqstatus_mpu &= irqenable_mpu;
 
@@ -291,10 +291,10 @@ static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
 			     "no code to handle it (%08x)\n", irqstatus_mpu);
 		}
 
-		prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
+		omap2_prm_write_mod_reg(irqstatus_mpu, OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
-		irqstatus_mpu = prm_read_mod_reg(OCP_MOD,
+		irqstatus_mpu = omap2_prm_read_mod_reg(OCP_MOD,
 					OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 		irqstatus_mpu &= irqenable_mpu;
 
@@ -382,7 +382,7 @@ void omap_sram_idle(void)
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
-		prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
+		omap2_prm_set_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
 
@@ -454,7 +454,7 @@ void omap_sram_idle(void)
 		omap_uart_resume_idle(0);
 		omap_uart_resume_idle(1);
 		if (core_next_state == PWRDM_POWER_OFF)
-			prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
+			omap2_prm_clear_mod_reg_bits(OMAP3430_AUTO_OFF_MASK,
 					       OMAP3430_GR_MOD,
 					       OMAP3_PRM_VOLTCTRL_OFFSET);
 	}
@@ -477,7 +477,8 @@ console_still_active:
 	if (omap3_has_io_wakeup() &&
 	    (per_next_state < PWRDM_POWER_ON ||
 	     core_next_state < PWRDM_POWER_ON)) {
-		prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD, PM_WKEN);
+		omap2_prm_clear_mod_reg_bits(OMAP3430_EN_IO_MASK, WKUP_MOD,
+					     PM_WKEN);
 		omap3_disable_io_chain();
 	}
 
@@ -628,21 +629,21 @@ static struct platform_suspend_ops omap_pm_ops = {
 static void __init omap3_iva_idle(void)
 {
 	/* ensure IVA2 clock is disabled */
-	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* if no clock activity, nothing else to do */
-	if (!(cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
+	if (!(omap2_cm_read_mod_reg(OMAP3430_IVA2_MOD, OMAP3430_CM_CLKSTST) &
 	      OMAP3430_CLKACTIVITY_IVA2_MASK))
 		return;
 
 	/* Reset IVA2 */
-	prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
 			  OMAP3430_RST2_IVA2_MASK |
 			  OMAP3430_RST3_IVA2_MASK,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Enable IVA2 clock */
-	cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
+	omap2_cm_write_mod_reg(OMAP3430_CM_FCLKEN_IVA2_EN_IVA2_MASK,
 			 OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* Set IVA2 boot mode to 'idle' */
@@ -650,13 +651,13 @@ static void __init omap3_iva_idle(void)
 			 OMAP343X_CONTROL_IVA2_BOOTMOD);
 
 	/* Un-reset IVA2 */
-	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
+	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
 
 	/* Disable IVA2 clock */
-	cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
+	omap2_cm_write_mod_reg(0, OMAP3430_IVA2_MOD, CM_FCLKEN);
 
 	/* Reset IVA2 */
-	prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_RST1_IVA2_MASK |
 			  OMAP3430_RST2_IVA2_MASK |
 			  OMAP3430_RST3_IVA2_MASK,
 			  OMAP3430_IVA2_MOD, OMAP2_RM_RSTCTRL);
@@ -680,10 +681,10 @@ static void __init omap3_d2d_idle(void)
 	omap_ctrl_writew(padconf, OMAP3_PADCONF_SAD2D_IDLEACK);
 
 	/* reset modem */
-	prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RSTPWRON_MASK |
 			  OMAP3430_RM_RSTCTRL_CORE_MODEM_SW_RST_MASK,
 			  CORE_MOD, OMAP2_RM_RSTCTRL);
-	prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP2_RM_RSTCTRL);
 }
 
 static void __init prcm_setup_regs(void)
@@ -698,23 +699,23 @@ static void __init prcm_setup_regs(void)
 
 	/* XXX Reset all wkdeps. This should be done when initializing
 	 * powerdomains */
-	prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
-	prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_IVA2_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, MPU_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_DSS_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_NEON_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_CAM_MOD, PM_WKDEP);
+	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, PM_WKDEP);
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
-		prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
+		omap2_prm_write_mod_reg(0, OMAP3430ES2_SGX_MOD, PM_WKDEP);
+		omap2_prm_write_mod_reg(0, OMAP3430ES2_USBHOST_MOD, PM_WKDEP);
 	} else
-		prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
+		omap2_prm_write_mod_reg(0, GFX_MOD, PM_WKDEP);
 
 	/*
 	 * Enable interface clock autoidle for all modules.
 	 * Note that in the long run this should be done by clockfw
 	 */
-	cm_write_mod_reg(
+	omap2_cm_write_mod_reg(
 		OMAP3430_AUTO_MODEM_MASK |
 		OMAP3430ES2_AUTO_MMC3_MASK |
 		OMAP3430ES2_AUTO_ICR_MASK |
@@ -747,7 +748,7 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_AUTO_SSI_MASK,
 		CORE_MOD, CM_AUTOIDLE1);
 
-	cm_write_mod_reg(
+	omap2_cm_write_mod_reg(
 		OMAP3430_AUTO_PKA_MASK |
 		OMAP3430_AUTO_AES1_MASK |
 		OMAP3430_AUTO_RNG_MASK |
@@ -756,13 +757,13 @@ static void __init prcm_setup_regs(void)
 		CORE_MOD, CM_AUTOIDLE2);
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		cm_write_mod_reg(
+		omap2_cm_write_mod_reg(
 			OMAP3430_AUTO_MAD2D_MASK |
 			OMAP3430ES2_AUTO_USBTLL_MASK,
 			CORE_MOD, CM_AUTOIDLE3);
 	}
 
-	cm_write_mod_reg(
+	omap2_cm_write_mod_reg(
 		OMAP3430_AUTO_WDT2_MASK |
 		OMAP3430_AUTO_WDT1_MASK |
 		OMAP3430_AUTO_GPIO1_MASK |
@@ -771,17 +772,17 @@ static void __init prcm_setup_regs(void)
 		OMAP3430_AUTO_GPT1_MASK,
 		WKUP_MOD, CM_AUTOIDLE);
 
-	cm_write_mod_reg(
+	omap2_cm_write_mod_reg(
 		OMAP3430_AUTO_DSS_MASK,
 		OMAP3430_DSS_MOD,
 		CM_AUTOIDLE);
 
-	cm_write_mod_reg(
+	omap2_cm_write_mod_reg(
 		OMAP3430_AUTO_CAM_MASK,
 		OMAP3430_CAM_MOD,
 		CM_AUTOIDLE);
 
-	cm_write_mod_reg(
+	omap2_cm_write_mod_reg(
 		omap3630_auto_uart4_mask |
 		OMAP3430_AUTO_GPIO6_MASK |
 		OMAP3430_AUTO_GPIO5_MASK |
@@ -805,7 +806,7 @@ static void __init prcm_setup_regs(void)
 		CM_AUTOIDLE);
 
 	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		cm_write_mod_reg(
+		omap2_cm_write_mod_reg(
 			OMAP3430ES2_AUTO_USBHOST_MASK,
 			OMAP3430ES2_USBHOST_MOD,
 			CM_AUTOIDLE);
@@ -817,16 +818,16 @@ static void __init prcm_setup_regs(void)
 	 * Set all plls to autoidle. This is needed until autoidle is
 	 * enabled by clockfw
 	 */
-	cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
+	omap2_cm_write_mod_reg(1 << OMAP3430_AUTO_IVA2_DPLL_SHIFT,
 			 OMAP3430_IVA2_MOD, CM_AUTOIDLE2);
-	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
+	omap2_cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
 			 MPU_MOD,
 			 CM_AUTOIDLE2);
-	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
+	omap2_cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
 			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
 			 PLL_MOD,
 			 CM_AUTOIDLE);
-	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
+	omap2_cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
 			 PLL_MOD,
 			 CM_AUTOIDLE2);
 
@@ -835,31 +836,31 @@ static void __init prcm_setup_regs(void)
 	 * sys_clkreq. In the long run clock framework should
 	 * take care of this.
 	 */
-	prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
+	omap2_prm_rmw_mod_reg_bits(OMAP_AUTOEXTCLKMODE_MASK,
 			     1 << OMAP_AUTOEXTCLKMODE_SHIFT,
 			     OMAP3430_GR_MOD,
 			     OMAP3_PRM_CLKSRC_CTRL_OFFSET);
 
 	/* setup wakup source */
-	prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_EN_IO_MASK | OMAP3430_EN_GPIO1_MASK |
 			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
+	omap2_prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
 			  OMAP3430_GRPSEL_GPT1_MASK |
 			  OMAP3430_GRPSEL_GPT12_MASK,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
-	prm_write_mod_reg(OMAP3430_IO_EN_MASK | OMAP3430_WKUP_EN_MASK,
+	omap2_prm_write_mod_reg(OMAP3430_IO_EN_MASK | OMAP3430_WKUP_EN_MASK,
 			  OCP_MOD, OMAP3_PRM_IRQENABLE_MPU_OFFSET);
 
 	/* Enable PM_WKEN to support DSS LPR */
-	prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
+	omap2_prm_write_mod_reg(OMAP3430_PM_WKEN_DSS_EN_DSS_MASK,
 				OMAP3430_DSS_MOD, PM_WKEN);
 
 	/* Enable wakeups in PER */
-	prm_write_mod_reg(omap3630_en_uart4_mask |
+	omap2_prm_write_mod_reg(omap3630_en_uart4_mask |
 			  OMAP3430_EN_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK |
 			  OMAP3430_EN_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
 			  OMAP3430_EN_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
@@ -867,7 +868,7 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(omap3630_grpsel_uart4_mask |
+	omap2_prm_write_mod_reg(omap3630_grpsel_uart4_mask |
 			  OMAP3430_GRPSEL_GPIO2_MASK |
 			  OMAP3430_GRPSEL_GPIO3_MASK |
 			  OMAP3430_GRPSEL_GPIO4_MASK |
@@ -880,22 +881,22 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
 
 	/* Don't attach IVA interrupts */
-	prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
-	prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
-	prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
-	prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
+	omap2_prm_write_mod_reg(0, WKUP_MOD, OMAP3430_PM_IVAGRPSEL);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430_PM_IVAGRPSEL1);
+	omap2_prm_write_mod_reg(0, CORE_MOD, OMAP3430ES2_PM_IVAGRPSEL3);
+	omap2_prm_write_mod_reg(0, OMAP3430_PER_MOD, OMAP3430_PM_IVAGRPSEL);
 
 	/* Clear any pending 'reset' flags */
-	prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
-	prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, MPU_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, CORE_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_PER_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_EMU_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_NEON_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430_DSS_MOD, OMAP2_RM_RSTST);
+	omap2_prm_write_mod_reg(0xffffffff, OMAP3430ES2_USBHOST_MOD, OMAP2_RM_RSTST);
 
 	/* Clear any pending PRCM interrupts */
-	prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
+	omap2_prm_write_mod_reg(0, OCP_MOD, OMAP3_PRM_IRQSTATUS_MPU_OFFSET);
 
 	omap3_iva_idle();
 	omap3_d2d_idle();
diff --git a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
index 838ac75..b5e9e4d 100644
--- a/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/powerdomain2xxx_3xxx.c
@@ -28,7 +28,7 @@
 /* Common functions across OMAP2 and OMAP3 */
 static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 				(pwrst << OMAP_POWERSTATE_SHIFT),
 				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 	return 0;
@@ -36,14 +36,16 @@ static int omap2_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 static int omap2_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				OMAP2_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTCTRL,
+					     OMAP_POWERSTATE_MASK);
 }
 
 static int omap2_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
-				OMAP2_PM_PWSTST, OMAP_POWERSTATEST_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTST,
+					     OMAP_POWERSTATEST_MASK);
 }
 
 static int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
@@ -53,8 +55,8 @@ static int omap2_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
 
 	m = omap2_pwrdm_get_mem_bank_onstate_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-				OMAP2_PM_PWSTCTRL);
+	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+				   OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -66,8 +68,8 @@ static int omap2_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
 
 	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
-				OMAP2_PM_PWSTCTRL);
+	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+				   OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -78,7 +80,8 @@ static int omap2_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 
 	m = omap2_pwrdm_get_mem_bank_stst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST, m);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
+					     m);
 }
 
 static int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
@@ -87,7 +90,8 @@ static int omap2_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 
 	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL, m);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTCTRL, m);
 }
 
 static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
@@ -95,8 +99,8 @@ static int omap2_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	u32 v;
 
 	v = pwrst << __ffs(OMAP3430_LOGICL1CACHERETSTATE_MASK);
-	prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
-				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+	omap2_prm_rmw_mod_reg_bits(OMAP3430_LOGICL1CACHERETSTATE_MASK, v,
+				   pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 
 	return 0;
 }
@@ -112,7 +116,7 @@ static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
+	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP2_PM_PWSTST) &
 		OMAP_INTRANSITION_MASK) &&
 		(c++ < PWRDM_TRANSITION_BAILOUT))
 			udelay(1);
@@ -131,26 +135,30 @@ static int omap2_pwrdm_wait_transition(struct powerdomain *pwrdm)
 /* Applicable only for OMAP3. Not supported on OMAP2 */
 static int omap3_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
-				OMAP3430_LASTPOWERSTATEENTERED_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP3430_PM_PREPWSTST,
+					     OMAP3430_LASTPOWERSTATEENTERED_MASK);
 }
 
 static int omap3_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTST,
-				OMAP3430_LOGICSTATEST_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTST,
+					     OMAP3430_LOGICSTATEST_MASK);
 }
 
 static int omap3_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL,
-				OMAP3430_LOGICSTATEST_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP2_PM_PWSTCTRL,
+					     OMAP3430_LOGICSTATEST_MASK);
 }
 
 static int omap3_pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST,
-				OMAP3430_LASTLOGICSTATEENTERED_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP3430_PM_PREPWSTST,
+					     OMAP3430_LASTLOGICSTATEENTERED_MASK);
 }
 
 static int omap3_get_mem_bank_lastmemst_mask(u8 bank)
@@ -177,26 +185,28 @@ static int omap3_pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 
 	m = omap3_get_mem_bank_lastmemst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP3430_PM_PREPWSTST, m);
 }
 
 static int omap3_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 {
-	prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
+	omap2_prm_write_mod_reg(0, pwrdm->prcm_offs, OMAP3430_PM_PREPWSTST);
 	return 0;
 }
 
 static int omap3_pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm)
 {
-	return prm_rmw_mod_reg_bits(0, 1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
-				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+	return omap2_prm_rmw_mod_reg_bits(0,
+					  1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
+					  pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
 }
 
 static int omap3_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 {
-	return prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT, 0,
-				pwrdm->prcm_offs, OMAP2_PM_PWSTCTRL);
+	return omap2_prm_rmw_mod_reg_bits(1 << OMAP3430ES2_SAVEANDRESTORE_SHIFT,
+					  0, pwrdm->prcm_offs,
+					  OMAP2_PM_PWSTCTRL);
 }
 
 struct pwrdm_ops omap2_pwrdm_operations = {
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index dae767b..4c5ab1a 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -25,7 +25,7 @@
 
 static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 {
-	prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
 				(pwrst << OMAP_POWERSTATE_SHIFT),
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 	return 0;
@@ -33,25 +33,25 @@ static int omap4_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
 
 static int omap4_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP4_PM_PWSTCTRL, OMAP_POWERSTATE_MASK);
 }
 
 static int omap4_pwrdm_read_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
 				OMAP4_PM_PWSTST, OMAP_POWERSTATEST_MASK);
 }
 
 static int omap4_pwrdm_read_prev_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
 				OMAP4430_LASTPOWERSTATEENTERED_MASK);
 }
 
 static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 {
-	prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
+	omap2_prm_rmw_mod_reg_bits(OMAP4430_LOWPOWERSTATECHANGE_MASK,
 				(1 << OMAP4430_LOWPOWERSTATECHANGE_SHIFT),
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 	return 0;
@@ -59,7 +59,7 @@ static int omap4_pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm)
 
 static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 {
-	prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
+	omap2_prm_rmw_mod_reg_bits(OMAP4430_LASTPOWERSTATEENTERED_MASK,
 				OMAP4430_LASTPOWERSTATEENTERED_MASK,
 				pwrdm->prcm_offs, OMAP4_PM_PWSTST);
 	return 0;
@@ -70,7 +70,7 @@ static int omap4_pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst)
 	u32 v;
 
 	v = pwrst << __ffs(OMAP4430_LOGICRETSTATE_MASK);
-	prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
+	omap2_prm_rmw_mod_reg_bits(OMAP4430_LOGICRETSTATE_MASK, v,
 				pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL);
 
 	return 0;
@@ -83,7 +83,7 @@ static int omap4_pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank,
 
 	m = omap2_pwrdm_get_mem_bank_onstate_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
 				OMAP4_PM_PWSTCTRL);
 
 	return 0;
@@ -96,7 +96,7 @@ static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
 
 	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
 
-	prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
+	omap2_prm_rmw_mod_reg_bits(m, (pwrst << __ffs(m)), pwrdm->prcm_offs,
 				OMAP4_PM_PWSTCTRL);
 
 	return 0;
@@ -104,14 +104,15 @@ static int omap4_pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank,
 
 static int omap4_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
 				OMAP4430_LOGICSTATEST_MASK);
 }
 
 static int omap4_pwrdm_read_logic_retst(struct powerdomain *pwrdm)
 {
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL,
-				OMAP4430_LOGICRETSTATE_MASK);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP4_PM_PWSTCTRL,
+					     OMAP4430_LOGICRETSTATE_MASK);
 }
 
 static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
@@ -120,7 +121,8 @@ static int omap4_pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank)
 
 	m = omap2_pwrdm_get_mem_bank_stst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST, m);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTST,
+					     m);
 }
 
 static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
@@ -129,7 +131,8 @@ static int omap4_pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank)
 
 	m = omap2_pwrdm_get_mem_bank_retst_mask(bank);
 
-	return prm_read_mod_bits_shift(pwrdm->prcm_offs, OMAP4_PM_PWSTCTRL, m);
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     OMAP4_PM_PWSTCTRL, m);
 }
 
 static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
@@ -143,7 +146,7 @@ static int omap4_pwrdm_wait_transition(struct powerdomain *pwrdm)
 	 */
 
 	/* XXX Is this udelay() value meaningful? */
-	while ((prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
+	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs, OMAP4_PM_PWSTST) &
 		OMAP_INTRANSITION_MASK) &&
 		(c++ < PWRDM_TRANSITION_BAILOUT))
 			udelay(1);
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index 68c541f..c22e726 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -17,7 +17,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#include <linux/module.h>
+
+#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -30,10 +31,9 @@
 #include "clock.h"
 #include "clock2xxx.h"
 #include "cm2xxx_3xxx.h"
-#include "cm44xx.h"
 #include "prm2xxx_3xxx.h"
 #include "prm44xx.h"
-#include "prcm44xx.h"
+#include "prminst44xx.h"
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-44xx.h"
 #include "control.h"
@@ -48,9 +48,9 @@ u32 omap_prcm_get_reset_sources(void)
 {
 	/* XXX This presumably needs modification for 34XX */
 	if (cpu_is_omap24xx() || cpu_is_omap34xx())
-		return prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
+		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP2_RM_RSTST) & 0x7f;
 	if (cpu_is_omap44xx())
-		return prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
+		return omap2_prm_read_mod_reg(WKUP_MOD, OMAP4_RM_RSTST) & 0x7f;
 
 	return 0;
 }
@@ -75,9 +75,9 @@ void omap_prcm_arch_reset(char mode, const char *cmd)
 	}
 
 	/* XXX should be moved to some OMAP2/3 specific code */
-	prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
-			     OMAP2_RM_RSTCTRL);
-	prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
+	omap2_prm_set_mod_reg_bits(OMAP_RST_DPLL3_MASK, prcm_offs,
+				   OMAP2_RM_RSTCTRL);
+	omap2_prm_read_mod_reg(prcm_offs, OMAP2_RM_RSTCTRL); /* OCP barrier */
 }
 
 /**
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index 3e1d36c..ec03625 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -25,49 +25,49 @@
 #include "prm-regbits-24xx.h"
 #include "prm-regbits-34xx.h"
 
-u32 prm_read_mod_reg(s16 module, u16 idx)
+u32 omap2_prm_read_mod_reg(s16 module, u16 idx)
 {
 	return __raw_readl(prm_base + module + idx);
 }
 
-void prm_write_mod_reg(u32 val, s16 module, u16 idx)
+void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx)
 {
 	__raw_writel(val, prm_base + module + idx);
 }
 
 /* Read-modify-write a register in a PRM module. Caller must lock */
-u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
+u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx)
 {
 	u32 v;
 
-	v = prm_read_mod_reg(module, idx);
+	v = omap2_prm_read_mod_reg(module, idx);
 	v &= ~mask;
 	v |= bits;
-	prm_write_mod_reg(v, module, idx);
+	omap2_prm_write_mod_reg(v, module, idx);
 
 	return v;
 }
 
 /* Read a PRM register, AND it, and shift the result down to bit 0 */
-u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
+u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask)
 {
 	u32 v;
 
-	v = prm_read_mod_reg(domain, idx);
+	v = omap2_prm_read_mod_reg(domain, idx);
 	v &= mask;
 	v >>= __ffs(mask);
 
 	return v;
 }
 
-u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
+u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
-	return prm_rmw_mod_reg_bits(bits, bits, module, idx);
+	return omap2_prm_rmw_mod_reg_bits(bits, bits, module, idx);
 }
 
-u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
+u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx)
 {
-	return prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
+	return omap2_prm_rmw_mod_reg_bits(bits, 0x0, module, idx);
 }
 
 
@@ -86,7 +86,7 @@ int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift)
 	if (!(cpu_is_omap24xx() || cpu_is_omap34xx()))
 		return -EINVAL;
 
-	return prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL,
+	return omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL,
 				       (1 << shift));
 }
 
@@ -110,7 +110,7 @@ int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift)
 		return -EINVAL;
 
 	mask = 1 << shift;
-	prm_rmw_mod_reg_bits(mask, mask, prm_mod, OMAP2_RM_RSTCTRL);
+	omap2_prm_rmw_mod_reg_bits(mask, mask, prm_mod, OMAP2_RM_RSTCTRL);
 
 	return 0;
 }
@@ -140,15 +140,15 @@ int omap2_prm_deassert_hardreset(s16 prm_mod, u8 shift)
 	mask = 1 << shift;
 
 	/* Check the current status to avoid de-asserting the line twice */
-	if (prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL, mask) == 0)
+	if (omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTCTRL, mask) == 0)
 		return -EEXIST;
 
 	/* Clear the reset status by writing 1 to the status bit */
-	prm_rmw_mod_reg_bits(0xffffffff, mask, prm_mod, OMAP2_RM_RSTST);
+	omap2_prm_rmw_mod_reg_bits(0xffffffff, mask, prm_mod, OMAP2_RM_RSTST);
 	/* de-assert the reset control line */
-	prm_rmw_mod_reg_bits(mask, 0, prm_mod, OMAP2_RM_RSTCTRL);
+	omap2_prm_rmw_mod_reg_bits(mask, 0, prm_mod, OMAP2_RM_RSTCTRL);
 	/* wait the status to be set */
-	omap_test_timeout(prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTST,
+	omap_test_timeout(omap2_prm_read_mod_bits_shift(prm_mod, OMAP2_RM_RSTST,
 						  mask),
 			  MAX_MODULE_HARDRESET_WAIT, c);
 
diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index ab28517..53d44f6 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -230,12 +230,12 @@
 #ifndef __ASSEMBLER__
 
 /* Power/reset management domain register get/set */
-extern u32 prm_read_mod_reg(s16 module, u16 idx);
-extern void prm_write_mod_reg(u32 val, s16 module, u16 idx);
-extern u32 prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
-extern u32 prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
-extern u32 prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
-extern u32 prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
+extern u32 omap2_prm_read_mod_reg(s16 module, u16 idx);
+extern void omap2_prm_write_mod_reg(u32 val, s16 module, u16 idx);
+extern u32 omap2_prm_rmw_mod_reg_bits(u32 mask, u32 bits, s16 module, s16 idx);
+extern u32 omap2_prm_set_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 omap2_prm_clear_mod_reg_bits(u32 bits, s16 module, s16 idx);
+extern u32 omap2_prm_read_mod_bits_shift(s16 domain, s16 idx, u32 mask);
 
 /* These omap2_ PRM functions apply to both OMAP2 and 3 */
 extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 64778b6..ccdb010 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -99,6 +99,10 @@ u32 omap2xxx_sdrc_reprogram(u32 level, u32 force)
 	m_type = omap2xxx_sdrc_get_type();
 
 	local_irq_save(flags);
+	/*
+	 * XXX These calls should be abstracted out through a
+	 * prm2xxx.c function
+	 */
 	if (cpu_is_omap2420())
 		__raw_writel(0xffff, OMAP2420_PRCM_VOLTSETUP);
 	else
diff --git a/arch/arm/mach-omap2/serial.c b/arch/arm/mach-omap2/serial.c
index a60ac51..149b896 100644
--- a/arch/arm/mach-omap2/serial.c
+++ b/arch/arm/mach-omap2/serial.c
@@ -492,6 +492,7 @@ static void omap_uart_idle_init(struct omap_uart_state *uart)
 		u32 wk_mask = 0;
 		u32 padconf = 0;
 
+		/* XXX These PRM accesses do not belong here */
 		uart->wk_en = OMAP34XX_PRM_REGADDR(mod, PM_WKEN1);
 		uart->wk_st = OMAP34XX_PRM_REGADDR(mod, PM_WKST1);
 		switch (uart->num) {
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index e66ad3e..9634d39 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -236,9 +236,9 @@ static void omap_st_on(struct omap_mcbsp *mcbsp)
 	 * Sidetone uses McBSP ICLK - which must not idle when sidetones
 	 * are enabled or sidetones start sounding ugly.
 	 */
-	w = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
 	w &= ~(1 << (mcbsp->id - 2));
-	cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
 
 	/* Enable McBSP Sidetone */
 	w = MCBSP_READ(mcbsp, SSELCR);
@@ -265,9 +265,9 @@ static void omap_st_off(struct omap_mcbsp *mcbsp)
 	w = MCBSP_READ(mcbsp, SSELCR);
 	MCBSP_WRITE(mcbsp, SSELCR, w & ~(SIDETONEEN));
 
-	w = cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
+	w = omap2_cm_read_mod_reg(OMAP3430_PER_MOD, CM_AUTOIDLE);
 	w |= 1 << (mcbsp->id - 2);
-	cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
+	omap2_cm_write_mod_reg(w, OMAP3430_PER_MOD, CM_AUTOIDLE);
 }
 
 static void omap_st_fir_write(struct omap_mcbsp *mcbsp, s16 *fir)


