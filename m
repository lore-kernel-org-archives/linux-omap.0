From: shweta gulati <shweta.gulati@ti.com>
Subject: [PATCH V2] OMAP3: PM: Workaround for DPLL3 Lock issue
Date: Thu, 13 May 2010 15:42:15 +0530
Message-ID: <1273745535-27139-1-git-send-email-shweta.gulati@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57130 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758464Ab0EMKMU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 13 May 2010 06:12:20 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id o4DACHDB020560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Thu, 13 May 2010 05:12:20 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath Sripathy <vishwanath.bs@ti.com>, Shweta Gulati <shweta.gulati@ti.com>

From: Vishwanath Sripathy <vishwanath.bs@ti.com>

OMAP3430/3630 has a Silicon bug because of which SDRC is
released from IDLE even before Core DPLL has locked. This leads
to undefined behaviour of SDRC DLL. 

This patch has workaround for the same.

Description of WA for 3430:
Initialization:
	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3 
	is always locked.

Before CORE Voltage Domain (VDD2) Sleep Transition to RETENTION or OFF mode:
1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP2 Frequency 
	(by changing M2 Divider value). This is increasing the period duration of 
	one L3 clock cycle.
	o	In case of CORE is at OPP3 (166MHz@1.15V):
	"	Lower the frequency to 83MHz.

	o	In case of CORE is at OPP2 (83MHz@1.05V):
	"	Keep the frequency as it is (83MHz).

2.	Increase CORE Voltage to 1.2V. This is reducing the timing duration of the
	critical path signal which will now fit to one L3 clock cycle.

3.	Enable DPLL3 Automatic mode. This will ensure proper transition to 
	RETENTION or OFF mode.

After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
1.	Disable DPLL3 Automatic mode.
2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.

Description of WA for 3630:
Initialization:
	Disable DPLL3 automatic mode by default. Issue will not be faced as DPLL3 is always locked.

Before CORE Voltage Domain(VDD2) Sleep Transition to RETENTION or OFF mode:
1.	Reduce DPLL3 M2 Frequency to get L3 running at OPP50 Frequency 
	(by changing M2 Divider value) and set VDD2 Voltage for OPP100. 
	This is increasing the period duration of one L3 clock cycle and reducing
	the timing duration of the critical path signal which will now fit to one 
	L3 clock cycle.
	o	In case of CORE is at OPP100 (L3=200MHz, VDD2=1.1375V):
		"	Lower the frequency to 100MHz.
		"	Keep the voltage as it is (1.1375V).

	o	In case of CORE is at OPP50 (L3=100MHz, VDD2=0.93V):
		"	Keep the frequency as it is (100MHz).
		"	Increase the voltage to 1.1375V.

2.	Enable DPLL3 Automatic mode. This will ensure proper transition to 
	RETENTION or OFF mode.

After CORE Voltage Domain Wakeup Transition from RETENTION or OFF mode:
1.	Disable DPLL3 Automatic mode.
2.	Restore previous DPLL3 M2 Frequency and CORE Voltage values.

Also OSWR should not be attempted if DPLL3 has locked. This should be done as part of OSWR patch series.

Patch tested on 3430SDP and 3630 ZOOM3.

Signed-off-by: Vishwanath Sripathy <vishwanath.bs@ti.com> 
Signed-off-by: Shweta Gulati <shweta.gulati@ti.com> 
---


Index: linux-omap-pm/arch/arm/mach-omap2/pm.h
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm.h
+++ linux-omap-pm/arch/arm/mach-omap2/pm.h
@@ -60,6 +60,10 @@ struct prm_setup_vc {
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
+extern int program_vdd2_opp_3430(void);
+extern int reprogram_vdd2_opp_3430(int restore);
+extern int program_vdd2_opp_3630(void);
+extern int reprogram_vdd2_opp_3630(int restore);
 
 extern u32 wakeup_timer_seconds;
 extern struct omap_dm_timer *gptimer_wakeup;
Index: linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/pm34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/pm34xx.c
@@ -56,6 +56,7 @@
 #include "sdrc.h"
 #include "omap3-opp.h"
 
+
 #ifdef CONFIG_SUSPEND
 static suspend_state_t suspend_state = PM_SUSPEND_ON;
 static inline bool is_suspending(void)
@@ -363,6 +364,8 @@ void omap_sram_idle(void)
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
 	unsigned int start =0, end = 0;
+	u32 fclk_status = 0;
+	int restore = 1;
 	if (!_omap_sram_idle)
 		return;
 
@@ -415,15 +418,6 @@ void omap_sram_idle(void)
 	if (pwrdm_read_pwrst(cam_pwrdm) == PWRDM_POWER_ON)
 		omap2_clkdm_deny_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 
-	/*
-	 * Disable smartreflex before entering WFI.
-	 * Only needed if we are going to enter retention or off.
-	 */
-	if (mpu_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(VDD1, 1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(VDD2, 1);
-
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		omap_uart_prepare_idle(0);
@@ -447,6 +441,31 @@ void omap_sram_idle(void)
 		prm_set_mod_reg_bits(OMAP3430_EN_IO, WKUP_MOD, PM_WKEN);
 		omap3_enable_io_chain();
 	}
+	/*
+	 * Disable smartreflex before entering WFI.
+	 * Only needed if we are going to enter retention or off.
+	 */
+	if (mpu_next_state <= PWRDM_POWER_RET)
+		omap_smartreflex_disable(VDD1, 1);
+	if (core_next_state <= PWRDM_POWER_RET) {
+		fclk_status = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(CORE_MOD, CM_FCLKEN1) |
+			cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3) |
+			cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+		if (!fclk_status) {
+			omap_smartreflex_disable(VDD2, 1);
+			if (cpu_is_omap3630())
+				program_vdd2_opp_3630();
+			else if (cpu_is_omap3430())
+				program_vdd2_opp_3430();
+			cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
+					0x1, PLL_MOD, CM_AUTOIDLE);
+		}
+	}
+
 	omap3_intc_prepare_idle();
 
 	/*
@@ -488,6 +507,7 @@ void omap_sram_idle(void)
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
 		if (core_prev_state == PWRDM_POWER_OFF) {
+			restore = 0;
 			omap3_core_restore_context();
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
@@ -522,9 +542,18 @@ void omap_sram_idle(void)
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
 		omap_smartreflex_enable(VDD1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_enable(VDD2);
-
+	if (core_next_state <= PWRDM_POWER_RET) {
+		if (restore)
+			cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
+					0x0, PLL_MOD, CM_AUTOIDLE);
+		if (!fclk_status) {
+			if (cpu_is_omap3630())
+				reprogram_vdd2_opp_3630(restore);
+			else if (cpu_is_omap3430())
+				reprogram_vdd2_opp_3430(restore);
+			omap_smartreflex_enable(VDD2);
+		}
+	}
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		if (per_next_state == PWRDM_POWER_OFF) {
@@ -948,9 +977,8 @@ static void __init prcm_setup_regs(void)
 	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
 			 MPU_MOD,
 			 CM_AUTOIDLE2);
-	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
-			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
-			 PLL_MOD,
+	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
+			  PLL_MOD,
 			 CM_AUTOIDLE);
 	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
 			 PLL_MOD,
@@ -1124,7 +1152,6 @@ static int __init omap3_pm_init(void)
 	struct power_state *pwrst, *tmp;
 	struct clockdomain *neon_clkdm, *per_clkdm, *mpu_clkdm, *core_clkdm;
 	int ret;
-
 	if (!cpu_is_omap34xx())
 		return -ENODEV;
 
Index: linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/resource34xx.c
+++ linux-omap-pm/arch/arm/mach-omap2/resource34xx.c
@@ -38,6 +38,7 @@
 #warning MPU latency constraints require CONFIG_CPU_IDLE to function!
 #endif
 
+
 /**
  * init_latency - Initializes the mpu/core latency resource.
  * @resp: Latency resource to be initalized
@@ -147,6 +148,9 @@ int set_pd_latency(struct shared_resourc
 	return 0;
 }
 
+unsigned long freq = 0, min_freq;
+struct omap_opp *min_opp, *max_opp;
+
 static struct shared_resource *vdd1_resp;
 static struct shared_resource *vdd2_resp;
 static struct device dummy_mpu_dev;
@@ -154,7 +158,7 @@ static struct device dummy_dsp_dev;
 static struct device vdd2_dev;
 static int vdd1_lock;
 static int vdd2_lock;
-static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
+static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk, *l3_clk;
 static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
@@ -214,7 +218,6 @@ static int __deprecated freq_to_opp(u8 *
  */
 void init_opp(struct shared_resource *resp)
 {
-	struct clk *l3_clk;
 	int ret;
 	u8 opp_id;
 	resp->no_of_users = 0;
@@ -238,6 +241,15 @@ void init_opp(struct shared_resource *re
 		curr_vdd2_opp = opp_id;
 	}
 	resp->curr_level = opp_id;
+	if (cpu_is_omap3630()) {
+		min_opp = opp_find_freq_ceil(OPP_L3, &freq);
+		min_freq = opp_get_freq(min_opp);
+		freq = ULONG_MAX;
+		max_opp = opp_find_freq_floor(OPP_L3, &freq);
+	} else if (cpu_is_omap3430()) {
+		min_opp = opp_find_freq_ceil(OPP_L3, &freq);
+		min_freq = opp_get_freq(min_opp);
+	}
 	return;
 }
 
@@ -553,3 +565,97 @@ int validate_freq(struct shared_resource
 		return freq_to_opp(&x, OPP_DSP, target_level);
 	return 0;
 }
+
+static struct omap_opp *c_vdd2_opp;
+int program_vdd2_opp_3430()
+{
+	int ret = 0, div;
+	struct omap_opp *c_opp;
+	unsigned long vc, vt;
+
+
+	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+
+	if (opp_get_freq(c_opp) != min_freq) {
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = clk_set_rate(dpll3_clk, min_freq * div);
+	}
+	/* for omap3430, VDD2 should be at 1.2V */
+	vt = 1200000;
+	vc = opp_get_voltage(c_opp);
+	ret = omap_voltage_scale(VDD2, vt, vc);
+	return ret;
+}
+
+int reprogram_vdd2_opp_3430(int restore)
+{
+	int ret = 0, div;
+	unsigned long freq = 0;
+	struct omap_opp *c_opp;
+	unsigned long  vc, vt;
+	c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+	if (restore) {
+		if (opp_get_freq(c_opp) != opp_get_freq(c_vdd2_opp)) {
+			freq = opp_get_freq(c_vdd2_opp);
+			div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+				OMAP3430_CLKSEL_L3_MASK;
+			ret = clk_set_rate(dpll3_clk, freq * div);
+		}
+	}
+	vc = 1200000;
+	vt = opp_get_voltage(c_vdd2_opp);
+	ret = omap_voltage_scale(VDD2, vt, vc);
+	return ret;
+
+}
+
+
+int program_vdd2_opp_3630()
+{
+	int ret = 0, div;
+	struct omap_opp *c_opp;
+	unsigned long vc, vt;
+
+	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+
+	if (opp_get_freq(c_opp) == min_freq) {
+		vc = opp_get_voltage(c_opp);
+		vt = opp_get_voltage(max_opp);
+		ret = omap_voltage_scale(VDD2, vt, vc);
+	} else {
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = clk_set_rate(dpll3_clk, min_freq * div);
+	}
+
+	return ret;
+}
+
+int reprogram_vdd2_opp_3630(int restore)
+{
+	int ret = 0, div;
+	unsigned long freq = 0;
+	struct omap_opp *c_opp;
+	unsigned long  vc, vt;
+
+	c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+
+	if (opp_get_freq(c_opp) == opp_get_freq(c_vdd2_opp)) {
+			vc = opp_get_voltage(max_opp);
+			vt = opp_get_voltage(c_vdd2_opp);
+			/* ok to scale.. */
+			ret = omap_voltage_scale(VDD2, vt, vc);
+	} else {
+		if (restore) {
+			freq = opp_get_freq(max_opp);
+			div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+				OMAP3430_CLKSEL_L3_MASK;
+			ret = clk_set_rate(dpll3_clk, freq * div);
+		}
+	}
+
+	return ret;
+}
+
+
Index: linux-omap-pm/arch/arm/mach-omap2/voltage.c
===================================================================
--- linux-omap-pm.orig/arch/arm/mach-omap2/voltage.c
+++ linux-omap-pm/arch/arm/mach-omap2/voltage.c
@@ -479,7 +479,6 @@ static int vc_bypass_scale_voltage(u32 v
 			pr_warning("Unable to get voltage table for VDD%d \
 				during voltage scaling. Some really Wrong!",
 				vdd + 1);
-			return false;
 		}
 		vp_reg[vdd].vp_errorgain = volt_data.vp_errorgain <<
 			OMAP3430_ERRORGAIN_SHIFT;
@@ -584,7 +583,6 @@ static int vp_forceupdate_scale_voltage(
 			pr_warning("Unable to get voltage table for VDD%d \
 				during voltage scaling. Some really Wrong!",
 				vdd + 1);
-			return false;
 		}
 		vp_reg[vdd].vp_errorgain = (volt_data.vp_errorgain <<
 				OMAP3430_ERRORGAIN_SHIFT);
