From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 08/12] OMAP SR/SRF: use opp_find_opp_by_opp_id()
Date: Thu, 17 Dec 2009 17:47:38 -0700
Message-ID: <20091218004737.7694.36610.stgit@localhost.localdomain>
References: <20091218004617.7694.84525.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:46471 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755577AbZLRAsb (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 19:48:31 -0500
In-Reply-To: <20091218004617.7694.84525.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: nm@ti.com
Cc: linux-omap@vger.kernel.org

SmartReflex and SRF code should use opp_find_opp_by_opp_id() to find
OPP entries by the OPP ID.  This hides OPP layer details from SR/SRF code
and also allows the removal of the open-coded OPP traversal.
---
 arch/arm/mach-omap2/resource34xx.c |   30 ++++++++--------
 arch/arm/mach-omap2/smartreflex.c  |   66 ++++++++++++++++++++++++++++--------
 2 files changed, 66 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-omap2/resource34xx.c b/arch/arm/mach-omap2/resource34xx.c
index baa33c4..05e70b7 100644
--- a/arch/arm/mach-omap2/resource34xx.c
+++ b/arch/arm/mach-omap2/resource34xx.c
@@ -25,6 +25,7 @@
 #include <plat/powerdomain.h>
 #include <plat/clockdomain.h>
 #include <plat/omap34xx.h>
+#include <plat/opp_twl_tps.h>
 
 #include "smartreflex.h"
 #include "resource34xx.h"
@@ -157,10 +158,6 @@ static int curr_vdd1_opp;
 static int curr_vdd2_opp;
 static DEFINE_MUTEX(dvfs_mutex);
 
-/* Introducing deprecated function because we got to.. */
-#define IS_OPP_TERMINATOR(opps, i) (!(opps)[(i)].enabled &&	\
-		!(opps)[(i)].rate && !(opps)[(i)].vsel)
-
 /**
  * opp_to_freq - convert OPPID to frequency (DEPRECATED)
  * @freq: return frequency back to caller
@@ -175,20 +172,17 @@ static DEFINE_MUTEX(dvfs_mutex);
 static int __deprecated opp_to_freq(unsigned long *freq,
 		const struct omap_opp *opps, u8 opp_id)
 {
-	int i = 1;
+	struct omap_opp *opp;
 
 	BUG_ON(!freq || !opps);
 
-	/* The first entry is a dummy one, loop till we hit terminator */
-	while (!IS_OPP_TERMINATOR(opps, i)) {
-		if (opps[i].enabled && (opps[i].opp_id == opp_id)) {
-			*freq = opps[i].rate;
-			return 0;
-		}
-		i++;
-	}
+	opp = opp_find_by_opp_id(opps, opp_id);
+	if (!opp)
+		return -EINVAL;
 
-	return -EINVAL;
+	*freq = opp_get_freq(opp);
+
+	return 0;
 }
 
 /**
@@ -365,18 +359,22 @@ static int program_opp(int res, struct omap_opp *opp, int target_level,
 		else {
 			u8 vc, vt;
 			struct omap_opp *oppx;
+			unsigned long uvdc;
+
 			/*
 			 * transitioning from good to good OPP
 			 * none of the following should fail..
 			 */
 			oppx = opp_find_freq_exact(opp, freq, true);
 			BUG_ON(IS_ERR(oppx));
-			vt = oppx->vsel;
+			uvdc = opp_get_voltage(oppx);
+			vt = omap_twl_uv_to_vsel(uvdc);
 
 			BUG_ON(opp_to_freq(&freq, opp, current_level));
 			oppx = opp_find_freq_exact(opp, freq, true);
 			BUG_ON(IS_ERR(oppx));
-			vc = oppx->vsel;
+			uvdc = opp_get_voltage(oppx);
+			vc = omap_twl_uv_to_vsel(uvdc);
 
 			/* ok to scale.. */
 			sr_voltagescale_vcbypass(t_opp, c_opp, vt, vc);
diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
index 50332ae..e086f2d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -31,6 +31,7 @@
 #include <plat/control.h>
 #include <plat/clock.h>
 #include <plat/omap-pm.h>
+#include <plat/opp_twl_tps.h>
 
 #include "prm.h"
 #include "smartreflex.h"
@@ -282,15 +283,20 @@ static void sr_configure_vp(int srid)
 {
 	u32 vpconfig;
 	u32 vsel;
+	int uvdc;
 	u32 target_opp_no;
+	struct omap_opp *opp;
 
 	if (srid == SR1) {
 		target_opp_no = get_vdd1_opp();
 		if (!target_opp_no)
-			/* Assume Nominal OPP as current OPP unknown */
-			vsel = mpu_opps[VDD1_OPP3].vsel;
-		else
-			vsel = mpu_opps[target_opp_no].vsel;
+			target_opp_no = VDD1_OPP3;
+
+		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
+		BUG_ON(!opp); /* XXX ugh */
+
+		uvdc = opp_get_voltage(opp);
+		vsel = omap_twl_uv_to_vsel(uvdc);
 
 		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
 			PRM_VP1_CONFIG_ERRORGAIN |
@@ -333,10 +339,13 @@ static void sr_configure_vp(int srid)
 	} else if (srid == SR2) {
 		target_opp_no = get_vdd2_opp();
 		if (!target_opp_no)
-			/* Assume Nominal OPP */
-			vsel = l3_opps[VDD2_OPP3].vsel;
-		else
-			vsel = l3_opps[target_opp_no].vsel;
+			target_opp_no = VDD2_OPP3;
+
+		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
+		BUG_ON(!opp); /* XXX ugh */
+
+		uvdc = opp_get_voltage(opp);
+		vsel = omap_twl_uv_to_vsel(uvdc);
 
 		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
 			PRM_VP2_CONFIG_ERRORGAIN |
@@ -428,6 +437,8 @@ static void sr_configure(struct omap_sr *sr)
 
 static int sr_reset_voltage(int srid)
 {
+	struct omap_opp *opp;
+	unsigned long uvdc;
 	u32 target_opp_no, vsel = 0;
 	u32 reg_addr = 0;
 	u32 loop_cnt = 0, retries_cnt = 0;
@@ -442,7 +453,14 @@ static int sr_reset_voltage(int srid)
 			pr_info("Current OPP unknown: Cannot reset voltage\n");
 			return 1;
 		}
-		vsel = mpu_opps[target_opp_no].vsel;
+
+		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
+		if (!opp)
+			return 1;
+
+		uvdc = opp_get_voltage(opp);
+		vsel = omap_twl_uv_to_vsel(uvdc);
+
 		reg_addr = R_VDD1_SR_CONTROL;
 		prm_vp1_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
 						OMAP3_PRM_VP1_VOLTAGE_OFFSET);
@@ -453,7 +471,14 @@ static int sr_reset_voltage(int srid)
 			pr_info("Current OPP unknown: Cannot reset voltage\n");
 			return 1;
 		}
-		vsel = l3_opps[target_opp_no].vsel;
+
+		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
+		if (!opp)
+			return 1;
+
+		uvdc = opp_get_voltage(opp);
+		vsel = omap_twl_uv_to_vsel(uvdc);
+
 		reg_addr = R_VDD2_SR_CONTROL;
 		prm_vp2_voltage = prm_read_mod_reg(OMAP3430_GR_MOD,
 						OMAP3_PRM_VP2_VOLTAGE_OFFSET);
@@ -499,6 +524,9 @@ static int sr_reset_voltage(int srid)
 static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 {
 	u32 nvalue_reciprocal, v;
+	struct omap_opp *opp;
+	int uvdc;
+	char vsel;
 
 	if (!(mpu_opps && l3_opps)) {
 		pr_notice("VSEL values not found\n");
@@ -528,6 +556,10 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			nvalue_reciprocal = sr->opp3_nvalue;
 			break;
 		}
+
+		opp = opp_find_by_opp_id(mpu_opps, target_opp_no);
+		if (!opp)
+			return false;
 	} else {
 		switch (target_opp_no) {
 		case 3:
@@ -543,6 +575,10 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			nvalue_reciprocal = sr->opp3_nvalue;
 			break;
 		}
+
+		opp = opp_find_by_opp_id(l3_opps, target_opp_no);
+		if (!opp)
+			return false;
 	}
 
 	if (nvalue_reciprocal == 0) {
@@ -558,13 +594,16 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST),
 			(ERRCONFIG_VPBOUNDINTEN | ERRCONFIG_VPBOUNDINTST));
 
+	uvdc = opp_get_voltage(opp);
+	vsel = omap_twl_uv_to_vsel(uvdc);
+
 	if (sr->srid == SR1) {
 		/* set/latch init voltage */
 		v = prm_read_mod_reg(OMAP3430_GR_MOD,
 				     OMAP3_PRM_VP1_CONFIG_OFFSET);
 		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
-		v |= mpu_opps[target_opp_no].vsel <<
-			OMAP3430_INITVOLTAGE_SHIFT;
+
+		v |= vsel << OMAP3430_INITVOLTAGE_SHIFT;
 		prm_write_mod_reg(v, OMAP3430_GR_MOD,
 				  OMAP3_PRM_VP1_CONFIG_OFFSET);
 		/* write1 to latch */
@@ -581,8 +620,7 @@ static int sr_enable(struct omap_sr *sr, u32 target_opp_no)
 		v = prm_read_mod_reg(OMAP3430_GR_MOD,
 				     OMAP3_PRM_VP2_CONFIG_OFFSET);
 		v &= ~(OMAP3430_INITVOLTAGE_MASK | OMAP3430_INITVDD);
-		v |= l3_opps[target_opp_no].vsel <<
-			OMAP3430_INITVOLTAGE_SHIFT;
+		v |= vsel << OMAP3430_INITVOLTAGE_SHIFT;
 		prm_write_mod_reg(v, OMAP3430_GR_MOD,
 				  OMAP3_PRM_VP2_CONFIG_OFFSET);
 		/* write1 to latch */


