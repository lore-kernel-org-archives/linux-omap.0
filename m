From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH] OMAP3 PM: Workaround for DPLL3 Lock issue
Date: Fri,  9 Apr 2010 13:01:13 +0530
Message-ID: <1270798273-30070-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59193 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab0DIHce (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Apr 2010 03:32:34 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o397WVaC024099
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Fri, 9 Apr 2010 02:32:33 -0500
In-Reply-To: <>
References: <>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Vishwanath BS <vishwanath.bs@ti.com>

OMAP3430/3630 has a Silicon bug because of which SDRC is released from 
IDLE even before Core DPLL has locked. This leads to undefined behaviour 
of SDRC DLL. This patch has workaround for the same.

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
---

diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index 55bde0d..2751d4b 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -60,6 +60,10 @@ struct prm_setup_vc {
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
+extern int program_vdd2_opp_3430(void);
+extern int reprogram_vdd2_opp_3430(void);
+extern int program_vdd2_opp_3630(void);
+extern int reprogram_vdd2_opp_3630(void);
 
 extern u32 wakeup_timer_seconds;
 extern struct omap_dm_timer *gptimer_wakeup;
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
old mode 100644
new mode 100755
index 2f5c894..6a6ed02
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -360,6 +360,7 @@ void omap_sram_idle(void)
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
 	int per_state_modified = 0;
+	u32 fclk_status = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -416,8 +417,24 @@ void omap_sram_idle(void)
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
 		omap_smartreflex_disable(SR1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_disable(SR2);
+	if (core_next_state <= PWRDM_POWER_RET) {
+		fclk_status = cm_read_mod_reg(OMAP3430_PER_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(CORE_MOD, CM_FCLKEN1) |
+			cm_read_mod_reg(CORE_MOD, OMAP3430ES2_CM_FCLKEN3) |
+			cm_read_mod_reg(OMAP3430_DSS_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(OMAP3430_CAM_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(OMAP3430ES2_SGX_MOD, CM_FCLKEN) |
+			cm_read_mod_reg(OMAP3430ES2_USBHOST_MOD, CM_FCLKEN);
+		if (!fclk_status) {
+			omap_smartreflex_disable(SR2);
+			if (cpu_is_omap3630())
+				program_vdd2_opp_3630();
+			else if (cpu_is_omap3430())
+				program_vdd2_opp_3430();
+			cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
+						0x1, PLL_MOD, CM_AUTOIDLE);
+		}
+	}
 
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
@@ -517,8 +534,18 @@ void omap_sram_idle(void)
 	 */
 	if (mpu_next_state <= PWRDM_POWER_RET)
 		omap_smartreflex_enable(SR1);
-	if (core_next_state <= PWRDM_POWER_RET)
-		omap_smartreflex_enable(SR2);
+
+	if (core_next_state <= PWRDM_POWER_RET) {
+		cm_rmw_mod_reg_bits(OMAP3430_AUTO_CORE_DPLL_MASK,
+					0x0, PLL_MOD, CM_AUTOIDLE);
+		if (!fclk_status) {
+			if (cpu_is_omap3630())
+				reprogram_vdd2_opp_3630();
+			else if (cpu_is_omap3430())
+				reprogram_vdd2_opp_3430();
+			omap_smartreflex_enable(SR2);
+		}
+	}
 
 	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
@@ -553,6 +580,7 @@ void omap_sram_idle(void)
 	omap2_clkdm_allow_idle(mpu_pwrdm->pwrdm_clkdms[0]);
 }
 
+
 int omap3_can_sleep(void)
 {
 	if (!sleep_while_idle)
@@ -938,8 +966,7 @@ static void __init prcm_setup_regs(void)
 	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
 			 MPU_MOD,
 			 CM_AUTOIDLE2);
-	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
-			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
+	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
 			 PLL_MOD,
 			 CM_AUTOIDLE);
 	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index fc1b775..a52ae05 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -154,7 +154,7 @@ static struct device dummy_dsp_dev;
 static struct device vdd2_dev;
 static int vdd1_lock;
 static int vdd2_lock;
-static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk;
+static struct clk *dpll1_clk, *dpll2_clk, *dpll3_clk, *l3_clk;
 static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
@@ -214,7 +214,6 @@ static int __deprecated freq_to_opp(u8 *opp_id, enum opp_t opp_type,
  */
 void init_opp(struct shared_resource *resp)
 {
-	struct clk *l3_clk;
 	int ret;
 	u8 opp_id;
 	resp->no_of_users = 0;
@@ -553,3 +552,118 @@ int validate_freq(struct shared_resource *resp, u32 target_level)
 		return freq_to_opp(&x, OPP_DSP, target_level);
 	return 0;
 }
+
+static struct omap_opp *c_vdd2_opp;
+int program_vdd2_opp_3430()
+{
+	int ret = 0, div;
+	unsigned long freq = 0;
+	struct omap_opp *c_opp, *min_opp;
+	unsigned long vc, vt;
+
+	min_opp = opp_find_freq_ceil(OPP_L3, &freq);
+	freq = ULONG_MAX;
+	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+
+	if (opp_get_freq(c_opp) != opp_get_freq(min_opp)) {
+		freq = opp_get_freq(min_opp);
+		lock_scratchpad_sem();
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = clk_set_rate(dpll3_clk, freq * div);
+#ifdef CONFIG_PM
+		omap3_save_scratchpad_contents();
+#endif
+		unlock_scratchpad_sem();
+	}
+
+	/* for omap3430, VDD2 should be at 1.2V */
+	vt = 1200000;
+	vc = opp_get_voltage(c_opp);
+	ret = omap_voltage_scale(VDD2_OPP, vt, vc);
+	return ret;
+}
+
+int reprogram_vdd2_opp_3430()
+{
+	int ret = 0, div;
+	unsigned long freq = 0;
+	struct omap_opp *c_opp;
+	u8 vc, vt;
+	unsigned long uvdc;
+
+	c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+	if (opp_get_freq(c_opp) != opp_get_freq(c_vdd2_opp)) {
+		freq = opp_get_freq(c_vdd2_opp);
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = clk_set_rate(dpll3_clk, freq * div);
+	}
+	vc = omap_twl_uv_to_vsel(1200000);
+	uvdc = opp_get_voltage(c_vdd2_opp);
+	vt = omap_twl_uv_to_vsel(uvdc);
+	ret = omap_voltage_scale(VDD2_OPP, vt, vc);
+	return ret;
+}
+
+
+int program_vdd2_opp_3630()
+{
+	int ret = 0, div;
+	unsigned long freq = 0;
+	struct omap_opp *c_opp, *min_opp, *max_opp;
+	unsigned long vc, vt;
+
+	min_opp = opp_find_freq_ceil(OPP_L3, &freq);
+	freq = ULONG_MAX;
+	max_opp = opp_find_freq_floor(OPP_L3, &freq);
+	c_vdd2_opp = c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+
+	if (opp_get_freq(c_opp) == opp_get_freq(min_opp)) {
+		vc = opp_get_voltage(c_opp);
+		vt = opp_get_voltage(max_opp);
+		ret = omap_voltage_scale(VDD2_OPP, vt, vc);
+	} else {
+		freq = opp_get_freq(min_opp);
+		lock_scratchpad_sem();
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = clk_set_rate(dpll3_clk, freq * div);
+#ifdef CONFIG_PM
+		omap3_save_scratchpad_contents();
+#endif
+		unlock_scratchpad_sem();
+	}
+
+	return ret;
+}
+
+int reprogram_vdd2_opp_3630()
+{
+	int ret = 0, div;
+	unsigned long freq = 0;
+	struct omap_opp *c_opp, *min_opp, *max_opp;
+	u8 vc, vt;
+
+	min_opp = opp_find_freq_ceil(OPP_L3, &freq);
+	freq = ULONG_MAX;
+	max_opp = opp_find_freq_floor(OPP_L3, &freq);
+	c_opp = opp_find_freq_exact(OPP_L3, l3_clk->rate, true);
+
+	if (opp_get_freq(c_opp) == opp_get_freq(c_vdd2_opp)) {
+			vc = opp_get_voltage(max_opp);
+			vt  = opp_get_voltage(c_vdd2_opp);
+
+			/* ok to scale.. */
+			ret = omap_voltage_scale(VDD2_OPP, vt, vc);
+	} else {
+		freq = opp_get_freq(max_opp);
+		div = cm_read_mod_reg(CORE_MOD, CM_CLKSEL) &
+			OMAP3430_CLKSEL_L3_MASK;
+		ret = clk_set_rate(dpll3_clk, freq * div);
+	}
+
+	return ret;
+}
+
+
