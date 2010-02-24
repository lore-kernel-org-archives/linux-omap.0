From: Thara Gopinath <thara@ti.com>
Subject: [PATCH 14/16] OMAP3: PM: Implement latest h/w recommendations for SR and VP registers and SR VP enable disable sequence.
Date: Wed, 24 Feb 2010 14:59:15 +0530
Message-ID: <1267003757-22456-15-git-send-email-thara@ti.com>
References: <1267003757-22456-1-git-send-email-thara@ti.com>
 <1267003757-22456-2-git-send-email-thara@ti.com>
 <1267003757-22456-3-git-send-email-thara@ti.com>
 <1267003757-22456-4-git-send-email-thara@ti.com>
 <1267003757-22456-5-git-send-email-thara@ti.com>
 <1267003757-22456-6-git-send-email-thara@ti.com>
 <1267003757-22456-7-git-send-email-thara@ti.com>
 <1267003757-22456-8-git-send-email-thara@ti.com>
 <1267003757-22456-9-git-send-email-thara@ti.com>
 <1267003757-22456-10-git-send-email-thara@ti.com>
 <1267003757-22456-11-git-send-email-thara@ti.com>
 <1267003757-22456-12-git-send-email-thara@ti.com>
 <1267003757-22456-13-git-send-email-thara@ti.com>
 <1267003757-22456-14-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:46749 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755891Ab0BXJ3f (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Feb 2010 04:29:35 -0500
In-Reply-To: <1267003757-22456-14-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, nm@ti.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com, Thara Gopinath <thara@ti.com>

This patch introduces OMAP3 specific values for Smartreflex and
Voltage processor registers as per the latest TI recommendations.
This patch also improves the smartreflex and voltage processor
enable disable sequences as per the latest recommendations.

These recommendations were first formed based on experimentations
on Nokia Rover platform  and were implemented in the Rover code
base first by Nishanth Menon and Paul Walmsley.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   65 ++++++++++++++++++++-----
 arch/arm/mach-omap2/smartreflex.h |    6 +-
 arch/arm/mach-omap2/voltage.c     |   95 ++++++++++++++++++++++++++++++------
 arch/arm/mach-omap2/voltage.h     |   16 ++++---
 4 files changed, 142 insertions(+), 40 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 8a4c48b..ca2223d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -24,6 +24,7 @@
 #include <linux/io.h>
 #include <linux/list.h>
 #include <linux/debugfs.h>
+#include <linux/delay.h>
 
 #include <plat/control.h>
 #include <plat/omap_hwmod.h>
@@ -32,6 +33,7 @@
 #include "smartreflex.h"
 
 #define SMARTREFLEX_NAME_LEN	16
+#define SR_DISABLE_TIMEOUT	200
 
 struct omap_sr {
 	int			srid;
@@ -184,11 +186,9 @@ static void sr_set_regfields(struct omap_sr *sr)
 		sr->err_maxlimit = OMAP3430_SR_ERRMAXLIMIT;
 		sr->accum_data = OMAP3430_SR_ACCUMDATA;
 		if (sr->srid == SR1) {
-			sr->err_minlimit = OMAP3430_SR1_ERRMINLIMIT;
 			sr->senn_avgweight = OMAP3430_SR1_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR1_SENPAVGWEIGHT;
 		} else {
-			sr->err_minlimit = OMAP3430_SR2_ERRMINLIMIT;
 			sr->senn_avgweight = OMAP3430_SR2_SENNAVGWEIGHT;
 			sr->senp_avgweight = OMAP3430_SR2_SENPAVGWEIGHT;
 		}
@@ -280,11 +280,6 @@ static void sr_start_vddautocomap(int srid)
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
@@ -351,8 +346,20 @@ int sr_enable(int srid, u32 target_opp_no)
 		return false;
 	}
 
-	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
+	/*
+	 * For OMAP3430 errminlimit is dependent on opp. So choose
+	 * it appropriately
+	 */
+	if (cpu_is_omap343x())
+		sr->err_minlimit = (target_opp_no > 2) ?
+			OMAP3430_SR_ERRMINLIMIT_HIGHOPP :
+			OMAP3430_SR_ERRMINLIMIT_LOWOPP;
+
+	/* Enable the clocks and configure SR */
+	sr_clk_enable(sr);
+	sr_configure(sr);
 
+	nvalue_reciprocal = pdata->sr_nvalue[target_opp_no - 1];
 	if (nvalue_reciprocal == 0) {
 		pr_notice("OPP%d doesn't support SmartReflex\n",
 								target_opp_no);
@@ -375,10 +382,44 @@ int sr_enable(int srid, u32 target_opp_no)
 void sr_disable(int srid)
 {
 	struct omap_sr *sr = _sr_lookup(srid);
+	int timeout = 0;
+
+	/* Check if SR is already disabled. If yes do nothing */
+	if (!(sr_read_reg(sr, SRCONFIG) & SRCONFIG_SRENABLE))
+		return;
+
+	/* Enable MCUDisableAcknowledge interrupt */
+	sr_modify_reg(sr, ERRCONFIG,
+			ERRCONFIG_MCUDISACKINTEN, ERRCONFIG_MCUDISACKINTEN);
 
-	sr->is_sr_reset = 1;
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
+
+	/* Wait for SR to be disabled.
+	 * wait until ERRCONFIG.MCUDISACKINTST = 1. Typical latency is 1us.
+	 */
+	while ((timeout < SR_DISABLE_TIMEOUT) &&
+		(!(sr_read_reg(sr, ERRCONFIG) & ERRCONFIG_MCUDISACKINTST))) {
+
+		udelay(1);
+		timeout++;
+	}
+
+	if (timeout == SR_DISABLE_TIMEOUT)
+		pr_warning("SR%d disable timedout\n", srid);
+
+	/* Disable MCUDisableAcknowledge interrupt & clear pending interrupt
+	 * Also enable VPBOUND interrrupt
+	 */
+	sr_modify_reg(sr, ERRCONFIG, ERRCONFIG_MCUDISACKINTEN,
+			ERRCONFIG_MCUDISACKINTST);
 }
 
 /**
@@ -407,10 +448,6 @@ void omap_smartreflex_enable(int srid)
 
 	if (sr->is_autocomp_active == 1) {
 		if (sr->is_sr_reset == 1) {
-			/* Enable SR clks */
-			sr_clk_enable(sr);
-			sr_configure(sr);
-
 			if (!sr_class->enable(srid))
 				sr_clk_disable(sr);
 		}
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index fbb6bf4..ae8d5db 100644
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
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index c0c2c17..49167c0 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -19,6 +19,7 @@
 #include <linux/pm.h>
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/clk.h>
 
 #include <plat/omap-pm.h>
 #include <plat/omap34xx.h>
@@ -28,9 +29,9 @@
 #include "prm-regbits-34xx.h"
 #include "voltage.h"
 
-#define MAX_TRIES 100
+#define VP_IDLE_TIMEOUT 200
 
-/**
+/*
  * OMAP3 Voltage controller SR parameters. TODO: Pass this info as part of
  * board data or PMIC data
  */
@@ -281,13 +282,32 @@ static void __init vp_configure(int vp_id)
 static void __init vp_reg_configure(int vp_id)
 {
 	if (cpu_is_omap34xx()) {
+		struct clk *sys_ck;
+		u32 sys_clk_speed, timeout_val;
+
 		vp_reg[vp_id].vp_offs = omap3_vp_offs[vp_id];
 		if (vp_id == VP1) {
+			/*
+			 * OMAP3430 has error gain varying btw higher and
+			 * lower opp's
+			 */
+			vp_reg[vp_id].vp_errorgain = (((get_vdd1_opp() > 2) ?
+					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+					OMAP3430_ERRORGAIN_SHIFT);
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP1_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP1_VLIMITTO_VDDMAX <<
 					OMAP3430_VDDMAX_SHIFT);
 		} else if (vp_id == VP2) {
+			/*
+			 * OMAP3430 has error gain varying btw higher and
+			 * lower opp's
+			 */
+			vp_reg[vp_id].vp_errorgain = (((get_vdd2_opp() > 2) ?
+					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+					OMAP3430_ERRORGAIN_SHIFT);
 			vp_reg[vp_id].vp_vddmin = (OMAP3_VP2_VLIMITTO_VDDMIN <<
 					OMAP3430_VDDMIN_SHIFT);
 			vp_reg[vp_id].vp_vddmax = (OMAP3_VP2_VLIMITTO_VDDMAX <<
@@ -299,8 +319,6 @@ static void __init vp_reg_configure(int vp_id)
 		}
 		vp_reg[vp_id].vp_erroroffset = (OMAP3_VP_CONFIG_ERROROFFSET <<
 					OMAP3430_INITVOLTAGE_SHIFT);
-		vp_reg[vp_id].vp_errorgain = (OMAP3_VP_CONFIG_ERRORGAIN <<
-					OMAP3430_ERRORGAIN_SHIFT);
 		vp_reg[vp_id].vp_smpswaittimemin =
 					(OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN <<
 					OMAP3430_SMPSWAITTIMEMIN_SHIFT);
@@ -311,7 +329,18 @@ static void __init vp_reg_configure(int vp_id)
 					OMAP3430_VSTEPMIN_SHIFT);
 		vp_reg[vp_id].vp_stepmax = (OMAP3_VP_VSTEPMAX_VSTEPMAX <<
 					OMAP3430_VSTEPMAX_SHIFT);
-		vp_reg[vp_id].vp_timeout = (OMAP3_VP_VLIMITTO_TIMEOUT <<
+		/*
+		 * Use sys clk speed to convet the VP timeout in us to no of
+		 * clock cycles
+		 */
+		sys_ck = clk_get(NULL, "sys_ck");
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
@@ -338,7 +367,12 @@ static int vc_bypass_scale_voltage(u32 vdd, u8 target_vsel, u8 current_vsel)
 		vc_cmdval0 |= (target_vsel << VC_CMD_ON_SHIFT);
 		voltage_write_reg(vc_reg.vc_cmdval0_reg, vc_cmdval0);
 		reg_addr = R_VDD1_SR_CONTROL;
-
+		/* OMAP3430 has errorgain varying btw higher and lower opp's */
+		if (cpu_is_omap34xx())
+			vp_reg[vdd].vp_errorgain = (((get_vdd1_opp() > 2) ?
+					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+					OMAP3430_ERRORGAIN_SHIFT);
 	} else if (vdd == VDD2_OPP) {
 		u32 vc_cmdval1;
 
@@ -347,12 +381,29 @@ static int vc_bypass_scale_voltage(u32 vdd, u8 target_vsel, u8 current_vsel)
 		vc_cmdval1 |= (target_vsel << VC_CMD_ON_SHIFT);
 		voltage_write_reg(vc_reg.vc_cmdval1_reg, vc_cmdval1);
 		reg_addr = R_VDD2_SR_CONTROL;
+		/* OMAP3430 has errorgain varying btw higher and lower opp's */
+		if (cpu_is_omap34xx())
+			vp_reg[vdd].vp_errorgain = (((get_vdd2_opp() > 2) ?
+					(OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP) :
+					(OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP)) <<
+					OMAP3430_ERRORGAIN_SHIFT);
 	} else {
 		pr_warning("Wrong VDD passed in vc_bypass_scale_voltage %d\n",
 				vdd);
 		return false;
 	}
 
+	/* OMAP3430 has errorgain varying btw higher and lower opp's */
+	if (cpu_is_omap34xx()) {
+		u32 errorgain =
+			voltage_read_reg(vp_reg[vdd - 1].vp_offs.
+				vp_vpconfig_reg);
+		errorgain &= ~VP_ERRORGAIN_MASK;
+		errorgain |= vp_reg[vdd].vp_errorgain;
+
+		voltage_write_reg(vp_reg[vdd - 1].vp_offs.vp_vpconfig_reg,
+				errorgain);
+	}
 	vc_bypass_value = (target_vsel << VC_DATA_SHIFT) |
 			(reg_addr << VC_REGADDR_SHIFT) |
 			(R_SRI2C_SLAVE_ADDR << VC_SLAVEADDR_SHIFT);
@@ -419,6 +470,10 @@ void omap_voltageprocessor_enable(int vp_id)
 {
 	u32 vpconfig;
 
+	/* If VP is already enabled, do nothing. Return */
+	if (voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg) &
+				VP_CONFIG_VPENABLE)
+		return;
 	/*
 	 * This latching is required only if VC bypass method is used for
 	 * voltage scaling during dvfs.
@@ -439,21 +494,29 @@ void omap_voltageprocessor_enable(int vp_id)
  */
 void omap_voltageprocessor_disable(int vp_id)
 {
-	int i = 0;
 	u32 vpconfig;
+	int timeout = 0;
 
-	/* Wait for VP idle before disabling VP */
-	while ((!voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_status_reg)) &&
-				i++ < MAX_TRIES)
-		udelay(1);
-
-	if (i >= MAX_TRIES)
-		pr_warning("VP1 not idle, still going ahead with \
-						VP1 disable\n");
-	/* Disable VP1 */
+	/* If VP is already disabled, do nothing. Return */
+	if (!(voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg) &
+				VP_CONFIG_VPENABLE))
+		return;
+	/* Disable VP */
 	vpconfig = voltage_read_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg);
 	vpconfig &= ~VP_CONFIG_VPENABLE;
 	voltage_write_reg(vp_reg[vp_id - 1].vp_offs.vp_vpconfig_reg, vpconfig);
+
+	/*
+	 * Wait for VP idle Typical latency is <2us. Maximum latency is ~100us
+	 */
+	while ((timeout++ < VP_IDLE_TIMEOUT) &&
+			(!(voltage_read_reg(vp_reg[vp_id - 1].vp_offs
+			.vp_status_reg))))
+		udelay(1);
+
+	if (timeout >= VP_IDLE_TIMEOUT)
+		pr_warning("VP%d idle timedout\n", vp_id);
+	return;
 }
 
 /**
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 64c506c..c3203c9 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -22,6 +22,7 @@ extern int get_vdd2_opp(void);
 #define VP_CONFIG_INITVDD	OMAP3430_INITVDD
 #define VP_FORCEUPDATE		OMAP3430_FORCEUPDATE
 #define VP_CONFIG_VPENABLE	OMAP3430_VPENABLE
+#define VP_ERRORGAIN_MASK	OMAP3430_ERRORGAIN_MASK
 #define VP_INITVOLTAGE_MASK	OMAP3430_INITVOLTAGE_MASK
 #define VP_INITVOLTAGE_SHIFT	OMAP3430_INITVOLTAGE_SHIFT
 
@@ -52,16 +53,17 @@ extern int get_vdd2_opp(void);
  * board file or PMIC data structure
  */
 #define OMAP3_VP_CONFIG_ERROROFFSET		0x00
-#define OMAP3_VP_CONFIG_ERRORGAIN		0x20
-#define	OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x01F4
+#define OMAP3_VP_CONFIG_ERRORGAIN_LOWOPP	0x0C
+#define OMAP3_VP_CONFIG_ERRORGAIN_HIGHOPP	0x18
+#define	OMAP3_VP_VSTEPMIN_SMPSWAITTIMEMIN	0x3C
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

