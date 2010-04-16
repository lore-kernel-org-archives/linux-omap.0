From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv3 09/22] OMAP3: PM: Creating separate files for handling OMAP3 voltage related operations.
Date: Fri, 16 Apr 2010 14:33:04 +0530
Message-ID: <1271408597-3066-10-git-send-email-thara@ti.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
 <1271408597-3066-2-git-send-email-thara@ti.com>
 <1271408597-3066-3-git-send-email-thara@ti.com>
 <1271408597-3066-4-git-send-email-thara@ti.com>
 <1271408597-3066-5-git-send-email-thara@ti.com>
 <1271408597-3066-6-git-send-email-thara@ti.com>
 <1271408597-3066-7-git-send-email-thara@ti.com>
 <1271408597-3066-8-git-send-email-thara@ti.com>
 <1271408597-3066-9-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:51449 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757000Ab0DPJDb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Apr 2010 05:03:31 -0400
In-Reply-To: <1271408597-3066-9-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch creates voltage.c and voltage.h files and
moves all voltage processor and voltage controller specific code
from smartreflex.c and other places in the OMAP3 codebase into
these two files.
This along with smartreflex class driver addition will make
smartreflex.c a generic driver to support both Class 2 and
Class 3 smartreflex implementaions.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/Makefile             |    3 +-
 arch/arm/mach-omap2/board-3430sdp.c      |    3 +-
 arch/arm/mach-omap2/pm.h                 |    7 -
 arch/arm/mach-omap2/pm34xx.c             |   87 +----
 arch/arm/mach-omap2/smartreflex-class3.c |    4 +
 arch/arm/mach-omap2/smartreflex.c        |  378 +------------------
 arch/arm/mach-omap2/smartreflex.h        |  137 -------
 arch/arm/mach-omap2/voltage.c            |  626 ++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h            |   74 ++++
 9 files changed, 712 insertions(+), 607 deletions(-)
 create mode 100644 arch/arm/mach-omap2/voltage.c
 create mode 100644 arch/arm/mach-omap2/voltage.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 0f8c406..184badd 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -46,7 +46,8 @@ obj-$(CONFIG_ARCH_OMAP2)		+= sdrc2xxx.o
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_ARCH_OMAP2)		+= pm24xx.o
 obj-$(CONFIG_ARCH_OMAP2)		+= sleep24xx.o
-obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o
+obj-$(CONFIG_ARCH_OMAP3)		+= pm34xx.o sleep34xx.o cpuidle34xx.o \
+					   voltage.o
 obj-$(CONFIG_PM_DEBUG)			+= pm-debug.o
 obj-$(CONFIG_OMAP_SMARTREFLEX)		+= sr_device.o smartreflex.o
 obj-$(CONFIG_OMAP_SMARTREFLEX_CLASS3)	+= smartreflex-class3.o
diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 6221a45..e80f8d4 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -49,6 +49,7 @@
 #include "sdram-qimonda-hyb18m512160af-6.h"
 #include "hsmmc.h"
 #include "pm.h"
+#include "voltage.h"
 #include "omap3-opp.h"
 #include "smartreflex-class3.h"
 
@@ -347,7 +348,7 @@ static void __init omap_3430sdp_init_irq(void)
 	omap_board_config_size = ARRAY_SIZE(sdp3430_config);
 	omap3_pm_init_opp_table();
 	omap3_pm_init_cpuidle(omap3_cpuidle_params_table);
-	omap3_pm_init_vc(&omap3_setuptime_table);
+	omap_voltage_init_vc(&omap3_setuptime_table);
 	omap2_init_common_hw(hyb18m512160af6_sdrc_params, NULL);
 	omap_init_irq();
 	omap_gpio_init();
diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
index b761be5..55bde0d 100644
--- a/arch/arm/mach-omap2/pm.h
+++ b/arch/arm/mach-omap2/pm.h
@@ -57,13 +57,6 @@ struct prm_setup_vc {
 	u16 vdd1_ret;
 	u16 vdd1_off;
 };
-#ifdef CONFIG_PM
-extern void omap3_pm_init_vc(struct prm_setup_vc *setup_vc);
-#else
-static inline void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
-{
-}
-#endif
 
 extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
 extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 9777ab2..2f5c894 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -49,6 +49,7 @@
 #include "prm-regbits-34xx.h"
 
 #include "smartreflex.h"
+#include "voltage.h"
 #include "prm.h"
 #include "pm.h"
 #include "sdrc.h"
@@ -96,22 +97,6 @@ static struct powerdomain *mpu_pwrdm, *neon_pwrdm;
 static struct powerdomain *core_pwrdm, *per_pwrdm;
 static struct powerdomain *cam_pwrdm;
 
-static struct prm_setup_vc prm_setup = {
-	.clksetup = 0xff,
-	.voltsetup_time1 = 0xfff,
-	.voltsetup_time2 = 0xfff,
-	.voltoffset = 0xff,
-	.voltsetup2 = 0xff,
-	.vdd0_on = 0x30,	/* 1.2v */
-	.vdd0_onlp = 0x20,	/* 1.0v */
-	.vdd0_ret = 0x1e,	/* 0.975v */
-	.vdd0_off = 0x00,	/* 0.6v */
-	.vdd1_on = 0x2c,	/* 1.15v */
-	.vdd1_onlp = 0x20,	/* 1.0v */
-	.vdd1_ret = 0x1e,	/* .975v */
-	.vdd1_off = 0x00,	/* 0.6v */
-};
-
 static inline void omap3_per_save_context(void)
 {
 	omap_gpio_save_context();
@@ -1077,26 +1062,6 @@ int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state)
 	return -EINVAL;
 }
 
-void omap3_pm_init_vc(struct prm_setup_vc *setup_vc)
-{
-	if (!setup_vc)
-		return;
-
-	prm_setup.clksetup = setup_vc->clksetup;
-	prm_setup.voltsetup_time1 = setup_vc->voltsetup_time1;
-	prm_setup.voltsetup_time2 = setup_vc->voltsetup_time2;
-	prm_setup.voltoffset = setup_vc->voltoffset;
-	prm_setup.voltsetup2 = setup_vc->voltsetup2;
-	prm_setup.vdd0_on = setup_vc->vdd0_on;
-	prm_setup.vdd0_onlp = setup_vc->vdd0_onlp;
-	prm_setup.vdd0_ret = setup_vc->vdd0_ret;
-	prm_setup.vdd0_off = setup_vc->vdd0_off;
-	prm_setup.vdd1_on = setup_vc->vdd1_on;
-	prm_setup.vdd1_onlp = setup_vc->vdd1_onlp;
-	prm_setup.vdd1_ret = setup_vc->vdd1_ret;
-	prm_setup.vdd1_off = setup_vc->vdd1_off;
-}
-
 static int __init pwrdms_setup(struct powerdomain *pwrdm, void *unused)
 {
 	struct power_state *pwrst;
@@ -1242,58 +1207,12 @@ err2:
 	return ret;
 }
 
-static void __init configure_vc(void)
-{
-
-	prm_write_mod_reg((R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA1_SHIFT) |
-			  (R_SRI2C_SLAVE_ADDR << OMAP3430_SMPS_SA0_SHIFT),
-			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_SA_OFFSET);
-	prm_write_mod_reg((R_VDD2_SR_CONTROL << OMAP3430_VOLRA1_SHIFT) |
-			  (R_VDD1_SR_CONTROL << OMAP3430_VOLRA0_SHIFT),
-			  OMAP3430_GR_MOD, OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET);
-
-	prm_write_mod_reg((prm_setup.vdd0_on << OMAP3430_VC_CMD_ON_SHIFT) |
-		(prm_setup.vdd0_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(prm_setup.vdd0_ret << OMAP3430_VC_CMD_RET_SHIFT) |
-		(prm_setup.vdd0_off << OMAP3430_VC_CMD_OFF_SHIFT),
-		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
-
-	prm_write_mod_reg((prm_setup.vdd1_on << OMAP3430_VC_CMD_ON_SHIFT) |
-		(prm_setup.vdd1_onlp << OMAP3430_VC_CMD_ONLP_SHIFT) |
-		(prm_setup.vdd1_ret << OMAP3430_VC_CMD_RET_SHIFT) |
-		(prm_setup.vdd1_off << OMAP3430_VC_CMD_OFF_SHIFT),
-		OMAP3430_GR_MOD, OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_CMD1 | OMAP3430_RAV1, OMAP3430_GR_MOD,
-			  OMAP3_PRM_VC_CH_CONF_OFFSET);
-
-	prm_write_mod_reg(OMAP3430_MCODE_SHIFT | OMAP3430_HSEN,
-			  OMAP3430_GR_MOD,
-			  OMAP3_PRM_VC_I2C_CFG_OFFSET);
-
-	/* Write setup times */
-	prm_write_mod_reg(prm_setup.clksetup, OMAP3430_GR_MOD,
-			OMAP3_PRM_CLKSETUP_OFFSET);
-	prm_write_mod_reg((prm_setup.voltsetup_time2 <<
-			OMAP3430_SETUP_TIME2_SHIFT) |
-			(prm_setup.voltsetup_time1 <<
-			OMAP3430_SETUP_TIME1_SHIFT),
-			OMAP3430_GR_MOD, OMAP3_PRM_VOLTSETUP1_OFFSET);
-
-	prm_write_mod_reg(prm_setup.voltoffset, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTOFFSET_OFFSET);
-	prm_write_mod_reg(prm_setup.voltsetup2, OMAP3430_GR_MOD,
-			OMAP3_PRM_VOLTSETUP2_OFFSET);
-}
-
-
 static int __init omap3_pm_early_init(void)
 {
 	prm_clear_mod_reg_bits(OMAP3430_OFFMODE_POL, OMAP3430_GR_MOD,
 				OMAP3_PRM_POLCTRL_OFFSET);
-
-	configure_vc();
-
+	/* Initializes OMAP3 voltage modules */
+	omap_voltage_init();
 	return 0;
 }
 
diff --git a/arch/arm/mach-omap2/smartreflex-class3.c b/arch/arm/mach-omap2/smartreflex-class3.c
index 1ac39bf..1b098ff 100644
--- a/arch/arm/mach-omap2/smartreflex-class3.c
+++ b/arch/arm/mach-omap2/smartreflex-class3.c
@@ -11,6 +11,7 @@
 
 #include "smartreflex.h"
 #include "smartreflex-class3.h"
+#include "voltage.h"
 
 static int sr_class3_enable(int id)
 {
@@ -25,12 +26,15 @@ static int sr_class3_enable(int id)
 		return false;
 	}
 
+	omap_voltageprocessor_enable(id);
 	return sr_enable(id, volt);
 }
 
 static int sr_class3_disable(int id)
 {
+	omap_voltageprocessor_disable(id);
 	sr_disable(id);
+	omap_reset_voltage(id);
 
 	return true;
 }
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index e307c8c..a89f74f 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -17,11 +17,9 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/module.h>
-#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/clk.h>
 #include <linux/kobject.h>
@@ -30,18 +28,11 @@
 #include <linux/list.h>
 #include <linux/debugfs.h>
 
-#include <plat/omap34xx.h>
-#include <plat/clock.h>
-#include <plat/opp.h>
-#include <plat/opp_twl_tps.h>
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
 
-#include "prm.h"
 #include "smartreflex.h"
-#include "prm-regbits-34xx.h"
 
-#define MAX_TRIES 100
 #define SMARTREFLEX_NAME_LEN	16
 
 struct omap_sr {
@@ -119,42 +110,6 @@ static void sr_clk_disable(struct omap_sr *sr)
 	sr->is_sr_reset = 1;
 }
 
-static unsigned long get_curr_vdd1_voltage(void)
-{
-	struct omap_opp *opp;
-	unsigned long freq;
-	struct clk *dpll1_clk;
-
-	dpll1_clk = clk_get(NULL, "dpll1_ck");
-	if (IS_ERR(dpll1_clk))
-		return 0;
-
-	freq = dpll1_clk->rate;;
-	opp = opp_find_freq_exact(OPP_MPU, freq, 1);
-	if (IS_ERR(opp))
-		return 0;
-
-	return opp_get_voltage(opp);
-}
-
-static unsigned long get_curr_vdd2_voltage(void)
-{
-	struct omap_opp *opp;
-	unsigned long freq;
-	struct clk *l3_clk;
-
-	l3_clk = clk_get(NULL, "l3_ick");
-	if (IS_ERR(l3_clk))
-		return 0;
-
-	freq = l3_clk->rate;
-	opp = opp_find_freq_exact(OPP_L3, freq, 1);
-	if (IS_ERR(opp))
-		return 0;
-
-	return opp_get_voltage(opp);
-}
-
 static int sr_match_volt(struct omap_sr *sr, unsigned long volt,
 				struct omap_volt_data *volt_data)
 {
@@ -210,104 +165,6 @@ static void sr_set_clk_length(struct omap_sr *sr)
 	}
 }
 
-static void sr_configure_vp(int srid)
-{
-	u32 vpconfig, vsel;
-	unsigned long uvdc;
-
-	if (srid == SR1) {
-		uvdc = get_curr_vdd1_voltage();
-		if (!uvdc)
-			pr_err("Something wrong.Current voltage not obtained \
-				from OPP framework for SR %d!\n", srid);
-		vsel = omap_twl_uv_to_vsel(uvdc);
-
-		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
-			PRM_VP1_CONFIG_ERRORGAIN |
-			PRM_VP1_CONFIG_TIMEOUTEN |
-			vsel << OMAP3430_INITVOLTAGE_SHIFT;
-
-		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_CONFIG_OFFSET);
-		prm_write_mod_reg(PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN |
-					PRM_VP1_VSTEPMIN_VSTEPMIN,
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_VSTEPMIN_OFFSET);
-
-		prm_write_mod_reg(PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX |
-					PRM_VP1_VSTEPMAX_VSTEPMAX,
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_VSTEPMAX_OFFSET);
-
-		prm_write_mod_reg(PRM_VP1_VLIMITTO_VDDMAX |
-					PRM_VP1_VLIMITTO_VDDMIN |
-					PRM_VP1_VLIMITTO_TIMEOUT,
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_VLIMITTO_OFFSET);
-
-		/* Trigger initVDD value copy to voltage processor */
-		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP1_CONFIG_OFFSET);
-
-		/* Clear initVDD copy trigger bit */
-		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-				       OMAP3_PRM_VP1_CONFIG_OFFSET);
-
-		/* Force update of voltage */
-		prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP1_CONFIG_OFFSET);
-		/* Clear force bit */
-		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
-				       OMAP3_PRM_VP1_CONFIG_OFFSET);
-
-	} else if (srid == SR2) {
-		uvdc = get_curr_vdd2_voltage();
-		if (!uvdc)
-			pr_err("Something wrong.Current voltage not obtained \
-				from OPP framework for SR %d!\n", srid);
-		vsel = omap_twl_uv_to_vsel(uvdc);
-
-		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
-			PRM_VP2_CONFIG_ERRORGAIN |
-			PRM_VP2_CONFIG_TIMEOUTEN |
-			vsel << OMAP3430_INITVOLTAGE_SHIFT;
-
-		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_CONFIG_OFFSET);
-		prm_write_mod_reg(PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN |
-					PRM_VP2_VSTEPMIN_VSTEPMIN,
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_VSTEPMIN_OFFSET);
-
-		prm_write_mod_reg(PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX |
-					PRM_VP2_VSTEPMAX_VSTEPMAX,
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_VSTEPMAX_OFFSET);
-
-		prm_write_mod_reg(PRM_VP2_VLIMITTO_VDDMAX |
-					PRM_VP2_VLIMITTO_VDDMIN |
-					PRM_VP2_VLIMITTO_TIMEOUT,
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_VLIMITTO_OFFSET);
-
-		/* Trigger initVDD value copy to voltage processor */
-		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP2_CONFIG_OFFSET);
-
-		/* Clear initVDD copy trigger bit */
-		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-				       OMAP3_PRM_VP2_CONFIG_OFFSET);
-
-		/* Force update of voltage */
-		prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP2_CONFIG_OFFSET);
-		/* Clear force bit */
-		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
-				       OMAP3_PRM_VP2_CONFIG_OFFSET);
-
-	}
-}
-
 static void sr_configure(struct omap_sr *sr)
 {
 	u32 sr_config;
@@ -356,81 +213,6 @@ static void sr_configure(struct omap_sr *sr)
 	sr->is_sr_reset = 0;
 }
 
-static int sr_reset_voltage(int srid)
-{
-	unsigned long uvdc;
-	u32 vsel = 0;
-	u32 reg_addr = 0;
-	u32 loop_cnt = 0, retries_cnt = 0;
-	u32 vc_bypass_value;
-	u32 t2_smps_steps = 0;
-	u32 t2_smps_delay = 0;
-	u32 prm_vp1_voltage, prm_vp2_voltage;
-
-	if (srid == SR1) {
-		uvdc = get_curr_vdd1_voltage();
-		if (!uvdc) {
-			pr_err("Something wrong.Current voltage not obtained \
-				from OPP framework for SR %d!\n", srid);
-			return 1;
-		}
-		vsel = omap_twl_uv_to_vsel(uvdc);
-
-		reg_addr = R_VDD1_SR_CONTROL;
-		prm_vp1_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
-						OMAP3_PRM_VP1_VOLTAGE_OFFSET);
-		t2_smps_steps = abs(vsel - prm_vp1_voltage);
-	} else if (srid == SR2) {
-		uvdc = get_curr_vdd2_voltage();
-		if (!uvdc) {
-			pr_err("Something wrong.Current voltage not obtained \
-				from OPP framework for SR %d!\n", srid);
-			return 1;
-		}
-		vsel = omap_twl_uv_to_vsel(uvdc);
-
-		reg_addr = R_VDD2_SR_CONTROL;
-		prm_vp2_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
-						OMAP3_PRM_VP2_VOLTAGE_OFFSET);
-		t2_smps_steps = abs(vsel - prm_vp2_voltage);
-	}
-
-	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
-			(reg_addr << OMAP3430_REGADDR_SHIFT) |
-			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
-
-	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
-			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
-		loop_cnt++;
-		if (retries_cnt > 10) {
-			pr_info("Loop count exceeded in check SR I2C"
-								"write\n");
-			return 1;
-		}
-		if (loop_cnt > 50) {
-			retries_cnt++;
-			loop_cnt = 0;
-			udelay(10);
-		}
-		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-	}
-
-	/*
-	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
-	 *  2us added as buffer.
-	 */
-	t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
-	udelay(t2_smps_delay);
-
-	return 0;
-}
-
 static void sr_start_vddautocomp(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
@@ -478,8 +260,6 @@ static void  sr_stop_vddautocomp(int srid)
 		sr_class->disable(srid);
 		sr_clk_disable(sr);
 		sr->is_autocomp_active = 0;
-		/* Reset the volatage for current OPP */
-		sr_reset_voltage(srid);
 	}
 }
 
@@ -498,10 +278,9 @@ static void  sr_stop_vddautocomp(int srid)
  */
 int sr_enable(int srid, unsigned long volt)
 {
-	u32 nvalue_reciprocal, v;
+	u32 nvalue_reciprocal;
 	struct omap_volt_data volt_data;
 	struct omap_sr *sr = _sr_lookup(srid);
-	char vsel;
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
@@ -527,45 +306,6 @@ int sr_enable(int srid, unsigned long volt)
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
 
-	vsel = omap_twl_uv_to_vsel(volt);
-
-	if (sr->srid == SR1) {
-		/* set/latch init voltage */
-		v = prm_read_mod_reg(OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP1_CONFIG_OFFSET);
-		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
-
-		v |= vsel << OMAP3430_INITVOLTAGE_SHIFT;
-		prm_write_mod_reg(v, OMAP3430_GR_MOD,
-				  OMAP3_PRM_VP1_CONFIG_OFFSET);
-		/* write1 to latch */
-		prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP1_CONFIG_OFFSET);
-		/* write2 clear */
-		prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
-				       OMAP3_PRM_VP1_CONFIG_OFFSET);
-		/* Enable VP1 */
-		prm_set_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP1_CONFIG_OFFSET);
-	} else if (sr->srid == SR2) {
-		/* set/latch init voltage */
-		v = prm_read_mod_reg(OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP2_CONFIG_OFFSET);
-		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
-		v |= vsel << OMAP3430_INITVOLTAGE_SHIFT;
-		prm_write_mod_reg(v, OMAP3430_GR_MOD,
-				  OMAP3_PRM_VP2_CONFIG_OFFSET);
-		/* write1 to latch */
-		prm_set_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP2_CONFIG_OFFSET);
-		/* write2 clear */
-		prm_clear_mod_reg_bits(OMAP3430_INITVDD, OMAP3430_GR_MOD,
-				       OMAP3_PRM_VP2_CONFIG_OFFSET);
-		/* Enable VP2 */
-		prm_set_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
-				     OMAP3_PRM_VP2_CONFIG_OFFSET);
-	}
-
 	/* SRCONFIG - enable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
 	return true;
@@ -581,7 +321,6 @@ int sr_enable(int srid, unsigned long volt)
 void sr_disable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
-	u32 i = 0;
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
@@ -590,40 +329,9 @@ void sr_disable(int srid)
 	}
 
 	sr->is_sr_reset = 1;
-
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, ~SRCONFIG_SRENABLE);
 
-	if (sr->srid == SR1) {
-		/* Wait for VP idle before disabling VP */
-		while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_STATUS_OFFSET))
-					&& i++ < MAX_TRIES)
-			udelay(1);
-
-		if (i >= MAX_TRIES)
-			pr_warning("VP1 not idle, still going ahead with \
-							VP1 disable\n");
-
-		/* Disable VP1 */
-		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_VPENABLE, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_CONFIG_OFFSET);
-
-	} else if (sr->srid == SR2) {
-		/* Wait for VP idle before disabling VP */
-		while ((!prm_read_mod_reg(OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_STATUS_OFFSET))
-					&& i++ < MAX_TRIES)
-			udelay(1);
-
-		if (i >= MAX_TRIES)
-			pr_warning("VP2 not idle, still going ahead with \
-							 VP2 disable\n");
-
-		/* Disable VP2 */
-		prm_clear_mod_reg_bits(PRM_VP2_CONFIG_VPENABLE, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_CONFIG_OFFSET);
-	}
 }
 
 /**
@@ -691,8 +399,6 @@ void omap_smartreflex_disable(int srid)
 			sr_class->disable(srid);
 			/* Disable SR clk */
 			sr_clk_disable(sr);
-			/* Reset the volatage for current OPP */
-			sr_reset_voltage(srid);
 		}
 	}
 }
@@ -718,86 +424,6 @@ void omap_sr_register_class(struct omap_smartreflex_class_data *class_data)
 	sr_class = class_data;
 }
 
-/* Voltage Scaling using SR VCBYPASS */
-int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
-					u8 target_vsel, u8 current_vsel)
-{
-	int sr_status = 0;
-	u32 vdd, target_opp_no, current_opp_no;
-	u32 vc_bypass_value;
-	u32 reg_addr = 0;
-	u32 loop_cnt = 0, retries_cnt = 0;
-	u32 t2_smps_steps = 0;
-	u32 t2_smps_delay = 0;
-
-	vdd = get_vdd(target_opp);
-	target_opp_no = get_opp_no(target_opp);
-	current_opp_no = get_opp_no(current_opp);
-
-	if (vdd == VDD1_OPP) {
-		sr_status = sr_stop_vddautocomp(SR1);
-		t2_smps_steps = abs(target_vsel - current_vsel);
-
-		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
-				(target_vsel << OMAP3430_VC_CMD_ON_SHIFT),
-				OMAP3430_GR_MOD,
-				OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
-		reg_addr = R_VDD1_SR_CONTROL;
-
-	} else if (vdd == VDD2_OPP) {
-		sr_status = sr_stop_vddautocomp(SR2);
-		t2_smps_steps =  abs(target_vsel - current_vsel);
-
-		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
-				(target_vsel << OMAP3430_VC_CMD_ON_SHIFT),
-				OMAP3430_GR_MOD,
-				OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
-		reg_addr = R_VDD2_SR_CONTROL;
-	}
-
-	vc_bypass_value = (target_vsel << OMAP3430_DATA_SHIFT) |
-			(reg_addr << OMAP3430_REGADDR_SHIFT) |
-			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
-
-	prm_write_mod_reg(vc_bypass_value, OMAP3430_GR_MOD,
-			OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	vc_bypass_value = prm_set_mod_reg_bits(OMAP3430_VALID, OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-
-	while ((vc_bypass_value & OMAP3430_VALID) != 0x0) {
-		loop_cnt++;
-		if (retries_cnt > 10) {
-			pr_info("Loop count exceeded in check SR I2C"
-								"write\n");
-			return 1;
-		}
-		if (loop_cnt > 50) {
-			retries_cnt++;
-			loop_cnt = 0;
-			udelay(10);
-		}
-		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
-	}
-
-	/*
-	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
-	 *  2us added as buffer.
-	 */
-	t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
-	udelay(t2_smps_delay);
-
-	if (sr_status) {
-		if (vdd == VDD1_OPP)
-			sr_start_vddautocomp(SR1);
-		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomp(SR2);
-	}
-
-	return 0;
-}
-
 /* PM Debug Fs enteries to enable disable smartreflex.*/
 
 static int omap_sr_autocomp_show(void *data, u64 *val)
@@ -855,8 +481,6 @@ static int __devinit omap_smartreflex_probe(struct platform_device *pdev)
 	(void) debugfs_create_file(name, S_IRUGO | S_IWUGO, pm_dbg_main_dir,
 				(void *)sr_info, &pm_sr_fops);
 
-	/* Call the VPConfig */
-	sr_configure_vp(sr_info->srid);
 	list_add(&sr_info->node, &sr_list);
 	pr_info("SmartReflex driver initialized\n");
 
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 8863c3b..073f6d0 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -18,9 +18,7 @@
 
 extern struct dentry *pm_dbg_main_dir;
 
-#define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
 #define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
-#define PHY_TO_OFF_PM_INT(p)		(p - 0x2e)
 
 /* SMART REFLEX REG ADDRESS OFFSET */
 #define SRCONFIG	0x00
@@ -38,64 +36,12 @@ extern struct dentry *pm_dbg_main_dir;
 #define SR1		1
 #define SR2		2
 
-#define SR_FAIL		1
-#define SR_PASS		0
-
-#define SR_TRUE		1
-#define SR_FALSE	0
-
 #define GAIN_MAXLIMIT	16
 #define R_MAXLIMIT	256
 
 #define SR1_CLK_ENABLE	BIT(6)
 #define SR2_CLK_ENABLE	BIT(7)
 
-/* PRM_VP1_CONFIG */
-#define PRM_VP1_CONFIG_ERROROFFSET	(0x00 << 24)
-#define PRM_VP1_CONFIG_ERRORGAIN	(0x20 << 16)
-
-#define PRM_VP1_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
-#define PRM_VP1_CONFIG_TIMEOUTEN	BIT(3)
-#define PRM_VP1_CONFIG_INITVDD		BIT(2)
-#define PRM_VP1_CONFIG_FORCEUPDATE	BIT(1)
-#define PRM_VP1_CONFIG_VPENABLE		BIT(0)
-
-/* PRM_VP1_VSTEPMIN */
-#define PRM_VP1_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
-#define PRM_VP1_VSTEPMIN_VSTEPMIN		BIT(0)
-
-/* PRM_VP1_VSTEPMAX */
-#define PRM_VP1_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
-#define PRM_VP1_VSTEPMAX_VSTEPMAX		(0x04 << 0)
-
-/* PRM_VP1_VLIMITTO */
-#define PRM_VP1_VLIMITTO_VDDMAX		(0x3C << 24)
-#define PRM_VP1_VLIMITTO_VDDMIN		(0x0 << 16)
-#define PRM_VP1_VLIMITTO_TIMEOUT	(0xFFFF << 0)
-
-/* PRM_VP2_CONFIG */
-#define PRM_VP2_CONFIG_ERROROFFSET	(0x00 << 24)
-#define PRM_VP2_CONFIG_ERRORGAIN	(0x20 << 16)
-
-#define PRM_VP2_CONFIG_INITVOLTAGE	(0x30 << 8) /* 1.2 volt */
-#define PRM_VP2_CONFIG_TIMEOUTEN	BIT(3)
-#define PRM_VP2_CONFIG_INITVDD		BIT(2)
-#define PRM_VP2_CONFIG_FORCEUPDATE	BIT(1)
-#define PRM_VP2_CONFIG_VPENABLE		BIT(0)
-
-/* PRM_VP2_VSTEPMIN */
-#define PRM_VP2_VSTEPMIN_SMPSWAITTIMEMIN	(0x01F4 << 8)
-#define PRM_VP2_VSTEPMIN_VSTEPMIN		BIT(0)
-
-/* PRM_VP2_VSTEPMAX */
-#define PRM_VP2_VSTEPMAX_SMPSWAITTIMEMAX	(0x01F4 << 8)
-#define PRM_VP2_VSTEPMAX_VSTEPMAX		(0x04 << 0)
-
-/* PRM_VP2_VLIMITTO */
-#define PRM_VP2_VLIMITTO_VDDMAX		(0x2C << 24)
-#define PRM_VP2_VLIMITTO_VDDMIN		(0x0 << 16)
-#define PRM_VP2_VLIMITTO_TIMEOUT	(0xFFFF << 0)
-
 /* SRCONFIG */
 #define SR1_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
 #define SR2_SRCONFIG_ACCUMDATA		(0x1F4 << 22)
@@ -137,9 +83,6 @@ extern struct dentry *pm_dbg_main_dir;
 #define SR_ERRMAXLIMIT_MASK		(0xFF << 8)
 #define SR_ERRMINLIMIT_MASK		(0xFF << 0)
 
-#define SR_CLKACTIVITY_IOFF_FOFF	(0x00 << 20)
-#define SR_CLKACTIVITY_IOFF_FON		(0x02 << 20)
-
 #define ERRCONFIG_VPBOUNDINTEN		BIT(31)
 #define ERRCONFIG_VPBOUNDINTST		BIT(30)
 
@@ -151,90 +94,12 @@ extern struct dentry *pm_dbg_main_dir;
 #define SR2_ERRMAXLIMIT			(0x02 << 8)
 #define SR2_ERRMINLIMIT			(0xF9 << 0)
 
-/* T2 SMART REFLEX */
-#define R_SRI2C_SLAVE_ADDR		0x12
-#define R_VDD1_SR_CONTROL		0x00
-#define R_VDD2_SR_CONTROL		0x01
-#define T2_SMPS_UPDATE_DELAY		360	/* In uSec */
-
 /* Vmode control */
 #define R_DCDC_GLOBAL_CFG	PHY_TO_OFF_PM_RECIEVER(0x61)
 
-#define R_VDD1_VSEL		PHY_TO_OFF_PM_RECIEVER(0xb9)
-#define R_VDD1_VMODE_CFG	PHY_TO_OFF_PM_RECIEVER(0xba)
-#define R_VDD1_VFLOOR		PHY_TO_OFF_PM_RECIEVER(0xbb)
-#define R_VDD1_VROOF		PHY_TO_OFF_PM_RECIEVER(0xbc)
-#define R_VDD1_STEP		PHY_TO_OFF_PM_RECIEVER(0xbd)
-
-#define R_VDD2_VSEL		PHY_TO_OFF_PM_RECIEVER(0xc7)
-#define R_VDD2_VMODE_CFG	PHY_TO_OFF_PM_RECIEVER(0xc8)
-#define R_VDD2_VFLOOR		PHY_TO_OFF_PM_RECIEVER(0xc9)
-#define R_VDD2_VROOF		PHY_TO_OFF_PM_RECIEVER(0xca)
-#define R_VDD2_STEP		PHY_TO_OFF_PM_RECIEVER(0xcb)
-
 /* R_DCDC_GLOBAL_CFG register, SMARTREFLEX_ENABLE values */
 #define DCDC_GLOBAL_CFG_ENABLE_SRFLX	0x08
 
-#define PRCM_MAX_SYSC_REGS 30
-
-/*
- * XXX: These should be removed/moved from here once we have a working DVFS
- * implementation in place
- */
-#define AT_3430		1	/*3430 ES 1.0 */
-#define AT_3430_ES2	2	/*3430 ES 2.0 */
-
-#define ID_OPP			0xE2 	/*OPP*/
-
-/* DEVICE ID/DPLL ID/CLOCK ID: bits 28-31 for OMAP type */
-#define OMAP_TYPE_SHIFT		28
-#define OMAP_TYPE_MASK		0xF
-/* OPP ID: bits: 0-4 for OPP number */
-#define OPP_NO_POS		0
-#define OPP_NO_MASK		0x1F
-/* OPP ID: bits: 5-6 for VDD */
-#define VDD_NO_POS		5
-#define VDD_NO_MASK		0x3
-/* Other IDs: bits 20-27 for ID type */
-/* These IDs have bits 25,26,27 as 1 */
-#define OTHER_ID_TYPE_SHIFT		20
-#define OTHER_ID_TYPE_MASK		0xFF
-
-#define OTHER_ID_TYPE(X) ((X & OTHER_ID_TYPE_MASK) << OTHER_ID_TYPE_SHIFT)
-#define ID_OPP_NO(X)	 ((X & OPP_NO_MASK) << OPP_NO_POS)
-#define ID_VDD(X)	 ((X & VDD_NO_MASK) << VDD_NO_POS)
-#define OMAP(X)		 ((X >> OMAP_TYPE_SHIFT) & OMAP_TYPE_MASK)
-#define get_opp_no(X)	 ((X >> OPP_NO_POS) & OPP_NO_MASK)
-#define get_vdd(X)	 ((X >> VDD_NO_POS) & VDD_NO_MASK)
-
-/* VDD1 OPPs */
-#define PRCM_VDD1_OPP1		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x1))
-#define PRCM_VDD1_OPP2		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x2))
-#define PRCM_VDD1_OPP3		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x3))
-#define PRCM_VDD1_OPP4		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x4))
-#define PRCM_VDD1_OPP5		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD1) | ID_OPP_NO(0x5))
-#define PRCM_NO_VDD1_OPPS	5
-
-
-/* VDD2 OPPs */
-#define PRCM_VDD2_OPP1		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x1))
-#define PRCM_VDD2_OPP2		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x2))
-#define PRCM_VDD2_OPP3		(OMAP(AT_3430_ES2) | OTHER_ID_TYPE(ID_OPP) | \
-					ID_VDD(PRCM_VDD2) | ID_OPP_NO(0x3))
-#define PRCM_NO_VDD2_OPPS	3
-/* XXX: end remove/move */
-
-/* XXX: find more appropriate place for these once DVFS is in place */
-extern u32 current_vdd1_opp;
-extern u32 current_vdd2_opp;
-
 #ifdef CONFIG_OMAP_SMARTREFLEX_TESTING
 #define SR_TESTING_NVALUES 	1
 #else
@@ -348,8 +213,6 @@ void sr_disable(int srid);
  * API to register the smartreflex class driver with the smartreflex driver
  */
 void omap_sr_register_class(struct omap_smartreflex_class_data *class_data);
-
-int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
 #else
 static inline void omap_smartreflex_enable(int srid) {}
 static inline void omap_smartreflex_disable(int srid) {}
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
new file mode 100644
index 0000000..f84d02c
--- /dev/null
+++ b/arch/arm/mach-omap2/voltage.c
@@ -0,0 +1,626 @@
+/*
+ * OMAP3/OMAP4 Voltage Management Routines
+ *
+ * Author: Thara Gopinath	<thara@ti.com>
+ *
+ * Copyright (C) 2007 Texas Instruments, Inc.
+ * Rajendra Nayak <rnayak@ti.com>
+ * Lesly A M <x0080970@ti.com>
+ *
+ * Copyright (C) 2008 Nokia Corporation
+ * Kalle Jokiniemi
+ *
+ * Copyright (C) 2010 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/pm.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
+
+#include <plat/omap-pm.h>
+#include <plat/omap34xx.h>
+#include <plat/opp.h>
+#include <plat/opp_twl_tps.h>
+#include <plat/clock.h>
+
+#include "prm-regbits-34xx.h"
+#include "voltage.h"
+
+#define MAX_TRIES 100
+
+/**
+ * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
+ * board data or PMIC data
+ */
+#define R_SRI2C_SLAVE_ADDR              0x12
+#define R_VDD1_SR_CONTROL               0x00
+#define R_VDD2_SR_CONTROL		0x01
+
+/* PRM voltage module */
+u32 volt_mod;
+
+/* Voltage processor register offsets */
+struct vp_reg_offs {
+	u8 vpconfig_reg;
+	u8 vstepmin_reg;
+	u8 vstepmax_reg;
+	u8 vlimitto_reg;
+	u8 status_reg;
+	u8 voltage_reg;
+};
+
+/*
+ * Voltage processor structure conttaining info about
+ * the various register offsets and the bit field values
+ * for a particular instance of voltage processor.
+ */
+struct vp_info {
+	struct vp_reg_offs vp_offs;
+	/* Bit fields for VPx_VPCONFIG */
+	u32 vp_erroroffset;
+	u32 vp_errorgain;
+	/* Bit fields for VPx_VSTEPMIN */
+	u32 vp_stepmin;
+	u32 vp_smpswaittimemin;
+	/* Bit fields for VPx_VSTEPMAX */
+	u32 vp_stepmax;
+	u32 vp_smpswaittimemax;
+	/* Bit fields for VPx_VLIMITTO */
+	u32 vp_vddmin;
+	u32 vp_vddmax;
+	u32 vp_timeout;
+};
+static struct vp_info *vp_reg;
+/*
+ * Number of scalable voltage domains that has an independent
+ * Voltage processor
+ */
+static int no_scalable_vdd;
+
+/* OMAP3 VP register offsets and other definitions */
+struct __init vp_reg_offs omap3_vp_offs[] = {
+	/* VP1 */
+	{
+		.vpconfig_reg = OMAP3_PRM_VP1_CONFIG_OFFSET,
+		.vstepmin_reg = OMAP3_PRM_VP1_VSTEPMIN_OFFSET,
+		.vstepmax_reg = OMAP3_PRM_VP1_VSTEPMAX_OFFSET,
+		.vlimitto_reg = OMAP3_PRM_VP1_VLIMITTO_OFFSET,
+		.status_reg = OMAP3_PRM_VP1_STATUS_OFFSET,
+		.voltage_reg = OMAP3_PRM_VP1_VOLTAGE_OFFSET,
+	},
+	/* VP2 */
+	{	.vpconfig_reg = OMAP3_PRM_VP2_CONFIG_OFFSET,
+		.vstepmin_reg = OMAP3_PRM_VP2_VSTEPMIN_OFFSET,
+		.vstepmax_reg = OMAP3_PRM_VP2_VSTEPMAX_OFFSET,
+		.vlimitto_reg = OMAP3_PRM_VP2_VLIMITTO_OFFSET,
+		.status_reg = OMAP3_PRM_VP2_STATUS_OFFSET,
+		.voltage_reg = OMAP3_PRM_VP2_VOLTAGE_OFFSET,
+	},
+};
+
+#define OMAP3_NO_SCALABLE_VDD ARRAY_SIZE(omap3_vp_offs)
+static struct vp_info omap3_vp_reg[OMAP3_NO_SCALABLE_VDD];
+
+
+/* TODO: OMAP4 register offsets */
+
+/*
+ * Voltage controller register offsets
+ */
+struct vc_reg_info {
+	u8 cmdval0_reg;
+	u8 cmdval1_reg;
+	u8 bypass_val_reg;
+} vc_reg;
+
+/*
+ * Default voltage controller settings for OMAP3
+ */
+static struct prm_setup_vc vc_config = {
+	.clksetup = 0xff,
+	.voltsetup_time1 = 0xfff,
+	.voltsetup_time2 = 0xfff,
+	.voltoffset = 0xff,
+	.voltsetup2 = 0xff,
+	.vdd0_on = 0x30,        /* 1.2v */
+	.vdd0_onlp = 0x20,      /* 1.0v */
+	.vdd0_ret = 0x1e,       /* 0.975v */
+	.vdd0_off = 0x00,       /* 0.6v */
+	.vdd1_on = 0x2c,        /* 1.15v */
+	.vdd1_onlp = 0x20,      /* 1.0v */
+	.vdd1_ret = 0x1e,       /* .975v */
+	.vdd1_off = 0x00,       /* 0.6v */
+};
+
+static inline u32 voltage_read_reg(u8 offset)
+{
+	return prm_read_mod_reg(volt_mod, offset);
+}
+
+static inline void voltage_write_reg(u8 offset, u32 value)
+{
+	prm_write_mod_reg(value, volt_mod, offset);
+}
+
+/**
+ * voltagecontroller_init - initializes the voltage controller.
+ *
+ * Intializes the voltage controller registers with the PMIC and board
+ * specific parameters and voltage setup times. If the board file does not
+ * populate the voltage controller parameters through omap3_pm_init_vc,
+ * default values specified in vc_config is used.
+ */
+static void __init init_voltagecontroller(void)
+{
+
+	u8 vc_ch_conf_reg, vc_i2c_cfg_reg, vc_smps_sa_reg, vc_smps_vol_ra_reg;
+	u8 prm_clksetup_reg, prm_voltsetup1_reg;
+	u8 prm_voltsetup2_reg, prm_voltoffset_reg;
+
+	if (cpu_is_omap34xx()) {
+		vc_reg.cmdval0_reg = OMAP3_PRM_VC_CMD_VAL_0_OFFSET;
+		vc_reg.cmdval1_reg = OMAP3_PRM_VC_CMD_VAL_1_OFFSET;
+		vc_reg.bypass_val_reg = OMAP3_PRM_VC_BYPASS_VAL_OFFSET;
+		vc_ch_conf_reg = OMAP3_PRM_VC_CH_CONF_OFFSET;
+		vc_i2c_cfg_reg = OMAP3_PRM_VC_I2C_CFG_OFFSET;
+		vc_smps_sa_reg = OMAP3_PRM_VC_SMPS_SA_OFFSET;
+		vc_smps_vol_ra_reg = OMAP3_PRM_VC_SMPS_VOL_RA_OFFSET;
+		prm_clksetup_reg = OMAP3_PRM_CLKSETUP_OFFSET;
+		prm_voltoffset_reg = OMAP3_PRM_VOLTOFFSET_OFFSET;
+		prm_voltsetup1_reg = OMAP3_PRM_VOLTSETUP1_OFFSET;
+		prm_voltsetup2_reg = OMAP3_PRM_VOLTSETUP2_OFFSET;
+	} else {
+		pr_warning("support for voltage controller not added\n");
+		return;
+	}
+	voltage_write_reg(vc_smps_sa_reg, (R_SRI2C_SLAVE_ADDR <<
+			VC_SMPS_SA1_SHIFT) | (R_SRI2C_SLAVE_ADDR <<
+			VC_SMPS_SA0_SHIFT));
+
+	voltage_write_reg(vc_smps_vol_ra_reg, (R_VDD2_SR_CONTROL <<
+			VC_VOLRA1_SHIFT) | (R_VDD1_SR_CONTROL <<
+			VC_VOLRA0_SHIFT));
+
+	voltage_write_reg(vc_reg.cmdval0_reg,
+			(vc_config.vdd0_on << VC_CMD_ON_SHIFT) |
+			(vc_config.vdd0_onlp << VC_CMD_ONLP_SHIFT) |
+			(vc_config.vdd0_ret << VC_CMD_RET_SHIFT) |
+			(vc_config.vdd0_off << VC_CMD_OFF_SHIFT));
+
+	voltage_write_reg(vc_reg.cmdval1_reg,
+			(vc_config.vdd1_on << VC_CMD_ON_SHIFT) |
+			(vc_config.vdd1_onlp << VC_CMD_ONLP_SHIFT) |
+			(vc_config.vdd1_ret << VC_CMD_RET_SHIFT) |
+			(vc_config.vdd1_off << VC_CMD_OFF_SHIFT));
+
+	voltage_write_reg(vc_ch_conf_reg, VC_CMD1 | VC_RAV1);
+
+	voltage_write_reg(vc_i2c_cfg_reg, VC_MCODE_SHIFT | VC_HSEN);
+
+	/* Write setup times */
+	voltage_write_reg(prm_clksetup_reg, vc_config.clksetup);
+	voltage_write_reg(prm_voltsetup1_reg,
+			(vc_config.voltsetup_time2 << VC_SETUP_TIME2_SHIFT) |
+			(vc_config.voltsetup_time1 << VC_SETUP_TIME1_SHIFT));
+	voltage_write_reg(prm_voltoffset_reg, vc_config.voltoffset);
+	voltage_write_reg(prm_voltsetup2_reg, vc_config.voltsetup2);
+}
+
+static void vp_latch_vsel(int vp_id)
+{
+	u32 vpconfig;
+	unsigned long uvdc;
+	char vsel;
+
+	/* Should remove this once OPP framework is fixed */
+	if (vp_id == VP1) {
+		uvdc = get_curr_vdd1_voltage();
+		if (!uvdc)
+			return;
+	} else if (vp_id == VP2) {
+		uvdc = get_curr_vdd2_voltage();
+		if (!uvdc)
+			return;
+	} else {
+		pr_warning("Voltage processor%d does not exisit", vp_id);
+		return;
+	}
+
+	vsel = omap_twl_uv_to_vsel(uvdc);
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
+	vpconfig &= ~(VP_INITVOLTAGE_MASK | VP_CONFIG_INITVDD);
+	vpconfig |= vsel << VP_INITVOLTAGE_SHIFT;
+
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+
+	/* Trigger initVDD value copy to voltage processor */
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg,
+			(vpconfig | VP_CONFIG_INITVDD));
+
+	/* Clear initVDD copy trigger bit */
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+}
+
+static void __init vp_configure(int vp_id)
+{
+	u32 vpconfig;
+
+	vpconfig = vp_reg[vp_id].vp_erroroffset | vp_reg[vp_id].vp_errorgain |
+			VP_CONFIG_TIMEOUTEN;
+
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vstepmin_reg,
+			(vp_reg[vp_id].vp_smpswaittimemin |
+			vp_reg[vp_id].vp_stepmin));
+
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vstepmax_reg,
+			(vp_reg[vp_id].vp_smpswaittimemax |
+			vp_reg[vp_id].vp_stepmax));
+
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vlimitto_reg,
+			(vp_reg[vp_id].vp_vddmax | vp_reg[vp_id].vp_vddmin |
+			vp_reg[vp_id].vp_timeout));
+
+	/* Set the init voltage */
+	vp_latch_vsel(vp_id);
+
+	vpconfig = voltage_read_reg(vp_reg[vp_id].vp_offs.vpconfig_reg);
+	/* Force update of voltage */
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg,
+			(vpconfig | VP_FORCEUPDATE));
+	/* Clear force bit */
+	voltage_write_reg(vp_reg[vp_id].vp_offs.vpconfig_reg, vpconfig);
+}
+
+static void __init vp_data_configure(int vp_id)
+{
+	if (cpu_is_omap34xx()) {
+		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
+		if (vp_id == VP1) {
+			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
+					OMAP3430_VDDMIN_SHIFT);
+			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
+					OMAP3430_VDDMAX_SHIFT);
+		} else if (vp_id == VP2) {
+			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
+					OMAP3430_VDDMIN_SHIFT);
+			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
+					OMAP3430_VDDMAX_SHIFT);
+		} else {
+			pr_warning("Voltage processor%d does not exisit\
+					in OMAP3 \n", vp_id);
+			return;
+		}
+		vp_reg[vp_id].vp_erroroffset = (OMAP3_VP_CONFIG_ERROROFFSET <<
+					OMAP3430_INITVOLTAGE_SHIFT);
+		vp_reg[vp_id].vp_errorgain = (OMAP3_VP_CONFIG_ERRORGAIN <<
+					OMAP3430_ERRORGAIN_SHIFT);
+		vp_reg[vp_id].vp_smpswaittimemin =
+					(OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN <<
+					OMAP3430_SMPSWAITTIMEMIN_SHIFT);
+		vp_reg[vp_id].vp_smpswaittimemax =
+					(OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX <<
+					OMAP3430_SMPSWAITTIMEMAX_SHIFT);
+		vp_reg[vp_id].vp_stepmin = (OMAP3_VP_VSTEPMIN_VSTEPMIN <<
+					OMAP3430_VSTEPMIN_SHIFT);
+		vp_reg[vp_id].vp_stepmax = (OMAP3_VP_VSTEPMAX_VSTEPMAX <<
+					OMAP3430_VSTEPMAX_SHIFT);
+		vp_reg[vp_id].vp_timeout = (OMAP3_VP_VLIMITTO_TIMEOUT <<
+					OMAP3430_TIMEOUT_SHIFT);
+	}
+	/* TODO Extend this for OMAP4 ?? Or need a separate file  */
+}
+
+/*
+ * vc_bypass_scale_voltage - VC bypass method of voltage scaling
+ */
+static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
+						unsigned long current_volt)
+{
+	u32 vc_bypass_value;
+	u32 reg_addr = 0;
+	u32 loop_cnt = 0, retries_cnt = 0;
+	u32 smps_steps = 0;
+	u32 smps_delay = 0;
+	u8 target_vsel, current_vsel;
+
+	target_vsel = omap_twl_uv_to_vsel(target_volt);
+	current_vsel = omap_twl_uv_to_vsel(current_volt);
+	smps_steps = abs(target_vsel - current_vsel);
+
+	if (vdd == VDD1_OPP) {
+		u32 vc_cmdval0;
+
+		vc_cmdval0 = voltage_read_reg(vc_reg.cmdval0_reg);
+		vc_cmdval0 &= ~VC_CMD_ON_MASK;
+		vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
+		voltage_write_reg(vc_reg.cmdval0_reg, vc_cmdval0);
+		reg_addr = R_VDD1_SR_CONTROL;
+
+	} else if (vdd == VDD2_OPP) {
+		u32 vc_cmdval1;
+
+		vc_cmdval1 = voltage_read_reg(vc_reg.cmdval1_reg);
+		vc_cmdval1 &= ~VC_CMD_ON_MASK;
+		vc_cmdval1 |= (target_vsel << VC_CMD_ON_SHIFT);
+		voltage_write_reg(vc_reg.cmdval1_reg, vc_cmdval1);
+		reg_addr = R_VDD2_SR_CONTROL;
+	} else {
+		pr_warning("Wrong VDD passed in vc_bypass_scale_voltage %d\n",
+				vdd);
+		return false;
+	}
+
+	vc_bypass_value = (target_vsel << VC_DATA_SHIFT) |
+			(reg_addr << VC_REGADDR_SHIFT) |
+			(R_SRI2C_SLAVE_ADDR << VC_SLAVEADDR_SHIFT);
+
+	voltage_write_reg(vc_reg.bypass_val_reg, vc_bypass_value);
+
+	voltage_write_reg(vc_reg.bypass_val_reg,
+			vc_bypass_value | VC_VALID);
+	vc_bypass_value = voltage_read_reg(vc_reg.bypass_val_reg);
+
+	while ((vc_bypass_value & VC_VALID) != 0x0) {
+		loop_cnt++;
+		if (retries_cnt > 10) {
+			pr_warning("Loop count exceeded in check SR I2C write\
+						during voltgae scaling\n");
+			return false;
+		}
+		if (loop_cnt > 50) {
+			retries_cnt++;
+			loop_cnt = 0;
+			udelay(10);
+		}
+		vc_bypass_value = voltage_read_reg(vc_reg.bypass_val_reg);
+	}
+
+	/*
+	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
+	 *  2us added as buffer.
+	 */
+	smps_delay = ((smps_steps * 125) / 40) + 2;
+	udelay(smps_delay);
+	return true;
+}
+
+
+static void __init init_voltageprocessors(void)
+{
+	int i;
+
+	if (cpu_is_omap34xx()) {
+		vp_reg = omap3_vp_reg;
+		no_scalable_vdd = OMAP3_NO_SCALABLE_VDD;
+	} else {
+		/* TODO: Add support for OMAP4 */
+		pr_warning("Voltage processor support not yet added\n");
+		return;
+	}
+	for (i = 0; i < no_scalable_vdd; i++) {
+		vp_data_configure(i);
+		vp_configure(i);
+	}
+}
+
+/* Public functions */
+
+/**
+ * get_curr_vdd1_voltage : Gets the current non-auto-compensated vdd1 voltage
+ *
+ * This is a temporary placeholder for this API. This should ideally belong
+ * to Shared resource framework.
+ */
+unsigned long get_curr_vdd1_voltage(void)
+{
+	struct omap_opp *opp;
+	unsigned long freq;
+	struct clk *dpll1_clk;
+
+	dpll1_clk = clk_get(NULL, "dpll1_ck");
+	if (IS_ERR(dpll1_clk))
+		return 0;
+
+	freq = dpll1_clk->rate;
+	opp = opp_find_freq_ceil(OPP_MPU, &freq);
+	if (IS_ERR(opp)) {
+		clk_put(dpll1_clk);
+		return 0;
+	}
+
+	/*
+	 * Use higher freq voltage even if an exact match is not available
+	 * we are probably masking a clock framework bug, so warn
+	 */
+	if (unlikely(freq != dpll1_clk->rate))
+		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
+			__func__, freq, dpll1_clk->rate);
+
+	clk_put(dpll1_clk);
+	return opp_get_voltage(opp);
+}
+
+/**
+ * get_curr_vdd2_voltage : Gets the current non-auto-compensated vdd2 voltage
+ *
+ * This is a temporary placeholder for this API. This should ideally belong
+ * to Shared resource framework.
+ */
+unsigned long get_curr_vdd2_voltage(void)
+{
+	struct omap_opp *opp;
+	unsigned long freq;
+	struct clk *l3_clk;
+
+	l3_clk = clk_get(NULL, "l3_ick");
+	if (IS_ERR(l3_clk))
+		return 0;
+
+	freq = l3_clk->rate;
+	opp = opp_find_freq_ceil(OPP_L3, &freq);
+	if (IS_ERR(opp)) {
+		clk_put(l3_clk);
+		return 0;
+	}
+
+	/*
+	 * Use higher freq voltage even if an exact match is not available
+	 * we are probably masking a clock framework bug, so warn
+	 */
+	if (unlikely(freq != l3_clk->rate))
+		pr_warning("%s: Available freq %ld != dpll freq %ld.\n",
+			__func__, freq, l3_clk->rate);
+
+	clk_put(l3_clk);
+	return opp_get_voltage(opp);
+}
+
+/**
+ * omap_voltageprocessor_enable : API to enable a particular VP
+ * @vp_id : The id of the VP to be enable.
+ *
+ * This API enables a particular voltage processor. Needed by the smartreflex
+ * class drivers.
+ */
+void omap_voltageprocessor_enable(int vp_id)
+{
+	u32 vpconfig;
+
+	/*
+	 * This latching is required only if VC bypass method is used for
+	 * voltage scaling during dvfs.
+	 */
+	vp_latch_vsel(vp_id - 1);
+	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
+	/* Enable VP */
+	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg,
+				vpconfig | VP_CONFIG_VPENABLE);
+}
+
+/**
+ * omap_voltageprocessor_disable : API to disable a particular VP
+ * @vp_id : The id of the VP to be disable.
+ *
+ * This API disables a particular voltage processor. Needed by the smartreflex
+ * class drivers.
+ */
+void omap_voltageprocessor_disable(int vp_id)
+{
+	int i = 0;
+	u32 vpconfig;
+
+	/* Wait for VP idle before disabling VP */
+	while ((!voltage_read_reg(vp_reg[vp_id - 1].vp_offs.status_reg)) &&
+				i++ < MAX_TRIES)
+		udelay(1);
+
+	if (i >= MAX_TRIES)
+		pr_warning("VP1 not idle, still going ahead with \
+						VP1 disable\n");
+	/* Disable VP1 */
+	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
+	vpconfig &= ~VP_CONFIG_VPENABLE;
+	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg, vpconfig);
+}
+
+/**
+ * omap_voltage_scale : API to scale voltage of a particular voltage domain.
+ * @vdd : the voltage domain whose voltage is to be scaled
+ * @target_vsel : The target voltage of the voltage domain
+ * @current_vsel : the current voltage of the voltage domain.
+ *
+ * This API should be called by the kernel to do the voltage scaling
+ * for a particular voltage domain during dvfs or any other situation.
+ */
+int omap_voltage_scale(int vdd, unsigned long target_volt,
+					unsigned long current_volt)
+{	/*
+	 * TODO add VP force update method of voltage scaling
+	 * and choose btw the two
+	 */
+	return vc_bypass_scale_voltage(vdd, target_volt, current_volt);
+}
+
+/**
+ * omap_reset_voltage : Resets the voltage of a particular voltage domain
+ * to that of the current OPP.
+ * @vdd : the voltage domain whose voltage is to be reset.
+ *
+ * This API finds out the correct voltage the voltage domain is supposed
+ * to be at and resets the voltage to that level. Should be used expecially
+ * while disabling any voltage compensation modules.
+ */
+void omap_reset_voltage(int vdd)
+{
+	unsigned long target_uvdc, current_uvdc;
+	char vsel;
+
+	/* Should remove this once OPP framework is fixed */
+	if ((vdd - 1) == VP1) {
+		target_uvdc = get_curr_vdd1_voltage();
+		if (!target_uvdc)
+			return;
+	} else if ((vdd - 1) == VP2) {
+		target_uvdc = get_curr_vdd2_voltage();
+		if (!target_uvdc)
+			return;
+	} else {
+		pr_warning("Wrong VDD passed in omap_reset_voltage %d\n", vdd);
+		return;
+	}
+	vsel = voltage_read_reg(vp_reg[vdd - 1].vp_offs.voltage_reg);
+	current_uvdc = (vsel * 12500) + 600000;
+	omap_voltage_scale(vdd, target_uvdc, current_uvdc);
+}
+
+/**
+ * omap3_pm_init_vc - polpulates vc_config with values specified in board file
+ * @setup_vc - the structure with various vc parameters
+ *
+ * Updates vc_config with the voltage setup times and other parameters as
+ * specified in setup_vc. vc_config is later used in init_voltagecontroller
+ * to initialize the voltage controller registers. Board files should call
+ * this function with the correct volatge settings corresponding
+ * the particular PMIC and chip.
+ */
+void __init omap_voltage_init_vc(struct prm_setup_vc *setup_vc)
+{
+	if (!setup_vc)
+		return;
+
+	vc_config.clksetup = setup_vc->clksetup;
+	vc_config.voltsetup_time1 = setup_vc->voltsetup_time1;
+	vc_config.voltsetup_time2 = setup_vc->voltsetup_time2;
+	vc_config.voltoffset = setup_vc->voltoffset;
+	vc_config.voltsetup2 = setup_vc->voltsetup2;
+	vc_config.vdd0_on = setup_vc->vdd0_on;
+	vc_config.vdd0_onlp = setup_vc->vdd0_onlp;
+	vc_config.vdd0_ret = setup_vc->vdd0_ret;
+	vc_config.vdd0_off = setup_vc->vdd0_off;
+	vc_config.vdd1_on = setup_vc->vdd1_on;
+	vc_config.vdd1_onlp = setup_vc->vdd1_onlp;
+	vc_config.vdd1_ret = setup_vc->vdd1_ret;
+	vc_config.vdd1_off = setup_vc->vdd1_off;
+}
+
+/**
+ * omap_voltage_init : Volatage init API which does VP and VC init.
+ */
+void __init omap_voltage_init(void)
+{
+	if (cpu_is_omap34xx())
+		volt_mod = OMAP3430_GR_MOD;
+	else
+		return;
+	init_voltagecontroller();
+	init_voltageprocessors();
+}
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
new file mode 100644
index 0000000..663c6fe
--- /dev/null
+++ b/arch/arm/mach-omap2/voltage.h
@@ -0,0 +1,74 @@
+/*
+ * OMAP3 Voltage Management Routines
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ * Thara Gopinath <thara@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include "pm.h"
+
+/* Voltageprocessor instances */
+#define VP1	0
+#define VP2	1
+
+
+/* Generic VP definitions. Need to be redefined for OMAP4 */
+#define VP_CONFIG_TIMEOUTEN	OMAP3430_TIMEOUTEN
+#define VP_CONFIG_INITVDD	OMAP3430_INITVDD
+#define VP_FORCEUPDATE		OMAP3430_FORCEUPDATE
+#define VP_CONFIG_VPENABLE	OMAP3430_VPENABLE
+#define VP_INITVOLTAGE_MASK	OMAP3430_INITVOLTAGE_MASK
+#define VP_INITVOLTAGE_SHIFT	OMAP3430_INITVOLTAGE_SHIFT
+
+/* Generic VC definitions. Need to be redefined for OMAP4 */
+#define VC_SMPS_SA1_SHIFT	OMAP3430_SMPS_SA1_SHIFT
+#define VC_SMPS_SA0_SHIFT	OMAP3430_SMPS_SA0_SHIFT
+#define VC_VOLRA1_SHIFT		OMAP3430_VOLRA1_SHIFT
+#define VC_VOLRA0_SHIFT		OMAP3430_VOLRA0_SHIFT
+#define VC_CMD_ON_SHIFT		OMAP3430_VC_CMD_ON_SHIFT
+#define VC_CMD_ONLP_SHIFT	OMAP3430_VC_CMD_ONLP_SHIFT
+#define VC_CMD_RET_SHIFT	OMAP3430_VC_CMD_RET_SHIFT
+#define VC_CMD_OFF_SHIFT	OMAP3430_VC_CMD_OFF_SHIFT
+#define VC_SETUP_TIME2_SHIFT	OMAP3430_SETUP_TIME2_SHIFT
+#define VC_SETUP_TIME1_SHIFT	OMAP3430_SETUP_TIME1_SHIFT
+#define VC_DATA_SHIFT		OMAP3430_DATA_SHIFT
+#define VC_REGADDR_SHIFT	OMAP3430_REGADDR_SHIFT
+#define VC_SLAVEADDR_SHIFT	OMAP3430_SLAVEADDR_SHIFT
+#define VC_CMD_ON_MASK		OMAP3430_VC_CMD_ON_MASK
+#define VC_CMD1			OMAP3430_CMD1
+#define VC_RAV1			OMAP3430_RAV1
+#define VC_MCODE_SHIFT		OMAP3430_MCODE_SHIFT
+#define VC_HSEN			OMAP3430_HSEN
+#define VC_VALID		OMAP3430_VALID
+
+
+/*
+ * Omap 3430 VP registerspecific values. Maybe these need to come from
+ * board file or PMIC data structure
+ */
+#define OMAP3_VP_CONFIG_ERROROFFSET		0x00
+#define OMAP3_VP_CONFIG_ERRORGAIN		0x20
+#define	OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x01F4
+#define OMAP3_VP_VSTEPMIN_VSTEPMIN		0x1
+#define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX	0x01F4
+#define OMAP3_VP_VSTEPMAX_VSTEPMAX		0x04
+#define OMAP3_VP1_VLIMITTO_VDDMIN		0x0
+#define OMAP3_VP1_VLIMITTO_VDDMAX		0x3C
+#define OMAP3_VP2_VLIMITTO_VDDMAX		0x2C
+#define OMAP3_VP2_VLIMITTO_VDDMIN		0x0
+#define OMAP3_VP_VLIMITTO_TIMEOUT		0xFFFF
+
+/* TODO OMAP4 VP register values if the same file is used for OMAP4*/
+
+void omap_voltageprocessor_enable(int vp_id);
+void omap_voltageprocessor_disable(int vp_id);
+void omap_voltage_init_vc(struct prm_setup_vc *setup_vc);
+void omap_voltage_init(void);
+int omap_voltage_scale(int vdd, unsigned long target_volt,
+					unsigned long current_volt);
+void omap_reset_voltage(int vdd);
+unsigned long get_curr_vdd1_voltage(void);
+unsigned long get_curr_vdd2_voltage(void);
-- 
1.7.0.rc1.33.g07cf0f

