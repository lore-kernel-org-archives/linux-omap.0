From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: [PATCH] OMAP3 PM: dll lock WA
Date: Wed, 12 May 2010 11:59:25 +0300
Message-ID: <1273654765-5212-1-git-send-email-peter.de-schrijver@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:61838 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753588Ab0ELJAW (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 12 May 2010 05:00:22 -0400
Received: from vaebh106.NOE.Nokia.com (vaebh106.europe.nokia.com [10.160.244.32])
	by mgw-mx06.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o4C90IPe027637
	for <linux-omap@vger.kernel.org>; Wed, 12 May 2010 12:00:20 +0300
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

This is my version of the TI dll lock work around. Changes from the TI version
include :
+ Prevent core retention when DSS is on. This seems to work better for us then
  checking the clock activity bits.
+ Determine min_opp and max_opp once at boottime.
+ Unify the workaround functions for OMAP3430 and OMAP3630.
+ Implement omap_voltage_scale() as we don't have the new smartreflex code
  integrated in our tree.

Note that this patch is only intended to clarify our approach. It needs more
work for upstream acceptance.

Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c  |    5 ++-
 arch/arm/mach-omap2/pm.h           |    4 ++
 arch/arm/mach-omap2/pm34xx.c       |   31 +++++++++++---
 arch/arm/mach-omap2/resource34xx.c |   78 +++++++++++++++++++++++++++++++++++-
 4 files changed, 109 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1cb64c1..5b71cb3 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -223,13 +223,16 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		else
 			per_state = saved_per_state;
 
+		dss_state = pwrdm_read_pwrst(dss_pd);
+		if (dss_state == PWRDM_POWER_ON)
+			new_core_state = PWRDM_POWER_INACTIVE;
+
 		/*
 		 * If we are attempting CORE off, check if any other
 		 * powerdomains are at retention or higher. CORE off causes
 		 * chipwide reset which would reset these domains also.
 		 */
 		if (new_core_state == PWRDM_POWER_OFF) {
-			dss_state = pwrdm_read_pwrst(dss_pd);
 			iva2_state = pwrdm_read_pwrst(iva2_pd);
 			sgx_state = pwrdm_read_pwrst(sgx_pd);
 			usb_state = pwrdm_read_pwrst(usb_pd);
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 7b6e291..ccedd6c 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -72,6 +72,10 @@ extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
 extern int omap3_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 extern int omap3_pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
+extern int program_vdd2_opp_dll_wa(struct omap_opp *min_opp,
+					struct omap_opp *max_opp);
+extern int reprogram_vdd2_opp_dll_wa(struct omap_opp *min_opp,
+					struct omap_opp *max_opp);
 
 extern u32 resume_action;
 
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index a1a948a..034e147 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -115,6 +115,7 @@ static struct prm_setup_vc prm_setup = {
 	.vdd1_off = 0x00,	/* 0.6v */
 };
 
+static struct omap_opp *min_opp, *max_opp;
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -376,6 +377,7 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
+	u32 fclk_status = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -404,6 +406,15 @@ void omap_sram_idle(void)
 
 	pwrdm_pre_transition();
 
+	core_next_state = omap3_pwrdm_read_next_pwrst(core_pwrdm);
+	if (core_next_state <= PWRDM_POWER_RET) {
+		disable_smartreflex(SR2);
+		program_vdd2_opp_dll_wa(min_opp, max_opp);
+		cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
+				0x1, PLL_MOD, CM_AUTOIDLE);
+	}
+
+
 	/* NEON control */
 	if (pwrdm_read_pwrst(neon_pwrdm) == PWRDM_POWER_ON) {
 		omap3_pwrdm_set_next_pwrst(neon_pwrdm, mpu_next_state);
@@ -413,7 +424,6 @@ void omap_sram_idle(void)
 
 	/* PER */
 	per_next_state = omap3_pwrdm_read_next_pwrst(per_pwrdm);
-	core_next_state = omap3_pwrdm_read_next_pwrst(core_pwrdm);
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF)
@@ -427,8 +437,6 @@ void omap_sram_idle(void)
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
 		disable_smartreflex(SR1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		disable_smartreflex(SR2);
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
@@ -528,8 +536,12 @@ void omap_sram_idle(void)
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
 		enable_smartreflex(SR1);
-	if (core_next_state <= PWRDM_POWER_RET)
+	if (core_next_state <= PWRDM_POWER_RET) {
+		cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
+			0x0, PLL_MOD, CM_AUTOIDLE);
+		reprogram_vdd2_opp_dll_wa(min_opp, max_opp);
 		enable_smartreflex(SR2);
+	}
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -566,6 +578,7 @@ void omap_sram_idle(void)
 	}
 }
 
+
 int omap3_can_sleep(void)
 {
 	if (!sleep_while_idle)
@@ -1035,8 +1048,7 @@ static void __init prcm_setup_regs(void)
 	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
 			 MPU_MOD,
 			 CM_AUTOIDLE2);
-	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
-			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
+	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
 			 PLL_MOD,
 			 CM_AUTOIDLE);
 	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
@@ -1227,6 +1239,7 @@ void omap_push_sram_idle(void)
 static int __init omap3_pm_init(void)
 {
 	struct power_state *pwrst, *tmp;
+	unsigned long freq;
 	int ret;
 
 	if (!cpu_is_omap34xx())
@@ -1291,6 +1304,12 @@ static int __init omap3_pm_init(void)
 
 	}
 
+	/* Get lowest and highest L3 OPP for DLL lock WA */
+	freq = 0;
+	min_opp = opp_find_freq_ceil(OPP_L3, &freq);
+	freq = ULONG_MAX;
+	max_opp = opp_find_freq_floor(OPP_L3, &freq);
+
 	omap3_save_scratchpad_contents();
 err1:
 	return ret;
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index cff6c6e..18a04a3 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -28,6 +28,7 @@
 
 #include "smartreflex.h"
 #include "resource34xx.h"
+#include "clock34xx.h"
 #include "pm.h"
 #include "cm.h"
 #include "cm-regbits-34xx.h"
@@ -152,7 +153,7 @@ static struct device dummy_dsp_dev;
 static struct device vdd2_dev;
 static int vdd1_lock;
 static int vdd2_lock;
-static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
+static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk, *l3_clk;
 static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
@@ -212,7 +213,6 @@ static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_type,
  */
 void init_opp(struct shared_resource *resp)
 {
-	struct clk *l3_clk;
 	int ret;
 	u8 opp_id;
 	resp->no_of_users = 0;
@@ -559,3 +559,77 @@ int validate_freq(struct shared_resource *resp, u32 target_level)
 		return freq_to_opp(&x, OPP_DSP, target_level);
 	return 0;
 }
+
+#define SR_VDD2_OPP1 (ID_VDD(VDD2_OPP) | ID_OPP_NO(0x1))
+static int omap_voltage_scale(int opp, unsigned long target, unsigned long cur)
+{
+	int vsel_current, vsel_target;
+
+	vsel_current = omap_twl_uv_to_vsel(cur);
+	vsel_target = omap_twl_uv_to_vsel(target);
+
+	if (opp == VDD2_OPP)
+		return sr_voltagescale_vcbypass(SR_VDD2_OPP1, SR_VDD2_OPP1,
+						vsel_target, vsel_current);
+
+	return -1;
+}
+
+static struct omap_opp *c_vdd2_opp;
+
+int program_vdd2_opp_dll_wa(struct omap_opp *min_opp, struct omap_opp *max_opp)
+{
+	int ret = 0, div;
+	struct omap_opp *c_opp;
+	unsigned long vt = 0, vc = 0, min_freq;
+
+	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+	min_freq = opp_get_freq(min_opp);
+
+	if (opp_get_freq(c_opp) != min_freq) {
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = omap3_core_dpll_m2_set_rate(dpll3_clk, min_freq * div);
+	} else {
+		vc = opp_get_voltage(c_opp);
+		vt = opp_get_voltage(max_opp);
+	}
+
+	if (!cpu_is_omap3630()) {
+		vc = opp_get_voltage(c_opp);
+		vt = 1200000;
+	}
+
+	if (vt)
+		ret = omap_voltage_scale(VDD2_OPP, vt, vc);
+
+	return ret;
+}
+
+int reprogram_vdd2_opp_dll_wa(struct omap_opp *min_opp,
+				struct omap_opp *max_opp)
+{
+	int ret = 0, div;
+	unsigned long vt = 0, vc = 0;
+
+	if (opp_get_freq(c_vdd2_opp) != opp_get_freq(min_opp)) {
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = omap3_core_dpll_m2_set_rate(dpll3_clk,
+					opp_get_freq(max_opp) * div);
+	} else  {
+		vc = opp_get_voltage(max_opp);
+		vt  = opp_get_voltage(c_vdd2_opp);
+	}
+
+	if (!cpu_is_omap3630()) {
+		vc = 1200000;
+		vt = opp_get_voltage(c_vdd2_opp);
+	}
+
+	if (vt)
+		ret = omap_voltage_scale(VDD2_OPP, vt, vc);
+
+	return ret;
+}
+
-- 
1.6.2.4

