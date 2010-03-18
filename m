From: Thara Gopinath <thara@ti.com>
Subject: [PATCHv2 15/17] OMAP3: PM: Implement latest h/w recommendations for SR and VP registers and SR VP enable disable sequence.
Date: Thu, 18 Mar 2010 14:45:53 +0530
Message-ID: <1268903755-4151-16-git-send-email-thara@ti.com>
References: <1268903755-4151-1-git-send-email-thara@ti.com>
 <1268903755-4151-2-git-send-email-thara@ti.com>
 <1268903755-4151-3-git-send-email-thara@ti.com>
 <1268903755-4151-4-git-send-email-thara@ti.com>
 <1268903755-4151-5-git-send-email-thara@ti.com>
 <1268903755-4151-6-git-send-email-thara@ti.com>
 <1268903755-4151-7-git-send-email-thara@ti.com>
 <1268903755-4151-8-git-send-email-thara@ti.com>
 <1268903755-4151-9-git-send-email-thara@ti.com>
 <1268903755-4151-10-git-send-email-thara@ti.com>
 <1268903755-4151-11-git-send-email-thara@ti.com>
 <1268903755-4151-12-git-send-email-thara@ti.com>
 <1268903755-4151-13-git-send-email-thara@ti.com>
 <1268903755-4151-14-git-send-email-thara@ti.com>
 <1268903755-4151-15-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38284 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751338Ab0CRJQL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Mar 2010 05:16:11 -0400
In-Reply-To: <1268903755-4151-15-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces OMAP3 specific values for Smartreflex and
Voltage processor registers as per the latest TI recommendations.
This patch also improves the smartreflex and voltage processor
enable disable sequences as per the latest recommendations.

These recommendations were first formed based on experimentations
on N900 platform  and were implemented in the N900 codebase
base first by Nishanth Menon and Paul Walmsley.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   72 ++++++++++++++++++++++++-----
 arch/arm/mach-omap2/smartreflex.h |    9 ++-
 arch/arm/mach-omap2/voltage.c     |   93 +++++++++++++++++++++++++++++++-----
 arch/arm/mach-omap2/voltage.h     |   16 ++++---
 4 files changed, 155 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 7858113..1d7d2e6 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -27,13 +27,16 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 
 #include <plat/omap_hwmod.h>
 #include <plat/omap_device.h>
+#include <plat/common.h>
 
 #include "smartreflex.h"
 
 #define SMARTREFLEX_NAME_LEN	16
+#define SR_DISABLE_TIMEOUT	200
 
 struct omap_sr {
 	int				srid;
@@ -207,17 +210,33 @@ static void sr_set_regfields(struct omap_sr *sr)
 	 * fields will have to be populated using the pdata or pmic structure.
 	 */
 	if (cpu_is_omap343x()) {
+		struct omap_smartreflex_data *pdata =
+					sr->pdev->dev.platform_data;
 		sr->err_weight = OMAP3430_SR_ERRWEIGHT;
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
 		if (sr->srid == SR1) {
-			sr->err_minlimit = OMAP3430_SR1_ERRMINLIMIT;
 			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
+			pdata->sr_volt_data[0].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+			pdata->sr_volt_data[1].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+			pdata->sr_volt_data[2].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+			pdata->sr_volt_data[3].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
+			pdata->sr_volt_data[4].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
 		} else {
-			sr->err_minlimit = OMAP3430_SR2_ERRMINLIMIT;
 			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
+			pdata->sr_volt_data[0].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+			pdata->sr_volt_data[1].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+			pdata->sr_volt_data[2].sr_errminlimit =
+					OMAP3430_SR_ERRMINLIMIT_HIGHOPP;
 		}
 	}
 	/* TODO: 3630 and Omap4 specific bit field values */
@@ -307,11 +326,6 @@ static void sr_start_vddautocomp(int srid)
 		return;
 	}
 
-	if (sr->is_sr_reset == 1) {
-		sr_clk_enable(sr);
-		sr_configure(sr);
-	}
-
 	sr->is_autocomp_active = 1;
 	if (!sr_class->enable(srid)) {
 		sr->is_autocomp_active = 0;
@@ -412,6 +426,13 @@ int sr_enable(int srid, unsigned long volt)
 		return false;
 	}
 
+	/* errminlimit is opp dependent and hence linked to voltage */
+	sr->err_minlimit = volt_data.sr_errminlimit;
+
+	/* Enable the clocks and configure SR */
+	sr_clk_enable(sr);
+	sr_configure(sr);
+
 	sr_write_reg(sr, NVALUERECIPROCAL, nvalue_reciprocal);
 	/* SRCONFIG - enable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, SRCONFIG_SRENABLE);
@@ -428,6 +449,7 @@ int sr_enable(int srid, unsigned long volt)
 void sr_disable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
+	int timeout = 0;
 
 	if (!sr) {
 		pr_warning("omap_sr struct corresponding to SR%d not found\n",
@@ -435,10 +457,39 @@ void sr_disable(int srid)
 		return;
 	}
 
-	sr->is_sr_reset = 1;
+	/* Check if SR is already disabled. If yes do nothing */
+	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
+		return;
+
+	/* Enable MCUDisableAcknowledge interrupt */
+	sr_modify_reg(sr, ERRCONFIG,
+			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
+
 	/* SRCONFIG - disable SR */
-	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, ~SRCONFIG_SRENABLE);
+	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
+
+	/* Disable all other SR interrupts and clear the status */
+	sr_modify_reg(sr, ERRCONFIG,
+			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
+			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN),
+			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
+			ERRCONFIG_MCUBOUNDINTST | ERRCONFIG_VPBOUNDINTST));
 
+	/* Wait for SR to be disabled.
+	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	omap_test_timeout((sr_read_reg(sr, ERRCONFIG) &
+			ERRCONFIG_MCUDISACKINTST), SR_DISABLE_TIMEOUT,
+			timeout);
+
+	if (timeout >= SR_DISABLE_TIMEOUT)
+		pr_warning("SR%d disable timedout\n", srid);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt
+	 * Also enable VPBOUND interrrupt
+	 */
+	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN,
+			ERRCONFIG_MCUDISACKINTST);
 }
 
 /**
@@ -468,9 +519,6 @@ void omap_smartreflex_enable(int srid)
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 1) {
-			/* Enable SR clks */
-			sr_clk_enable(sr);
-			sr_configure(sr);
 			if (!sr_class->enable(srid))
 				sr_clk_disable(sr);
 		}
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 58681b6..01d3534 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -110,10 +110,10 @@ extern struct dentry *pm_dbg_main_dir;
 #define OMAP3430_SR2_SENPAVGWEIGHT	0x01
 #define OMAP3430_SR2_SENNAVGWEIGHT	0x01
 
-#define OMAP3430_SR_ERRWEIGHT		0x07
+#define OMAP3430_SR_ERRWEIGHT		0x04
 #define OMAP3430_SR_ERRMAXLIMIT		0x02
-#define OMAP3430_SR1_ERRMINLIMIT	0xFA
-#define OMAP3430_SR2_ERRMINLIMIT	0xF9
+#define OMAP3430_SR_ERRMINLIMIT_HIGHOPP	0xF9
+#define OMAP3430_SR_ERRMINLIMIT_LOWOPP	0xF4
 
 /* TODO:3630/OMAP4 values if it has to come from this file */
 
@@ -177,10 +177,13 @@ struct omap_smartreflex_class_data {
  *
  * @voltage	: The possible voltage value
  * @sr_nvalue	: Smartreflex N target value at voltage <voltage>
+ * @sr_errminlimt : SR error min limit value. This value is different
+ *			at differnet opp and thus is linked with voltage.
  */
 struct omap_sr_volt_data {
 	unsigned long	voltage;
 	u32		sr_nvalue;
+	u32		sr_errminlimit;
 };
 
 /**
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 754b6b2..d660d02 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -29,13 +29,16 @@
 #include <plat/opp.h>
 #include <plat/opp_twl_tps.h>
 #include <plat/clock.h>
+#include <plat/common.h>
 
 #include "prm-regbits-34xx.h"
 #include "voltage.h"
 
-#define MAX_TRIES 100
+#define VP_IDLE_TIMEOUT		200
+#define VDD1_LOWOPP_VOLT	1075000
+#define VDD2_LOWOPP_VOLT	1050000
 
-/**
+/*
  * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
  * board data or PMIC data
  */
@@ -212,6 +215,21 @@ static void __init init_voltagecontroller(void)
 	voltage_write_reg(prm_voltsetup2_reg, vc_config.voltsetup2);
 }
 
+static u8 omap3_get_vp_errorgain(int vp_id, unsigned long volt)
+{
+	unsigned long lowopp_volt;
+
+	if (vp_id == VP1)
+		lowopp_volt = VDD1_LOWOPP_VOLT;
+	else if (vp_id == VP2)
+		lowopp_volt = VDD2_LOWOPP_VOLT;
+	else {
+		pr_warning("Voltage processor%d does not exisit", vp_id);
+		return 0;
+	}
+	return ((volt > lowopp_volt) ? (OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+		(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP));
+}
 static void vp_latch_vsel(int vp_id)
 {
 	u32 vpconfig;
@@ -282,13 +300,19 @@ static void __init vp_configure(int vp_id)
 static void __init vp_reg_configure(int vp_id)
 {
 	if (cpu_is_omap34xx()) {
+		struct clk *sys_ck;
+		u32 sys_clk_speed, timeout_val;
+		unsigned long curr_volt;
+
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
 		if (vp_id == VP1) {
+			curr_volt = get_curr_vdd1_voltage();
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
 		} else if (vp_id == VP2) {
+			curr_volt = get_curr_vdd2_voltage();
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
@@ -300,7 +324,9 @@ static void __init vp_reg_configure(int vp_id)
 		}
 		vp_reg[vp_id].vp_erroroffset = (OMAP3_VP_CONFIG_ERROROFFSET <<
 					OMAP3430_INITVOLTAGE_SHIFT);
-		vp_reg[vp_id].vp_errorgain = (OMAP3_VP_CONFIG_ERRORGAIN <<
+		/* OMAP3430 has errorgain varying btw higher and lower opp's */
+		vp_reg[vp_id].vp_errorgain = (omap3_get_vp_errorgain
+					(vp_id, curr_volt) <<
 					OMAP3430_ERRORGAIN_SHIFT);
 		vp_reg[vp_id].vp_smpswaittimemin =
 					(OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN <<
@@ -312,7 +338,23 @@ static void __init vp_reg_configure(int vp_id)
 					OMAP3430_VSTEPMIN_SHIFT);
 		vp_reg[vp_id].vp_stepmax = (OMAP3_VP_VSTEPMAX_VSTEPMAX <<
 					OMAP3430_VSTEPMAX_SHIFT);
-		vp_reg[vp_id].vp_timeout = (OMAP3_VP_VLIMITTO_TIMEOUT <<
+		/*
+		 * Use sys clk speed to convert the VP timeout in us to
+		 * number of clock cycles
+		 */
+		sys_ck = clk_get(NULL, "sys_ck");
+		if (IS_ERR(sys_ck)) {
+			pr_warning("Could not get the sys clk to calculate \
+					timeout value for VP %d\n", vp_id + 1);
+			return;
+		}
+		sys_clk_speed = clk_get_rate(sys_ck);
+		clk_put(sys_ck);
+		/* Divide to avoid overflow */
+		sys_clk_speed /= 1000;
+		timeout_val = (sys_clk_speed * OMAP3_VP_VLIMITTO_TIMEOUT_US) /
+					1000;
+		vp_reg[vp_id].vp_timeout = (timeout_val <<
 					OMAP3430_TIMEOUT_SHIFT);
 	}
 	/* TODO Extend this for OMAP4 ?? Or need a separate file  */
@@ -358,6 +400,19 @@ static int vc_bypass_scale_voltage(u32 vdd, unsigned long target_volt,
 		return false;
 	}
 
+	/* OMAP3430 has errorgain varying btw higher and lower opp's */
+	if (cpu_is_omap34xx()) {
+		u32 errorgain = voltage_read_reg(vp_reg[vdd - 1].vp_offs.
+					vpconfig_reg);
+
+		vp_reg[vdd - 1].vp_errorgain = (omap3_get_vp_errorgain(
+						(vdd - 1), target_volt) <<
+						OMAP3430_ERRORGAIN_SHIFT);
+		errorgain &= ~VP_ERRORGAIN_MASK;
+		errorgain |= vp_reg[vdd - 1].vp_errorgain;
+		voltage_write_reg(vp_reg[vdd - 1].vp_offs.vpconfig_reg,
+				errorgain);
+	}
 	vc_bypass_value = (target_vsel << VC_DATA_SHIFT) |
 			(reg_addr << VC_REGADDR_SHIFT) |
 			(R_SRI2C_SLAVE_ADDR << VC_SLAVEADDR_SHIFT);
@@ -474,6 +529,10 @@ void omap_voltageprocessor_enable(int vp_id)
 {
 	u32 vpconfig;
 
+	/* If VP is already enabled, do nothing. Return */
+	if (voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg) &
+				VP_CONFIG_VPENABLE)
+		return;
 	/*
 	 * This latching is required only if VC bypass method is used for
 	 * voltage scaling during dvfs.
@@ -494,21 +553,29 @@ void omap_voltageprocessor_enable(int vp_id)
  */
 void omap_voltageprocessor_disable(int vp_id)
 {
-	int i = 0;
 	u32 vpconfig;
+	int timeout;
 
-	/* Wait for VP idle before disabling VP */
-	while ((!voltage_read_reg(vp_reg[vp_id - 1].vp_offs.status_reg)) &&
-				i++ < MAX_TRIES)
-		udelay(1);
+	/* If VP is already disabled, do nothing. Return */
+	if (!(voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg) &
+				VP_CONFIG_VPENABLE))
+		return;
 
-	if (i >= MAX_TRIES)
-		pr_warning("VP1 not idle, still going ahead with \
-						VP1 disable\n");
-	/* Disable VP1 */
+	/* Disable VP */
 	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg);
 	vpconfig &= ~VP_CONFIG_VPENABLE;
 	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vpconfig_reg, vpconfig);
+
+	/*
+	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
+	 */
+	omap_test_timeout((voltage_read_reg
+			(vp_reg[vp_id - 1].vp_offs.status_reg)),
+			VP_IDLE_TIMEOUT, timeout);
+
+	if (timeout >= VP_IDLE_TIMEOUT)
+		pr_warning("VP%d idle timedout\n", vp_id);
+	return;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 56829b5..88d9b07 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -20,6 +20,7 @@
 #define VP_CONFIG_INITVDD	OMAP3430_INITVDD
 #define VP_FORCEUPDATE		OMAP3430_FORCEUPDATE
 #define VP_CONFIG_VPENABLE	OMAP3430_VPENABLE
+#define VP_ERRORGAIN_MASK	OMAP3430_ERRORGAIN_MASK
 #define VP_INITVOLTAGE_MASK	OMAP3430_INITVOLTAGE_MASK
 #define VP_INITVOLTAGE_SHIFT	OMAP3430_INITVOLTAGE_SHIFT
 
@@ -50,16 +51,17 @@
  * board file or PMIC data structure
  */
 #define OMAP3_VP_CONFIG_ERROROFFSET		0x00
-#define OMAP3_VP_CONFIG_ERRORGAIN		0x20
-#define	OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x01F4
+#define OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP	0x0C
+#define OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP	0x18
+#define OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x3C
 #define OMAP3_VP_VSTEPMIN_VSTEPMIN		0x1
-#define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX	0x01F4
+#define OMAP3_VP_VSTEPMAX_SMPSWAITTIMEMAX	0x3C
 #define OMAP3_VP_VSTEPMAX_VSTEPMAX		0x04
-#define OMAP3_VP1_VLIMITTO_VDDMIN		0x0
-#define OMAP3_VP1_VLIMITTO_VDDMAX		0x3C
+#define OMAP3_VP1_VLIMITTO_VDDMIN		0x14
+#define OMAP3_VP1_VLIMITTO_VDDMAX		0x42
 #define OMAP3_VP2_VLIMITTO_VDDMAX		0x2C
-#define OMAP3_VP2_VLIMITTO_VDDMIN		0x0
-#define OMAP3_VP_VLIMITTO_TIMEOUT		0xFFFF
+#define OMAP3_VP2_VLIMITTO_VDDMIN		0x18
+#define OMAP3_VP_VLIMITTO_TIMEOUT_US		0x200
 
 #define VOLTAGE_MOD	OMAP3430_GR_MOD
 /* TODO OMAP4 VP register values if the same file is used for OMAP4*/
-- 
1.7.0.rc1.33.g07cf0f

