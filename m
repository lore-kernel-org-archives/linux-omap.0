From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 02/05] OMAP3: SR: Update VDD1/2 voltages at boot
Date: Wed, 18 Mar 2009 15:25:24 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAEDE849@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54934 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbZCRJzf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Mar 2009 05:55:35 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2I9tQcR017768
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 04:55:32 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2I9tQDR022092
	for <linux-omap@vger.kernel.org>; Wed, 18 Mar 2009 15:25:26 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

Currently vdd1 and vdd2 voltages are updated only after OMAP wakes up
from RET/OFF. This patch forces update according to boot OPP on boot.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/smartreflex.c |   82 +++++++++++++++++++++-----------------
 1 files changed, 46 insertions(+), 36 deletions(-)

Index: linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:24.906271669 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/smartreflex.c	2009-03-18 13:56:25.610250244 +0530
@@ -31,15 +31,12 @@
 #include <mach/control.h>
 #include <mach/clock.h>
 #include <mach/omap-pm.h>
+#include <mach/resource.h>
 
 #include "prm.h"
 #include "smartreflex.h"
 #include "prm-regbits-34xx.h"
 
-/* XXX: These should be relocated where-ever the OPP implementation will be */
-u32 current_vdd1_opp;
-u32 current_vdd2_opp;
-
 struct omap_sr {
 	int		srid;
 	int		is_sr_reset;
@@ -253,9 +250,11 @@ static void sr_configure_vp(int srid)
 	u32 vpconfig;
 
 	if (srid == SR1) {
-		vpconfig = PRM_VP1_CONFIG_ERROROFFSET | PRM_VP1_CONFIG_ERRORGAIN
-					| PRM_VP1_CONFIG_INITVOLTAGE
-					| PRM_VP1_CONFIG_TIMEOUTEN;
+		vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
+			PRM_VP1_CONFIG_ERRORGAIN |
+			PRM_VP1_CONFIG_TIMEOUTEN |
+			mpu_opps[resource_get_level("vdd1_opp")].vsel <<
+			OMAP3430_INITVOLTAGE_SHIFT;
 
 		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP1_CONFIG_OFFSET);
@@ -277,15 +276,25 @@ static void sr_configure_vp(int srid)
 
 		/* Trigger initVDD value copy to voltage processor */
 		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_CONFIG_OFFSET);
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
+
 		/* Clear initVDD copy trigger bit */
 		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP1_CONFIG_OFFSET);
+				       OMAP3_PRM_VP1_CONFIG_OFFSET);
+
+		/* Force update of voltage */
+		prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP1_CONFIG_OFFSET);
+		/* Clear force bit */
+		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP1_CONFIG_OFFSET);
 
 	} else if (srid == SR2) {
-		vpconfig = PRM_VP2_CONFIG_ERROROFFSET | PRM_VP2_CONFIG_ERRORGAIN
-					| PRM_VP2_CONFIG_INITVOLTAGE
-					| PRM_VP2_CONFIG_TIMEOUTEN;
+		vpconfig = PRM_VP2_CONFIG_ERROROFFSET |
+			PRM_VP2_CONFIG_ERRORGAIN |
+			PRM_VP2_CONFIG_TIMEOUTEN |
+			l3_opps[resource_get_level("vdd2_opp")].vsel <<
+			OMAP3430_INITVOLTAGE_SHIFT;
 
 		prm_write_mod_reg(vpconfig, OMAP3430_GR_MOD,
 					OMAP3_PRM_VP2_CONFIG_OFFSET);
@@ -306,11 +315,19 @@ static void sr_configure_vp(int srid)
 					OMAP3_PRM_VP2_VLIMITTO_OFFSET);
 
 		/* Trigger initVDD value copy to voltage processor */
-		prm_set_mod_reg_bits(PRM_VP2_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_CONFIG_OFFSET);
-		/* Reset initVDD copy trigger bit */
-		prm_clear_mod_reg_bits(PRM_VP2_CONFIG_INITVDD, OMAP3430_GR_MOD,
-					OMAP3_PRM_VP2_CONFIG_OFFSET);
+		prm_set_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
+
+		/* Clear initVDD copy trigger bit */
+		prm_clear_mod_reg_bits(PRM_VP1_CONFIG_INITVDD, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP2_CONFIG_OFFSET);
+
+		/* Force update of voltage */
+		prm_set_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				     OMAP3_PRM_VP2_CONFIG_OFFSET);
+		/* Clear force bit */
+		prm_clear_mod_reg_bits(OMAP3430_FORCEUPDATE, OMAP3430_GR_MOD,
+				       OMAP3_PRM_VP2_CONFIG_OFFSET);
 
 	}
 }
@@ -550,9 +567,9 @@ void enable_smartreflex(int srid)
 			sr_clk_enable(sr);
 
 			if (srid == SR1)
-				target_opp_no = get_opp_no(current_vdd1_opp);
+				target_opp_no = resource_get_level("vdd1_opp");
 			else if (srid == SR2)
-				target_opp_no = get_opp_no(current_vdd2_opp);
+				target_opp_no = resource_get_level("vdd2_opp");
 
 			sr_configure(sr);
 
@@ -684,7 +701,7 @@ static ssize_t omap_sr_vdd1_autocomp_sto
 		return -EINVAL;
 	}
 
-	current_vdd1opp_no = get_opp_no(current_vdd1_opp);
+	current_vdd1opp_no = resource_get_level("vdd1_opp");
 
 	if (value == 0)
 		sr_stop_vddautocomap(SR1);
@@ -722,7 +739,7 @@ static ssize_t omap_sr_vdd2_autocomp_sto
 		return -EINVAL;
 	}
 
-	current_vdd2opp_no = get_opp_no(current_vdd2_opp);
+	current_vdd2opp_no = resource_get_level("vdd2_opp");
 
 	if (value == 0)
 		sr_stop_vddautocomap(SR2);
@@ -748,13 +765,14 @@ static int __init omap3_sr_init(void)
 	int ret = 0;
 	u8 RdReg;
 
-	if (omap_rev() > OMAP3430_REV_ES1_0) {
-		current_vdd1_opp = PRCM_VDD1_OPP3;
-		current_vdd2_opp = PRCM_VDD2_OPP3;
-	} else {
-		current_vdd1_opp = PRCM_VDD1_OPP1;
-		current_vdd2_opp = PRCM_VDD1_OPP1;
-	}
+	/* Enable SR on T2 */
+	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
+					R_DCDC_GLOBAL_CFG);
+
+	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
+	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
+					R_DCDC_GLOBAL_CFG);
+
 	if (cpu_is_omap34xx()) {
 		sr1.clk = clk_get(NULL, "sr1_fck");
 		sr2.clk = clk_get(NULL, "sr2_fck");
@@ -769,14 +787,6 @@ static int __init omap3_sr_init(void)
 	sr_set_nvalues(&sr2);
 	sr_configure_vp(SR2);
 
-	/* Enable SR on T2 */
-	ret = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &RdReg,
-					R_DCDC_GLOBAL_CFG);
-
-	RdReg |= DCDC_GLOBAL_CFG_ENABLE_SRFLX;
-	ret |= twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER, RdReg,
-					R_DCDC_GLOBAL_CFG);
-
 	printk(KERN_INFO "SmartReflex driver initialized\n");
 
 	ret = sysfs_create_file(power_kobj, &sr_vdd1_autocomp.attr);