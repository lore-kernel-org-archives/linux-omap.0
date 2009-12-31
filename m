From: Romit Dasgupta <romit@ti.com>
Subject: [PATCH 9/10] OPP layer and additional cleanups
Date: Thu, 31 Dec 2009 18:59:36 +0530
Message-ID: <1262266176.20175.185.camel@boson>
Reply-To: romit@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:47340 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752289AbZLaN3n (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 31 Dec 2009 08:29:43 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: paul@pwsan.com, nm@ti.com, khilman@deeprootsystems.com
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

1. Localized the OPP id to smartreflex driver. This is still very ugly but it
   should be cleaned up during the smartreflex driver overhaul.

2. Register the SR voltage scaling function to the system so that it can use
   this for voltage scaling.

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index d341857..8c33bb8 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -3,6 +3,9 @@
  *
  * OMAP34XX SmartReflex Voltage Control
  *
+ * Copyright (C) 2009 Texas Instruments, Inc.
+ * Romit Dasgupta <romit@ti.com>
+ *
  * Copyright (C) 2008 Nokia Corporation
  * Kalle Jokiniemi
  *
@@ -30,6 +33,7 @@
 #include <plat/omap34xx.h>
 #include <plat/control.h>
 #include <plat/clock.h>
+#include <plat/resource.h>
 #include <plat/opp.h>
 #include <plat/opp_twl_tps.h>
 
@@ -44,9 +48,7 @@ struct omap_sr {
 	int		is_sr_reset;
 	int		is_autocomp_active;
 	struct clk	*clk;
-	struct clk	*vdd_opp_clk;
 	u32		clk_length;
-	u32		req_opp_no;
 	u32		opp1_nvalue, opp2_nvalue, opp3_nvalue, opp4_nvalue;
 	u32		opp5_nvalue;
 	u32		senp_mod, senn_mod;
@@ -54,6 +56,58 @@ struct omap_sr {
 	void __iomem	*vpbase_addr;
 };
 
+/*
+ *XXX: !!! Ugly Alert !!!
+ * Note: OPP id is a concept local to Smart reflex. So we want this to be
+ * only in Smartreflex driver.
+ * The hard coding should away when the SR driver is overhauled with a platform
+ * specific part. We can then supply the OPP id on a per platform
+ * basis. I would emphasize here that OPP id is a concept that only
+ * Smartreflex is concerned.
+ */
+
+static unsigned int freq_to_oppid(unsigned int sr, unsigned long freq)
+{
+	if (sr == SR1) {
+		if (cpu_is_omap3630()) {
+			if (freq > 0 && freq <= 300000000)
+				return 1;
+			if (freq > 300000000 && freq <= 600000000)
+				return 2;
+			if (freq > 600000000 && freq <= 800000000)
+				return 3;
+			if (freq > 800000000 && freq <= 1000000000)
+				return 4;
+		} else {
+			if (freq > 0 && freq <= 125000000)
+				return 1;
+			if (freq > 125000000 && freq <= 250000000)
+				return 2;
+			if (freq > 250000000 && freq <= 500000000)
+				return 3;
+			if (freq > 500000000 && freq <= 550000000)
+				return 4;
+			if (freq > 550000000 && freq <= 600000000)
+				return 5;
+		}
+	} else if (sr == SR2) {
+		if (cpu_is_omap3630()) {
+			if (freq > 0 && freq <= 100000000)
+				return 1;
+			if (freq > 100000000 && freq <= 200000000)
+				return 2;
+		} else {
+			if (freq > 0 && freq <= 83000000)
+				return 2;
+			if (freq > 83000000 && freq <= 166000000)
+				return 3;
+		}
+	}
+
+	return 0;
+}
+
+
 #define SR_REGADDR(offs)	(sr->srbase_addr + offset)
 
 static inline void sr_write_reg(struct omap_sr *sr, unsigned offset, u32 value)
@@ -147,37 +201,6 @@ static u32 cal_test_nvalue(u32 sennval, u32 senpval)
 		(rnsenn << NVALUERECIPROCAL_RNSENN_SHIFT);
 }
 
-static u8 get_vdd1_opp(void)
-{
-	struct omap_opp *opp;
-
-	if (sr1.vdd_opp_clk == NULL || IS_ERR(sr1.vdd_opp_clk) ||
-							mpu_opps == NULL)
-		return 0;
-
-	opp = opp_find_freq_exact(mpu_opps, sr1.vdd_opp_clk->rate, true);
-	if (IS_ERR(opp))
-		return 0;
-
-	return opp_get_opp_id(opp);
-}
-
-static u8 get_vdd2_opp(void)
-{
-	struct omap_opp *opp;
-
-	if (sr2.vdd_opp_clk == NULL || IS_ERR(sr2.vdd_opp_clk) ||
-							l3_opps == NULL)
-		return 0;
-
-	opp = opp_find_freq_exact(l3_opps, sr2.vdd_opp_clk->rate, true);
-	if (IS_ERR(opp))
-		return 0;
-
-	return opp_get_opp_id(opp);
-}
-
-
 static void sr_set_clk_length(struct omap_sr *sr)
 {
 	struct clk *sys_ck;
@@ -281,22 +304,17 @@ static void sr_set_nvalues(struct omap_sr *sr)
 
 static void sr_configure_vp(int srid)
 {
-	u32 vpconfig;
-	u32 vsel;
-	int uvdc;
-	u32 target_opp_no;
-	struct omap_opp *opp;
+	u32 vpconfig, curr_freq;
+	u8 vsel;
+	struct omap_opp *curr_opp = NULL;
 
 	if (srid == SR1) {
-		target_opp_no = get_vdd1_opp();
-		if (!target_opp_no)
-			target_opp_no = VDD1_OPP3;
-
-		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
-		BUG_ON(!opp); /* XXX ugh */
+		curr_freq = resource_get_level("mpu_freq");
+		curr_opp = find_opp_by_freq(OPP_MPU, curr_freq,
+						OPP_EQ | OPP_ENABLED);
+		BUG_ON(!curr_opp);
 
-		uvdc = opp_get_voltage(opp);
-		vsel = omap_twl_uv_to_vsel(uvdc);
+		vsel = omap_twl_uv_to_vsel(opp_to_volt(curr_opp));
 
 		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
 			PRM_VP1_CONFIG_ERRORGAIN |
@@ -337,15 +355,12 @@ static void sr_configure_vp(int srid)
 				       OMAP3_PRM_VP1_CONFIG_OFFSET);
 
 	} else if (srid == SR2) {
-		target_opp_no = get_vdd2_opp();
-		if (!target_opp_no)
-			target_opp_no = VDD2_OPP3;
-
-		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
-		BUG_ON(!opp); /* XXX ugh */
+		curr_freq = resource_get_level("l3_freq");
+		curr_opp = find_opp_by_freq(OPP_L3, curr_freq,
+						OPP_EQ | OPP_ENABLED);
+		BUG_ON(!curr_opp);
 
-		uvdc = opp_get_voltage(opp);
-		vsel = omap_twl_uv_to_vsel(uvdc);
+		vsel = omap_twl_uv_to_vsel(opp_to_volt(curr_opp));
 
 		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
 			PRM_VP2_CONFIG_ERRORGAIN |
@@ -437,47 +452,31 @@ static void sr_configure(struct omap_sr *sr)
 
 static int sr_reset_voltage(int srid)
 {
-	struct omap_opp *opp;
-	unsigned long uvdc;
-	u32 target_opp_no, vsel = 0;
-	u32 reg_addr = 0;
-	u32 loop_cnt = 0, retries_cnt = 0;
-	u32 vc_bypass_value;
-	u32 t2_smps_steps = 0;
-	u32 t2_smps_delay = 0;
+	u32 vsel = 0;
+	u32 reg_addr = 0, loop_cnt = 0, retries_cnt = 0;
+	u32 vc_bypass_value, t2_smps_steps = 0, t2_smps_delay = 0;
+	u32 curr_freq = 0;
 	u32 prm_vp1_voltage, prm_vp2_voltage;
+	struct omap_opp *curr_opp = NULL;
 
 	if (srid == SR1) {
-		target_opp_no = get_vdd1_opp();
-		if (!target_opp_no) {
-			pr_info("Current OPP unknown: Cannot reset voltage\n");
-			return 1;
-		}
+		curr_freq = resource_get_level("mpu_freq");
+		curr_opp = find_opp_by_freq(OPP_MPU, curr_freq,
+						OPP_EQ | OPP_ENABLED);
+		BUG_ON(!curr_opp);
 
-		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
-		if (!opp)
-			return 1;
-
-		uvdc = opp_get_voltage(opp);
-		vsel = omap_twl_uv_to_vsel(uvdc);
+		vsel = omap_twl_uv_to_vsel(opp_to_volt(curr_opp));
 
 		reg_addr = R_VDD1_SR_CONTROL;
 		prm_vp1_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
 						OMAP3_PRM_VP1_VOLTAGE_OFFSET);
 		t2_smps_steps = abs(vsel - prm_vp1_voltage);
 	} else if (srid == SR2) {
-		target_opp_no = get_vdd2_opp();
-		if (!target_opp_no) {
-			pr_info("Current OPP unknown: Cannot reset voltage\n");
-			return 1;
-		}
-
-		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
-		if (!opp)
-			return 1;
-
-		uvdc = opp_get_voltage(opp);
-		vsel = omap_twl_uv_to_vsel(uvdc);
+		curr_freq = resource_get_level("l3_freq");
+		curr_opp = find_opp_by_freq(OPP_L3, curr_freq,
+						OPP_EQ | OPP_ENABLED);
+		BUG_ON(!curr_opp);
+		vsel = omap_twl_uv_to_vsel(opp_to_volt(curr_opp));
 
 		reg_addr = R_VDD2_SR_CONTROL;
 		prm_vp2_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
@@ -521,22 +520,20 @@ static int sr_reset_voltage(int srid)
 	return 0;
 }
 
-static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
+static int sr_enable(struct omap_sr *sr, u32 target_freq)
 {
-	u32 nvalue_reciprocal, v;
-	struct omap_opp *opp;
-	int uvdc;
-	char vsel;
+	u32 nvalue_reciprocal, v, target_opp_id;
+	struct omap_opp *target_opp;
+	u8 vsel;
 
-	if (!(mpu_opps && l3_opps)) {
-		pr_notice("VSEL values not found\n");
-		return false;
-	}
+	if (sr->srid == SR1) {
+		target_opp = find_opp_by_freq(OPP_MPU, target_freq,
+						OPP_EQ | OPP_ENABLED);
+		BUG_ON(!target_opp);
 
-	sr->req_opp_no = target_opp_no;
+		target_opp_id = freq_to_oppid(SR1, target_freq);
 
-	if (sr->srid == SR1) {
-		switch (target_opp_no) {
+		switch (target_opp_id) {
 		case 5:
 			nvalue_reciprocal = sr->opp5_nvalue;
 			break;
@@ -557,11 +554,14 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			break;
 		}
 
-		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
-		if (!opp)
-			return false;
 	} else {
-		switch (target_opp_no) {
+		target_opp = find_opp_by_freq(OPP_L3, target_freq,
+						OPP_EQ | OPP_ENABLED);
+		BUG_ON(!target_opp);
+
+		target_opp_id = freq_to_oppid(SR2, target_freq);
+
+		switch (target_opp_id) {
 		case 3:
 			nvalue_reciprocal = sr->opp3_nvalue;
 			break;
@@ -576,14 +576,11 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			break;
 		}
 
-		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
-		if (!opp)
-			return false;
 	}
 
 	if (nvalue_reciprocal == 0) {
 		pr_notice("OPP%d doesn't support SmartReflex\n",
-								target_opp_no);
+								target_opp_id);
 		return false;
 	}
 
@@ -594,8 +591,7 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
 
-	uvdc = opp_get_voltage(opp);
-	vsel = omap_twl_uv_to_vsel(uvdc);
+	vsel = omap_twl_uv_to_vsel(opp_to_volt(target_opp));
 
 	if (sr->srid == SR1) {
 		/* set/latch init voltage */
@@ -681,7 +677,7 @@ static void sr_disable(struct omap_sr *sr)
 }
 
 
-void sr_start_vddautocomap(int srid, u32 target_opp_no)
+void sr_start_vddautocomap(int srid, u32 target_freq)
 {
 	struct omap_sr *sr = NULL;
 
@@ -698,7 +694,7 @@ void sr_start_vddautocomap(int srid, u32 target_opp_no)
 	}
 
 	sr->is_autocomp_active = 1;
-	if (!sr_enable(sr, target_opp_no)) {
+	if (!sr_enable(sr, target_freq)) {
 		sr->is_autocomp_active = 0;
 		if (sr->is_sr_reset == 1)
 			sr_clk_disable(sr);
@@ -732,8 +728,8 @@ EXPORT_SYMBOL(sr_stop_vddautocomap);
 
 void enable_smartreflex(int srid)
 {
-	u32 target_opp_no = 0;
 	struct omap_sr *sr = NULL;
+	unsigned long curr_freq = 0;
 
 	if (srid == SR1)
 		sr = &sr1;
@@ -748,18 +744,18 @@ void enable_smartreflex(int srid)
 			sr_clk_enable(sr);
 
 			if (srid == SR1)
-				target_opp_no = get_vdd1_opp();
+				curr_freq = resource_get_level("mpu_freq");
 			else if (srid == SR2)
-				target_opp_no = get_vdd2_opp();
+				curr_freq = resource_get_level("l3_freq");
 
-			if (!target_opp_no) {
+			if (!curr_freq) {
 				pr_info("Current OPP unknown \
 						 Cannot configure SR\n");
 			}
 
 			sr_configure(sr);
 
-			if (!sr_enable(sr, target_opp_no))
+			if (!sr_enable(sr, curr_freq))
 				sr_clk_disable(sr);
 		}
 	}
@@ -826,22 +822,23 @@ void disable_smartreflex(int srid)
 }
 
 /* Voltage Scaling using SR VCBYPASS */
-int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
-					u8 target_vsel, u8 current_vsel)
+int sr_voltagescale_vcbypass(enum volt_rail rail, struct omap_opp *curr_opp,
+				struct omap_opp *target_opp)
 {
 	int sr_status = 0;
-	u32 vdd, target_opp_no, current_opp_no;
+	u8 current_vsel, target_vsel;
 	u32 vc_bypass_value;
 	u32 reg_addr = 0;
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 t2_smps_steps = 0;
 	u32 t2_smps_delay = 0;
 
-	vdd = get_vdd(target_opp);
-	target_opp_no = get_opp_no(target_opp);
-	current_opp_no = get_opp_no(current_opp);
+	BUG_ON(!rail || !curr_opp || !target_opp);
+
+	current_vsel = omap_twl_uv_to_vsel(opp_to_volt(curr_opp));
+	target_vsel = omap_twl_uv_to_vsel(opp_to_volt(target_opp));
 
-	if (vdd == VDD1_OPP) {
+	if (rail == RAIL_VDD1) {
 		sr_status = sr_stop_vddautocomap(SR1);
 		t2_smps_steps = abs(target_vsel - current_vsel);
 
@@ -851,7 +848,7 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 				OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
 		reg_addr = R_VDD1_SR_CONTROL;
 
-	} else if (vdd == VDD2_OPP) {
+	} else if (rail == RAIL_VDD2) {
 		sr_status = sr_stop_vddautocomap(SR2);
 		t2_smps_steps =  abs(target_vsel - current_vsel);
 
@@ -896,10 +893,10 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
 	udelay(t2_smps_delay);
 
 	if (sr_status) {
-		if (vdd == VDD1_OPP)
-			sr_start_vddautocomap(SR1, target_opp_no);
-		else if (vdd == VDD2_OPP)
-			sr_start_vddautocomap(SR2, target_opp_no);
+		if (rail == RAIL_VDD1)
+			sr_start_vddautocomap(SR1, opp_to_freq(target_opp));
+		else if (rail == RAIL_VDD2)
+			sr_start_vddautocomap(SR2, opp_to_freq(target_opp));
 	}
 
 	return 0;
@@ -926,12 +923,12 @@ static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
 	if (value == 0) {
 		sr_stop_vddautocomap(SR1);
 	} else {
-		u32 current_vdd1opp_no = get_vdd1_opp();
-		if (!current_vdd1opp_no) {
-			pr_err("sr_vdd1_autocomp: Current VDD1 opp unknown\n");
+		u32 current_freq = resource_get_level("mpu_freq");
+		if (!current_freq) {
+			pr_err("sr_vdd1_autocomp: Current MPU freq unknown\n");
 			return -EINVAL;
 		}
-		sr_start_vddautocomap(SR1, current_vdd1opp_no);
+		sr_start_vddautocomap(SR1, current_freq);
 	}
 	return n;
 }
@@ -966,12 +963,12 @@ static ssize_t omap_sr_vdd2_autocomp_store(struct kobject *kobj,
 	if (value == 0) {
 		sr_stop_vddautocomap(SR2);
 	} else {
-		u32 current_vdd2opp_no = get_vdd2_opp();
-		if (!current_vdd2opp_no) {
-			pr_err("sr_vdd2_autocomp: Current VDD2 opp unknown\n");
+		u32 current_freq = resource_get_level("l3_freq");
+		if (!current_freq) {
+			pr_err("sr_vdd2_autocomp: Current L3 freq unknown\n");
 			return -EINVAL;
 		}
-		sr_start_vddautocomap(SR2, current_vdd2opp_no);
+		sr_start_vddautocomap(SR2, current_freq);
 	}
 	return n;
 }
@@ -985,19 +982,17 @@ static struct kobj_attribute sr_vdd2_autocomp = {
 	.store = omap_sr_vdd2_autocomp_store,
 };
 
-
+static int __init register_sr_volt_scaling(void)
+{
+	pm_register_volt_scaling(sr_voltagescale_vcbypass);
+	return 0;
+}
 
 static int __init omap3_sr_init(void)
 {
 	int ret = 0;
 	u8 RdReg;
 
-	/* Exit if OPP tables are not defined */
-        if (!(mpu_opps && l3_opps)) {
-                pr_err("SR: OPP rate tables not defined for platform, not enabling SmartReflex\n");
-		return -ENODEV;
-        }
-
 	/* Enable SR on T2 */
 	ret = twl_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
 			      R_DCDC_GLOBAL_CFG);
@@ -1006,12 +1001,15 @@ static int __init omap3_sr_init(void)
 	ret |= twl_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
 				R_DCDC_GLOBAL_CFG);
 
+	if (ret) {
+		pr_err("SR: T2 write failed %d\n", ret);
+		return -EIO;
+	}
+
 	if (cpu_is_omap34xx()) {
 		sr1.clk = clk_get(NULL, "sr1_fck");
 		sr2.clk = clk_get(NULL, "sr2_fck");
 	}
-	sr1.vdd_opp_clk = clk_get(NULL, "dpll1_ck");
-	sr2.vdd_opp_clk = clk_get(NULL, "l3_ick");
 	sr_set_clk_length(&sr1);
 	sr_set_clk_length(&sr2);
 
@@ -1035,4 +1033,5 @@ static int __init omap3_sr_init(void)
 	return 0;
 }
 
+device_initcall(register_sr_volt_scaling);
 late_initcall(omap3_sr_init);
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 2a0e823..26f9de5 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -14,6 +14,9 @@
  * published by the Free Software Foundation.
  */
 
+#include <plat/opp.h>
+#include "pm.h"
+
 #define PHY_TO_OFF_PM_MASTER(p)		(p - 0x36)
 #define PHY_TO_OFF_PM_RECIEVER(p)	(p - 0x5b)
 #define PHY_TO_OFF_PM_INT(p)		(p - 0x2e)
@@ -227,10 +230,6 @@
 #define PRCM_NO_VDD2_OPPS	3
 /* XXX: end remove/move */
 
-/* XXX: find more appropriate place for these once DVFS is in place */
-extern u32 current_vdd1_opp;
-extern u32 current_vdd2_opp;
-
 #ifdef CONFIG_OMAP_SMARTREFLEX_TESTING
 #define SR_TESTING_NVALUES 	1
 #else
@@ -243,11 +242,10 @@ extern u32 current_vdd2_opp;
  * do anything.
  */
 #ifdef CONFIG_OMAP_SMARTREFLEX
-void enable_smartreflex(int srid);
-void disable_smartreflex(int srid);
-int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
-void sr_start_vddautocomap(int srid, u32 target_opp_no);
-int sr_stop_vddautocomap(int srid);
+extern void enable_smartreflex(int);
+extern void disable_smartreflex(int);
+extern void sr_start_vddautocomap(int, u32);
+extern int sr_stop_vddautocomap(int);
 #else
 static inline void enable_smartreflex(int srid) {}
 static inline void disable_smartreflex(int srid) {}


