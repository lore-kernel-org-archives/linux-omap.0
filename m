From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 04/06] OMAP3: PM: Put optimal SMPS stabilization delay
Date: Thu, 28 May 2009 18:13:05 +0530
Message-ID: <1243514587-5323-4-git-send-email-rnayak@ti.com>
References: <1243514587-5323-1-git-send-email-rnayak@ti.com>
 <1243514587-5323-2-git-send-email-rnayak@ti.com>
 <1243514587-5323-3-git-send-email-rnayak@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58677 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759163AbZE1MnO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 May 2009 08:43:14 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4SChA6Q024741
	for <linux-omap@vger.kernel.org>; Thu, 28 May 2009 07:43:16 -0500
In-Reply-To: <1243514587-5323-3-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Rajendra Nayak <rnayak@ti.com>

This patch removes the worst case T2 SMPS stabilization delay
of 360 us (needed for a 0v to 1.35 switch) and adds calculated
delay based on the actual volatge switch.
The delay is based on the T2 SMPS slew rate of 4mV/uS.
Each step based on VSEL difference corresponds to 12.5 mv

Hence the formula used:
delay = (steps * 12.5)/4 + (2 us of buffer).

This also adds a SMPS stabilization delay in the sr_reset_voltage()
function which seems to be needed.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/resource34xx.c |    9 ++++--
 arch/arm/mach-omap2/resource34xx.h |    2 +-
 arch/arm/mach-omap2/smartreflex.c  |   48 ++++++++++++++++++++++++++++-------
 arch/arm/mach-omap2/smartreflex.h  |    2 +-
 4 files changed, 46 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index 4c87436..82405b6 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -258,6 +258,7 @@ static int program_opp_freq(int res, int target_level, int current_level)
 #ifdef CONFIG_PM
 	omap3_save_scratchpad_contents();
 #endif
+
 	*curr_opp = target_level;
 	return target_level;
 }
@@ -267,9 +268,10 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 {
 	int i, ret = 0, raise;
 #ifdef CONFIG_OMAP_SMARTREFLEX
-	unsigned long t_opp;
+	unsigned long t_opp, c_opp;
 
 	t_opp = ID_VDD(res) | ID_OPP_NO(opp[target_level].opp_id);
+	c_opp = ID_VDD(res) | ID_OPP_NO(opp[current_level].opp_id);
 #endif
 	if (target_level > current_level)
 		raise = 1;
@@ -282,8 +284,9 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 					current_level);
 #ifdef CONFIG_OMAP_SMARTREFLEX
 		else
-			sr_voltagescale_vcbypass(t_opp,
-					opp[target_level].vsel);
+			sr_voltagescale_vcbypass(t_opp, c_opp,
+				opp[target_level].vsel,
+				opp[current_level].vsel);
 #endif
 	}
 
diff --git a/arch/arm/mach-omap2/resource34xx.h b/arch/arm/mach-omap2/resource34xx.h
index 8d95a00..a160665 100644
--- a/arch/arm/mach-omap2/resource34xx.h
+++ b/arch/arm/mach-omap2/resource34xx.h
@@ -28,7 +28,7 @@
 #include <mach/omap-pm.h>
 #include <mach/omap34xx.h>
 
-extern int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
+extern int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
 
 /*
  * mpu_latency/core_latency are used to control the cpuidle C state.
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 422c917..a2fe00e 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -449,6 +449,9 @@ static int sr_reset_voltage(int srid)
 	u32 reg_addr = 0;
 	u32 loop_cnt = 0, retries_cnt = 0;
 	u32 vc_bypass_value;
+	u32 t2_smps_steps = 0;
+	u32 t2_smps_delay = 0;
+	u32 prm_vp1_voltage, prm_vp2_voltage;
 
 	if (srid == SR1) {
 		target_opp_no = get_vdd1_opp();
@@ -458,6 +461,9 @@ static int sr_reset_voltage(int srid)
 		}
 		vsel = mpu_opps[target_opp_no].vsel;
 		reg_addr = R_VDD1_SR_CONTROL;
+		prm_vp1_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
+						OMAP3_PRM_VP1_VOLTAGE_OFFSET);
+		t2_smps_steps = abs(vsel - prm_vp1_voltage);
 	} else if (srid == SR2) {
 		target_opp_no = get_vdd2_opp();
 		if (!target_opp_no) {
@@ -466,6 +472,9 @@ static int sr_reset_voltage(int srid)
 		}
 		vsel = l3_opps[target_opp_no].vsel;
 		reg_addr = R_VDD2_SR_CONTROL;
+		prm_vp2_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
+						OMAP3_PRM_VP2_VOLTAGE_OFFSET);
+		t2_smps_steps = abs(vsel - prm_vp2_voltage);
 	}
 
 	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
@@ -493,6 +502,14 @@ static int sr_reset_voltage(int srid)
 		vc_bypass_value = prm_read_mod_reg(OMAP3430_GR_MOD,
 					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
 	}
+
+	/*
+	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
+	 *  2us added as buffer.
+	 */
+	t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
+	udelay(t2_smps_delay);
+
 	return 0;
 }
 
@@ -751,37 +768,43 @@ void disable_smartreflex(int srid)
 }
 
 /* Voltage Scaling using SR VCBYPASS */
-int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel)
+int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
+					u8 target_vsel, u8 current_vsel)
 {
 	int sr_status = 0;
-	u32 vdd, target_opp_no;
+	u32 vdd, target_opp_no, current_opp_no;
 	u32 vc_bypass_value;
 	u32 reg_addr = 0;
 	u32 loop_cnt = 0, retries_cnt = 0;
+	u32 t2_smps_steps = 0;
+	u32 t2_smps_delay = 0;
 
 	vdd = get_vdd(target_opp);
 	target_opp_no = get_opp_no(target_opp);
+	current_opp_no = get_opp_no(current_opp);
 
 	if (vdd == VDD1_OPP) {
 		sr_status = sr_stop_vddautocomap(SR1);
+		t2_smps_steps = abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
-					(vsel << OMAP3430_VC_CMD_ON_SHIFT),
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
+				(target_vsel << OMAP3430_VC_CMD_ON_SHIFT),
+				OMAP3430_GR_MOD,
+				OMAP3_PRM_VC_CMD_VAL_0_OFFSET);
 		reg_addr = R_VDD1_SR_CONTROL;
 
 	} else if (vdd == VDD2_OPP) {
 		sr_status = sr_stop_vddautocomap(SR2);
+		t2_smps_steps =  abs(target_vsel - current_vsel);
 
 		prm_rmw_mod_reg_bits(OMAP3430_VC_CMD_ON_MASK,
-					(vsel << OMAP3430_VC_CMD_ON_SHIFT),
-					OMAP3430_GR_MOD,
-					OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
+				(target_vsel << OMAP3430_VC_CMD_ON_SHIFT),
+				OMAP3430_GR_MOD,
+				OMAP3_PRM_VC_CMD_VAL_1_OFFSET);
 		reg_addr = R_VDD2_SR_CONTROL;
 	}
 
-	vc_bypass_value = (vsel << OMAP3430_DATA_SHIFT) |
+	vc_bypass_value = (target_vsel << OMAP3430_DATA_SHIFT) |
 			(reg_addr << OMAP3430_REGADDR_SHIFT) |
 			(R_SRI2C_SLAVE_ADDR << OMAP3430_SLAVEADDR_SHIFT);
 
@@ -807,7 +830,12 @@ int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel)
 					OMAP3_PRM_VC_BYPASS_VAL_OFFSET);
 	}
 
-	udelay(T2_SMPS_UPDATE_DELAY);
+	/*
+	 *  T2 SMPS slew rate (min) 4mV/uS, step size 12.5mV,
+	 *  2us added as buffer.
+	 */
+	t2_smps_delay = ((t2_smps_steps * 125) / 40) + 2;
+	udelay(t2_smps_delay);
 
 	if (sr_status) {
 		if (vdd == VDD1_OPP)
diff --git a/arch/arm/mach-omap2/smartreflex.h b/arch/arm/mach-omap2/smartreflex.h
index 94e522b..2a0e823 100644
--- a/arch/arm/mach-omap2/smartreflex.h
+++ b/arch/arm/mach-omap2/smartreflex.h
@@ -245,7 +245,7 @@ extern u32 current_vdd2_opp;
 #ifdef CONFIG_OMAP_SMARTREFLEX
 void enable_smartreflex(int srid);
 void disable_smartreflex(int srid);
-int sr_voltagescale_vcbypass(u32 target_opp, u8 vsel);
+int sr_voltagescale_vcbypass(u32 t_opp, u32 c_opp, u8 t_vsel, u8 c_vsel);
 void sr_start_vddautocomap(int srid, u32 target_opp_no);
 int sr_stop_vddautocomap(int srid);
 #else
-- 
1.5.4.7

