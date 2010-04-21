From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: FYI: DLL workaround patch for 3630
Date: Wed, 21 Apr 2010 17:12:27 +0300
Message-ID: <20100421141227.GB4895@codecarver.research.nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="KFztAG8eRSV9hGtP"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:58793 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753327Ab0DUOMa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 21 Apr 2010 10:12:30 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx09.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o3LEAZAF001504
	for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 09:12:29 -0500
Received: from codecarver.research.nokia.com (esdhcp040155.research.nokia.com [172.21.40.155])
	by mgw-sa02.ext.nokia.com (Switch-3.3.3/Switch-3.3.3) with ESMTP id o3LECO5I012295
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Wed, 21 Apr 2010 17:12:24 +0300
Received: from p2 by codecarver.research.nokia.com with local (Exim 4.69)
	(envelope-from <p2@codecarver.research.nokia.com>)
	id 1O4afD-0001aL-K2
	for linux-omap@vger.kernel.org; Wed, 21 Apr 2010 17:12:27 +0300
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

As promised, in attachment my work around for the DLL lock issue for
3630. The patch also disables off mode for 3430 as the workaround for
this chip is slightly different. This patch is posted for informational
purposes only.

Thanks,

Peter.
-- 
goa is a state of mind

--KFztAG8eRSV9hGtP
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-OMAP3-PM-workaround-for-3630-dll-locking-issue.patch"

>From 3749c16b10892e6cdfd7370f4c483ecac734f577 Mon Sep 17 00:00:00 2001
From: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Date: Thu, 25 Mar 2010 15:04:15 +0200
Subject: [PATCH] OMAP3 PM workaround for 3630 dll locking issue


Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
---
 arch/arm/mach-omap2/cpuidle34xx.c             |   10 +++-
 arch/arm/mach-omap2/pm34xx.c                  |   78 +++++++++++++++++++++++-
 2 files changed, 137 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
index 1cb64c1..30599ae 100644
--- a/arch/arm/mach-omap2/cpuidle34xx.c
+++ b/arch/arm/mach-omap2/cpuidle34xx.c
@@ -223,13 +223,17 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
 		else
 			per_state = saved_per_state;
 
+
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
@@ -472,6 +476,10 @@ int __init omap3_idle_init(void)
 	omap_init_power_states();
 	cpuidle_register_driver(&omap3_idle_driver);
 
+	/* Disable off mode on 3430 */
+	if (!cpu_is_omap3630())
+		omap3_power_states[OMAP3_STATE_C7].valid = 0;
+
 	dev = &per_cpu(omap3_idle_dev, smp_processor_id());
 
 	for (i = OMAP3_STATE_C1; i < OMAP3_MAX_STATES; i++) {
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index d75eb54..6b62f10 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -42,6 +42,7 @@
 #include <plat/usb.h>
 
 #include <plat/resource.h>
+#include <plat/opp_twl_tps.h>
 
 #include <asm/tlbflush.h>
 
@@ -54,6 +55,8 @@
 #include "pm.h"
 #include "sdrc.h"
 #include "omap3-opp.h"
+#include "smartreflex.h"
+#include "clock34xx.h"
 
 static int regset_save_on_suspend;
 
@@ -92,6 +95,9 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static int secure_ram_save_status;
 static int secure_ram_saved;
+static struct clk *dpll3_clk;
+static struct omap_opp *vdd2_opp50, *vdd2_opp100;
+static u8 vdd2_opp50_vsel, vdd2_opp100_vsel;
 
 static struct prm_setup_vc prm_setup = {
 	.clksetup = 0xff,
@@ -370,6 +376,7 @@ void omap_sram_idle(void)
 	int core_next_state = PWRDM_POWER_ON;
 	int core_prev_state, per_prev_state;
 	u32 sdrc_pwr = 0;
+	int prev_dpll3_div = 0;
 
 	if (!_omap_sram_idle)
 		return;
@@ -405,9 +412,10 @@ void omap_sram_idle(void)
 			omap3_save_neon_context();
 	}
 
-	/* PER */
 	per_next_state = omap3_pwrdm_read_next_pwrst(per_pwrdm);
 	core_next_state = omap3_pwrdm_read_next_pwrst(core_pwrdm);
+
+	/* PER */
 	if (per_next_state < PWRDM_POWER_ON) {
 		omap2_gpio_prepare_for_idle(per_next_state);
 		if (per_next_state == PWRDM_POWER_OFF)
@@ -462,6 +470,27 @@ void omap_sram_idle(void)
 	if (regset_save_on_suspend)
 		pm_dbg_regset_save(1);
 
+	if (core_next_state < PWRDM_POWER_INACTIVE && cpu_is_omap3630()) {
+		u32 clksel1_pll, v;
+
+		clksel1_pll = cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKSEL1_PLL);
+		prev_dpll3_div = clksel1_pll >> 28;
+
+		if (prev_dpll3_div == 1)
+			omap3_core_dpll_m2_set_rate(dpll3_clk,
+					opp_get_freq(vdd2_opp50) * 2);
+		else
+			sr_voltagescale_vcbypass(ID_VDD(2), ID_VDD(2),
+					vdd2_opp100_vsel, vdd2_opp50_vsel);
+
+		 /* enable DPLL3 autoidle */
+		 v = cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+		 v |= 1;
+		 cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
+	}
+
+	memcpy(save_sdrc_counters, _sdrc_counters, sizeof(save_sdrc_counters));
+
 	/*
 	 * omap3_arm_context is the location where ARM registers
 	 * get saved. The restore path then reads from this
@@ -483,6 +512,42 @@ void omap_sram_idle(void)
 	if (pwrdm_read_prev_pwrst(mpu_pwrdm) == PWRDM_POWER_OFF)
 		restore_table_entry();
 
+	if (core_next_state < PWRDM_POWER_INACTIVE && cpu_is_omap3630()) {
+		if (pwrdm_read_prev_pwrst(core_pwrdm) == PWRDM_POWER_OFF) {
+			u32 clksel1_pll;
+
+			/* ROM code restored the scratchpad settings. So DPLL3
+			 * autoidle is disabled and L3 clock is back to the
+			 * value before entering this function. This means we
+			 * only have to lower the voltage if L3 runs at OPP50
+			 */
+
+			clksel1_pll = cm_read_mod_reg(PLL_MOD,
+						OMAP3430_CM_CLKSEL1_PLL);
+			if ((clksel1_pll >> 28) == 2) {
+				/* restore VDD2 OPP2 voltage */
+				sr_voltagescale_vcbypass(ID_VDD(2), ID_VDD(2),
+						vdd2_opp50_vsel,
+						vdd2_opp100_vsel);
+			}
+		} else {
+			u32 v;
+
+			/* disable DPLL3 autoidle */
+			v = cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
+			v &= ~0x7;
+			cm_write_mod_reg(v, PLL_MOD, CM_AUTOIDLE);
+
+			if (prev_dpll3_div == 1)
+				omap3_core_dpll_m2_set_rate(dpll3_clk,
+						opp_get_freq(vdd2_opp100) * 2);
+			else
+				sr_voltagescale_vcbypass(ID_VDD(2), ID_VDD(2),
+						vdd2_opp50_vsel,
+						vdd2_opp100_vsel);
+		}
+	}
+
 	/* CORE */
 	if (core_next_state < PWRDM_POWER_ON) {
 		core_prev_state = pwrdm_read_prev_pwrst(core_pwrdm);
@@ -512,7 +577,6 @@ void omap_sram_idle(void)
 	}
 	omap3_intc_resume_idle();
 
-	memcpy(save_sdrc_counters, _sdrc_counters, sizeof(save_sdrc_counters));
 
 	/*
 	 * Enable smartreflex after WFI. Only needed if we entered
@@ -1012,8 +1076,7 @@ static void __init prcm_setup_regs(void)
 	cm_write_mod_reg(1 << OMAP3430_AUTO_MPU_DPLL_SHIFT,
 			 MPU_MOD,
 			 CM_AUTOIDLE2);
-	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT) |
-			 (1 << OMAP3430_AUTO_CORE_DPLL_SHIFT),
+	cm_write_mod_reg((1 << OMAP3430_AUTO_PERIPH_DPLL_SHIFT),
 			 PLL_MOD,
 			 CM_AUTOIDLE);
 	cm_write_mod_reg(1 << OMAP3430ES2_AUTO_PERIPH2_DPLL_SHIFT,
@@ -1242,6 +1305,13 @@ static int __init omap3_pm_init(void)
 	per_pwrdm = pwrdm_lookup("per_pwrdm");
 	core_pwrdm = pwrdm_lookup("core_pwrdm");
 
+	dpll3_clk = clk_get(NULL, "dpll3_m2_ck");
+
+	vdd2_opp50 = opp_find_by_opp_id(OPP_L3, 1);
+	vdd2_opp100 = opp_find_by_opp_id(OPP_L3, 2);
+	vdd2_opp50_vsel = omap_twl_uv_to_vsel(opp_get_voltage(vdd2_opp50));
+	vdd2_opp100_vsel = omap_twl_uv_to_vsel(opp_get_voltage(vdd2_opp100));
+
 	omap_push_sram_idle();
 #ifdef CONFIG_SUSPEND
 	suspend_set_ops(&omap_pm_ops);
-- 
1.6.2.4


--KFztAG8eRSV9hGtP--
